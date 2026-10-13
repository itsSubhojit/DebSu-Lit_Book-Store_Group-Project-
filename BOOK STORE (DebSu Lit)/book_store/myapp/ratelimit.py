import time
import logging
from functools import wraps
from django.core.cache import cache
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render
from django.contrib import messages

logger = logging.getLogger(__name__)

def get_client_ip(request):
    """
    Extracts the client IP address from request headers,
    taking into account proxies and reverse proxies (e.g. Render, Cloudflare).
    """
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        # First IP in the comma-separated list is the real client IP
        ip = x_forwarded_for.split(',')[0].strip()
    else:
        ip = request.META.get('REMOTE_ADDR', '127.0.0.1')
    return ip


def check_rate_limit(key: str, limit: int, period_seconds: int):
    """
    Cache-based sliding window / bucket rate limiter.
    
    :param key: Unique cache key identifying the action and client
    :param limit: Maximum allowed attempts within the window
    :param period_seconds: Duration of the rate limit window in seconds
    :return: (allowed: bool, remaining: int, retry_after: int)
    """
    now = time.time()
    try:
        # We store a list of timestamps in cache
        timestamps = cache.get(key, [])
        # Filter timestamps within the current sliding window
        valid_timestamps = [ts for ts in timestamps if now - ts < period_seconds]

        if len(valid_timestamps) >= limit:
            oldest_ts = valid_timestamps[0]
            retry_after = max(1, int(period_seconds - (now - oldest_ts)))
            return False, 0, retry_after

        # Record this attempt
        valid_timestamps.append(now)
        cache.set(key, valid_timestamps, timeout=period_seconds + 10)
        remaining = limit - len(valid_timestamps)
        return True, remaining, 0
    except Exception as e:
        logger.warning("Rate limiter cache error for key %s: %s", key, e)
        # Fail-open if cache is temporarily unavailable so legitimate users are not blocked
        return True, limit, 0


def record_failed_attempt(key: str, period_seconds: int = 300):
    """
    Increments a failed attempt counter (for progressive backoff / login protection).
    """
    try:
        current = cache.get(key, 0)
        cache.set(key, current + 1, timeout=period_seconds)
        return current + 1
    except Exception:
        return 1


def clear_failed_attempts(key: str):
    """
    Clears failed attempt counter on successful action.
    """
    try:
        cache.delete(key)
    except Exception:
        pass


def ratelimit_view(key_prefix: str, limit: int = 10, period_seconds: int = 60, is_json: bool = False):
    """
    Decorator for Django view functions to enforce rate limits per IP/user.
    """
    def decorator(view_func):
        @wraps(view_func)
        def _wrapped_view(request, *args, **kwargs):
            ip = get_client_ip(request)
            user_id = str(request.user.id) if request.user.is_authenticated else "anon"
            cache_key = f"rl:{key_prefix}:{ip}:{user_id}"

            allowed, remaining, retry_after = check_rate_limit(cache_key, limit, period_seconds)
            if not allowed:
                msg = f"Too many requests. Please wait {retry_after} second(s) before trying again."
                if is_json or request.headers.get('x-requested-with') == 'XMLHttpRequest':
                    return JsonResponse({
                        "status": "error",
                        "error": msg,
                        "retry_after": retry_after
                    }, status=429)
                messages.error(request, msg)
                return HttpResponse(status=429, content=f"<h3>429 Too Many Requests</h3><p>{msg}</p>")

            return view_func(request, *args, **kwargs)
        return _wrapped_view
    return decorator
