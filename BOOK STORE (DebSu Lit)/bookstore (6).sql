-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2025 at 09:26 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add user', 1, 'add_customuser'),
(2, 'Can change user', 1, 'change_customuser'),
(3, 'Can delete user', 1, 'delete_customuser'),
(4, 'Can view user', 1, 'view_customuser'),
(5, 'Can add log entry', 2, 'add_logentry'),
(6, 'Can change log entry', 2, 'change_logentry'),
(7, 'Can delete log entry', 2, 'delete_logentry'),
(8, 'Can view log entry', 2, 'view_logentry'),
(9, 'Can add permission', 3, 'add_permission'),
(10, 'Can change permission', 3, 'change_permission'),
(11, 'Can delete permission', 3, 'delete_permission'),
(12, 'Can view permission', 3, 'view_permission'),
(13, 'Can add group', 4, 'add_group'),
(14, 'Can change group', 4, 'change_group'),
(15, 'Can delete group', 4, 'delete_group'),
(16, 'Can view group', 4, 'view_group'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add student', 7, 'add_student'),
(26, 'Can change student', 7, 'change_student'),
(27, 'Can delete student', 7, 'delete_student'),
(28, 'Can view student', 7, 'view_student'),
(29, 'Can add category', 8, 'add_category'),
(30, 'Can change category', 8, 'change_category'),
(31, 'Can delete category', 8, 'delete_category'),
(32, 'Can view category', 8, 'view_category'),
(33, 'Can add item', 9, 'add_item'),
(34, 'Can change item', 9, 'change_item'),
(35, 'Can delete item', 9, 'delete_item'),
(36, 'Can view item', 9, 'view_item'),
(37, 'Can add cart item', 10, 'add_cartitem'),
(38, 'Can change cart item', 10, 'change_cartitem'),
(39, 'Can delete cart item', 10, 'delete_cartitem'),
(40, 'Can view cart item', 10, 'view_cartitem'),
(41, 'Can add order', 11, 'add_order'),
(42, 'Can change order', 11, 'change_order'),
(43, 'Can delete order', 11, 'delete_order'),
(44, 'Can view order', 11, 'view_order');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-04-02 14:38:58.206013', '1', 'Category object (1)', 1, '[{\"added\": {}}]', 8, 5),
(2, '2025-04-05 07:15:51.039884', '1', 'Category object (1)', 2, '[{\"changed\": {\"fields\": [\"Cat name\"]}}]', 8, 5),
(3, '2025-04-05 07:16:13.449401', '2', 'Category object (2)', 1, '[{\"added\": {}}]', 8, 5),
(4, '2025-04-05 07:16:34.266847', '3', 'Category object (3)', 1, '[{\"added\": {}}]', 8, 5),
(5, '2025-04-05 07:20:20.979126', '1', 'Item object (1)', 1, '[{\"added\": {}}]', 9, 5),
(6, '2025-04-05 07:35:22.262669', '2', 'Item object (2)', 1, '[{\"added\": {}}]', 9, 5),
(7, '2025-04-07 15:01:46.151383', '1', '1 x book1', 1, '[{\"added\": {}}]', 10, 5),
(8, '2025-04-08 07:16:50.840202', '2', 'Item object (2)', 3, '', 9, 5),
(9, '2025-04-08 07:16:50.845201', '1', 'Item object (1)', 3, '', 9, 5),
(10, '2025-04-08 07:19:43.552010', '3', 'Item object (3)', 1, '[{\"added\": {}}]', 9, 5),
(11, '2025-04-08 07:25:20.255141', '4', 'Item object (4)', 1, '[{\"added\": {}}]', 9, 5),
(12, '2025-04-08 13:19:56.397368', '2', 'Item object (2)', 2, '[{\"changed\": {\"fields\": [\"Name\", \"Description\", \"Author\", \"Publisher\", \"Pub date\", \"Price\", \"Edition\", \"B img\", \"Category\"]}}]', 9, 5),
(13, '2025-04-08 13:21:19.976924', '2', 'Item object (2)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(14, '2025-04-08 13:28:30.009952', '2', 'Item object (2)', 2, '[{\"changed\": {\"fields\": [\"Publisher\", \"Pub date\"]}}]', 9, 5),
(15, '2025-04-08 13:39:00.882629', '5', 'Item object (5)', 1, '[{\"added\": {}}]', 9, 5),
(16, '2025-04-08 13:41:56.441131', '6', 'Item object (6)', 1, '[{\"added\": {}}]', 9, 5),
(17, '2025-04-08 13:47:06.434355', '6', 'Item object (6)', 2, '[]', 9, 5),
(18, '2025-04-08 13:48:56.472993', '7', 'Item object (7)', 1, '[{\"added\": {}}]', 9, 5),
(19, '2025-04-08 13:50:48.721048', '8', 'Item object (8)', 1, '[{\"added\": {}}]', 9, 5),
(20, '2025-04-08 13:51:52.831265', '4', 'Thriller', 1, '[{\"added\": {}}]', 8, 5),
(21, '2025-04-08 13:55:07.461619', '9', 'Item object (9)', 1, '[{\"added\": {}}]', 9, 5),
(22, '2025-04-08 13:55:54.279244', '9', 'Item object (9)', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 9, 5),
(23, '2025-04-08 13:57:25.670972', '8', 'Item object (8)', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 9, 5),
(24, '2025-04-08 14:01:05.308349', '10', 'Item object (10)', 1, '[{\"added\": {}}]', 9, 5),
(25, '2025-04-08 14:03:43.357093', '11', 'Item object (11)', 1, '[{\"added\": {}}]', 9, 5),
(26, '2025-04-08 14:04:04.416883', '11', 'Item object (11)', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 9, 5),
(27, '2025-04-08 14:07:42.002474', '12', 'Item object (12)', 1, '[{\"added\": {}}]', 9, 5),
(28, '2025-04-08 14:09:43.252654', '13', 'Item object (13)', 1, '[{\"added\": {}}]', 9, 5),
(29, '2025-04-08 14:21:15.138304', '14', 'Item object (14)', 1, '[{\"added\": {}}]', 9, 5),
(30, '2025-04-08 14:24:52.165389', '15', 'Item object (15)', 1, '[{\"added\": {}}]', 9, 5),
(31, '2025-04-08 14:34:22.808308', '15', 'Item object (15)', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 9, 5),
(32, '2025-04-08 14:38:50.393948', '16', 'Item object (16)', 1, '[{\"added\": {}}]', 9, 5),
(33, '2025-04-08 14:49:46.905336', '17', 'Item object (17)', 1, '[{\"added\": {}}]', 9, 5),
(34, '2025-04-08 14:52:05.013761', '18', 'Item object (18)', 1, '[{\"added\": {}}]', 9, 5),
(35, '2025-04-08 14:54:51.733404', '19', 'Item object (19)', 1, '[{\"added\": {}}]', 9, 5),
(36, '2025-04-09 13:06:04.483802', '5', 'Item object (5)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(37, '2025-04-09 13:11:36.021271', '5', 'Item object (5)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(38, '2025-04-09 13:13:51.704226', '19', 'Item object (19)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(39, '2025-04-09 13:14:03.478926', '18', 'Item object (18)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(40, '2025-04-09 13:14:11.483263', '17', 'Item object (17)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(41, '2025-04-09 13:14:19.537256', '16', 'Item object (16)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(42, '2025-04-09 13:14:32.532719', '15', 'Item object (15)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(43, '2025-04-09 13:14:43.121599', '14', 'Item object (14)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(44, '2025-04-09 13:14:50.731070', '13', 'Item object (13)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(45, '2025-04-09 13:14:58.763551', '12', 'Item object (12)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(46, '2025-04-09 13:15:06.131407', '11', 'Item object (11)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(47, '2025-04-09 13:15:15.902944', '10', 'Item object (10)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(48, '2025-04-09 13:15:24.061297', '9', 'Item object (9)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(49, '2025-04-09 13:15:57.774948', '8', 'Item object (8)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(50, '2025-04-09 13:16:07.953728', '7', 'Item object (7)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(51, '2025-04-09 13:16:18.090505', '6', 'Item object (6)', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 5),
(52, '2025-04-09 15:04:21.561540', '5', 'Item object (5)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\", \"Binding\"]}}]', 9, 5),
(53, '2025-04-09 15:06:32.801377', '6', 'Item object (6)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\", \"Language\"]}}]', 9, 5),
(54, '2025-04-09 15:08:30.154121', '7', 'Item object (7)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\"]}}]', 9, 5),
(55, '2025-04-09 15:16:20.791231', '8', 'Item object (8)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\", \"Language\"]}}]', 9, 5),
(56, '2025-04-09 15:17:20.486119', '9', 'Item object (9)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\"]}}]', 9, 5),
(57, '2025-04-09 15:20:11.222336', '10', 'Item object (10)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\", \"Binding\"]}}]', 9, 5),
(58, '2025-04-09 15:21:48.350158', '11', 'Item object (11)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\", \"Binding\"]}}]', 9, 5),
(59, '2025-04-09 15:22:48.271341', '12', 'Item object (12)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\", \"Language\"]}}]', 9, 5),
(60, '2025-04-09 15:23:45.964698', '13', 'Item object (13)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\", \"Language\"]}}]', 9, 5),
(61, '2025-04-09 15:25:28.613745', '14', 'Item object (14)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\"]}}]', 9, 5),
(62, '2025-04-09 15:28:11.737102', '15', 'Item object (15)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\", \"Binding\"]}}]', 9, 5),
(63, '2025-04-09 15:29:33.824012', '16', 'Item object (16)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\"]}}]', 9, 5),
(64, '2025-04-09 15:31:27.241274', '17', 'Item object (17)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\"]}}]', 9, 5),
(65, '2025-04-09 15:32:26.486957', '18', 'Item object (18)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\", \"Binding\"]}}]', 9, 5),
(66, '2025-04-09 15:33:29.334166', '19', 'Item object (19)', 2, '[{\"changed\": {\"fields\": [\"Isbn\", \"Page no\"]}}]', 9, 5),
(67, '2025-04-20 08:40:04.899482', '19', 'Item object (19)', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 9, 5),
(68, '2025-04-20 08:40:04.971350', '19', 'Item object (19)', 2, '[]', 9, 5),
(69, '2025-04-20 08:41:37.641295', '3', 'Nobel', 2, '[{\"changed\": {\"fields\": [\"Abt cat\"]}}]', 8, 5);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(2, 'admin', 'logentry'),
(4, 'auth', 'group'),
(3, 'auth', 'permission'),
(5, 'contenttypes', 'contenttype'),
(10, 'myapp', 'cartitem'),
(8, 'myapp', 'category'),
(1, 'myapp', 'customuser'),
(9, 'myapp', 'item'),
(11, 'myapp', 'order'),
(7, 'myapp', 'student'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-03-22 07:39:07.757456'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-03-22 07:39:07.888968'),
(3, 'auth', '0001_initial', '2025-03-22 07:39:08.377975'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-03-22 07:39:08.490260'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-03-22 07:39:08.537705'),
(6, 'auth', '0004_alter_user_username_opts', '2025-03-22 07:39:08.578522'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-03-22 07:39:08.593280'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-03-22 07:39:08.600355'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-03-22 07:39:08.614546'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-03-22 07:39:08.631934'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-03-22 07:39:08.643772'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-03-22 07:39:08.681630'),
(13, 'auth', '0011_update_proxy_permissions', '2025-03-22 07:39:08.693410'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-03-22 07:39:08.707364'),
(15, 'myapp', '0001_initial', '2025-03-22 07:39:09.238558'),
(16, 'admin', '0001_initial', '2025-03-22 07:39:09.483357'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-03-22 07:39:09.504451'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-03-22 07:39:09.543483'),
(19, 'sessions', '0001_initial', '2025-03-22 07:39:09.857147'),
(20, 'myapp', '0002_student', '2025-04-01 03:49:19.452489'),
(21, 'myapp', '0003_category', '2025-04-02 14:26:36.714928'),
(22, 'myapp', '0004_rename_about_books_category_abt_cat_and_more', '2025-04-05 07:02:35.888077'),
(23, 'myapp', '0005_item', '2025-04-05 07:03:40.648826'),
(24, 'myapp', '0006_cartitem', '2025-04-06 14:26:46.640426'),
(25, 'myapp', '0007_rename_product_cartitem_item', '2025-04-07 10:14:11.701536'),
(26, 'myapp', '0008_item_binding_item_isbn_item_language_item_page_no', '2025-04-09 14:43:21.703599'),
(27, 'myapp', '0009_order', '2025-04-09 15:48:40.192876');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('3t23gdge63higw0xzaqwtw03bb8saqev', '.eJxVjDsOwjAQBe_iGln-r0xJzxksr9eLA8iR4qRC3B0ipYD2zcx7iZS3taVt1CVNJM7CiNPvhrk8at8B3XO_zbLMfV0mlLsiDzrkdab6vBzu30HLo33rSMAQrVG6alXIEANo4gAhOgUVi2LrGZxRzhsCGw0yeh0sRYtMWbw_0xU3rA:1uBThT:tYi3X_lYBbUz2mn2mTNwkoEqGxYVTSXJzoF_EtUkzTQ', '2025-05-18 07:23:47.025205');

-- --------------------------------------------------------

--
-- Table structure for table `myapp_cartitem`
--

CREATE TABLE `myapp_cartitem` (
  `id` bigint(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `date_added` datetime(6) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `myapp_cartitem`
--

INSERT INTO `myapp_cartitem` (`id`, `quantity`, `date_added`, `item_id`, `user_id`) VALUES
(11, 1, '2025-04-09 13:22:23.289589', 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `myapp_category`
--

CREATE TABLE `myapp_category` (
  `id` bigint(20) NOT NULL,
  `abt_cat` longtext NOT NULL,
  `cat_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `myapp_category`
--

INSERT INTO `myapp_category` (`id`, `abt_cat`, `cat_name`) VALUES
(1, 'The Ramayana is one of the most widely known Indian epics. This epic is retold in simple language supplemented with bright colourful illustrations.', 'Epics'),
(3, 'nob', 'Nobel'),
(4, 'TH', 'Thriller');

-- --------------------------------------------------------

--
-- Table structure for table `myapp_customuser`
--

CREATE TABLE `myapp_customuser` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `mobile` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `myapp_customuser`
--

INSERT INTO `myapp_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `mobile`) VALUES
(1, 'pbkdf2_sha256$600000$BNMLydnewsX6dxhHwwNrwm$PaDaNyNsC7fDmqsMEKJxo1MFJdnJUlsAaRac8kbm1CE=', NULL, 0, 'subhojit', 'subhojit', 'chakraborty', 'debansuguho@gmail.com', 0, 1, '2025-03-22 08:41:20.692333', '945687231'),
(2, 'pbkdf2_sha256$600000$DS2XchVJoCndgbeZDP2k0M$AjWzOVsoKGvdUwtyqpIyZUR7Ty62usDkV481dH4NW8g=', '2025-05-04 07:23:47.023041', 0, 'abhi', 'Abhi', 'Chakraborty', 'abhi@gmail.com', 0, 1, '2025-03-22 08:51:10.369076', '953217865'),
(3, 'pbkdf2_sha256$600000$AMmWcXjlCcT1q2ZoqcHf4R$ztMaerMaOAsjmoQWJJorg5daz3Q+xCR8L0D4Y4hjIHQ=', NULL, 0, 'aniket', 'aniket', 'roy', 'aniketroy@gmail.com', 0, 1, '2025-03-27 17:15:54.663098', '9876543210'),
(4, 'pbkdf2_sha256$600000$BfII8p5Ft3C12kmNbwiqfs$u6cB/7pEOWVYHCKyYJCSIiS6l5EBVUH2OVMeaHpe6FQ=', '2025-03-31 10:01:20.266301', 0, 'manish', 'manish', 'das', 'manish@gmail.com', 0, 1, '2025-03-31 10:00:55.780753', '7856942310'),
(5, 'pbkdf2_sha256$600000$tncrFUTT9lcrqDu4gJIBmm$ukUwzaGf01JfzhEkq7I+qf0vizyDS2QWt7H30Dwx8Bo=', '2025-04-21 10:04:05.890880', 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2025-04-02 14:22:34.346082', '');

-- --------------------------------------------------------

--
-- Table structure for table `myapp_customuser_groups`
--

CREATE TABLE `myapp_customuser_groups` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myapp_customuser_user_permissions`
--

CREATE TABLE `myapp_customuser_user_permissions` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myapp_item`
--

CREATE TABLE `myapp_item` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `author` varchar(255) NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `pub_date` varchar(10) NOT NULL,
  `price` varchar(255) NOT NULL,
  `edition` varchar(100) NOT NULL,
  `b_img` varchar(100) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `binding` varchar(50) NOT NULL,
  `isbn` varchar(13) DEFAULT NULL,
  `language` varchar(50) NOT NULL,
  `page_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `myapp_item`
--

INSERT INTO `myapp_item` (`id`, `name`, `description`, `author`, `publisher`, `pub_date`, `price`, `edition`, `b_img`, `category_id`, `binding`, `isbn`, `language`, `page_no`) VALUES
(5, 'Ramayana', 'The Ramayana is one of the most widely known Indian epics. This epic is retold in simple language supplemented with bright colourful illustrations.', 'Rishi Valmiki', 'OM Book Service', '30/11/2008', '1200', 'N/A', 'items/featuresbook1_9pi3ZT7.jpg', 3, 'HARDBACK', '9788187107675', 'English', 256),
(6, 'মহাভারত', 'The Mahabharat written by the great Sage Vedvyas is reckoned as one of the topmost epics of the world. This celebrated epic throws much light on the ancient Indian culture and civilization and the various aspects of its moral, social, political and religious life of that era. It is veritably encyclopedic in its form because it gives full details of the developments achieved by the mankind till that time. The epic itself claims to contain \"everything which is anywhere and which is not here is not anywhere. \"The Mahabharat contains 100,217 Shlokas divided in 18 cantoes. Its original name was \'Jai\' which during the passage of time acquired the name of \'Bharat Puran\' and now it is famous as Mahabharat, the epic.', 'Priyadarshi Prakash', 'Diamond Books', '11/12/2019', '1468', 'N/A', 'items/featuresbook7.jpg', 3, 'Paperback', '978935165704', 'Bengali', 162),
(7, 'Messi: A Biography', 'For soccer enthusiasts and sports fans in general, an in-depth look at the life of the beautiful game\'s greatest star, Argentine footballer Lionel Messi.\r\n            Whether you call it soccer, football, fútbol, or the \"beautiful game,\" it is the most popular sport in the world, and Argentine footballer Lionel Messi stands as one of its finest players--not only of his time, but of all time. Admired around the globe for his athleticism, skill, and fierce competitiveness, Messi has, at the age of 24, already shattered records at one of the most storied clubs in the world, FC Barcelona. Now, in this comprehensive biography, Messi fans can learn more about his life and career. Argentine journalist Leonardo Faccio describes how Messi, as a talented youth player in Buenos Aires, left his home for Spain in search of the medical help his family could not afford to treat his rare hormone deficiency. Small of stature, but possessing tremendous natural gifts, Messi developed into a star at Barcelona\'s famed Masia soccer school. In this book, Faccio has written not only a biography of an enigmatic celebrity, but a meditation on athletic genius, drawing on interviews with Messi himself, as well as with everyone from his family, teammates, childhood friends--even his favorite butcher. In-depth and intimate, soccer fans who enjoy watching Messi come alive on the field will delight as he comes alive on the page.', 'Leonardo Faccio', 'Anchor Books', '04/09/2012', '619', 'N/A', 'items/featuresbook3_bEH0RgL.jpg', 3, 'Paperback', '9780345802699', 'English', 176),
(8, 'বিক্রম বেতাল', 'The stories of Vikram and Betal, originally written in Sanskrit, have been an integral part of the Indian fairy tales for many centuries. Legend has it that King Vikramaditya (Vikram), the Emperor of Ujjain promises a monk to bring Betal, the vampire as a favour promised to him. The condition is that the King should bring the vampire with complete silence otherwise the vampire will fly back with corpse to the tree. As soon as Vikram attempts to fetch the corpse, the vampire starts to narrate a story. And at the end of every story, it compels King Vikram to answer his question, thus breaking his silence. The collection of Vikram and Betal stories bring before the young readers some of the most amazing tales ending with a moral. Hope the children will enjoy reading them.', 'Priyanka Verma', 'Repro Books Limited', '03/03/2023', '1060', 'N/A', 'items/featuresbook5.jpg', 1, 'Paperback', '9789355133519', 'Bengali', 50),
(9, 'Forensic Science', 'Forensic Science for Criminal Justice System\" is an essential resource for students and professionals in the field of forensic science. Written by experts Prof. Anu Singhala and Ankit Srivastava, this book provides comprehensive coverage of forensic techniques and their applications in criminal investigations. It includes detailed explanations of various forensic methods, case studies, and practical insights to enhance understanding of forensic science in the context of criminal justice.', 'Anu Singhala', 'Selective & Scientific Books', '2012', '488', 'N/A', 'items/featuresbook2.jpg', 4, 'Paperback', '9788189128364', 'English', 385),
(10, 'You\'re 18! Now What?', 'You\'re 18! Now what?\r\n\r\nIt\'s time to embrace adulting!\r\n\r\nLoans. Insurance. IRAs.\r\n\r\nWait! Are you serious?\r\n\r\nWhen you get into the details, the independent world you\'ve been searching for your whole life may not sound so great after all.\r\n\r\nThe truth is, being an adult can be liberating and a lot of fun. It can also be very intimidating.\r\n\r\nWhether your parents gave you tips about finding a job, saving money, improving your credit score, or left it for you to figure out--or even if they tried and you didn\'t listen--it\'s not too late to prepare for the responsibilities that come with living on your own. This guide will give you resources and answers to a wide range of questions you\'re already asking or soon will be.\r\n\r\nDr. Catherine Gilstein has decades of experience in financial services and teaching college business courses. This compilation of her knowledge and conversations with thousands of students reflects her passion: to help young adults successfully navigate the universe they\'ve been thrust into.\r\n\r\nWith optimism, encouragement, and a sense of humor, Dr. Gilstein reminds you that even if you doubt that you\'re ready to adult . . . you can', 'Catherine Gilstein', 'Mascot Books', '28/08/2024', '1663', 'N/A', 'items/featuresbook8.jpg', 1, 'HARDBACK', '9798891381001', 'English', 136),
(11, 'Krishna', 'he Little Blue Book on Krishna in its deluxe silk hardbound edition is a captivating and insightful exploration of Lord Krishna\'s life and teachings. Written by renowned author Shubha Vilas, this beautifully crafted edition offers a deep understanding of Krishna\'s wisdom, love, and divinity. A must-have for devotees of Lord Krishna and collectors of religious texts.\r\n\r\nDelves into concepts such as devotion, karma, self-realization, and the nature of divine love.\r\nA Pandora\'s box of sweetness with delightful stories of Krishna.\r\nDeluxe silk hardbound edition with a visually stunning design.\r\nEngaging storytelling that brings Krishna\'s leelas to life.\r\nPerfect for devotees, spiritual seekers, and lovers of Indian mythology.', 'Shubha Vilas', 'Prakash', '01/02/2021', '399', 'N/A', 'items/arrivalbook7.jpg', 1, 'HARDBACK', '9788194916505', 'English', 352),
(12, 'ঈশপের নৈতিক কাহিনী', 'Nearly 2,500 years ago, there was a slave in Greece, named Aesop. When he saw the activities being inflicted on people under the slavery system, his heart started crying bitterly. His experiences got transformed into unique stories. Aesop used to move from one region to another to tell those stories to children. Wherever he went, children used to surround him, who was their Aesop Baba, the man with stories. They used to request him to tell a story. In a little time, these stories reached the entire world. The renowned author, Prakash Manu has presented these Aesop\'s tales in such a beautiful manner that they will definitely entertain and instruct our young readers.', 'Prakash Manu', 'Repro Books Limited', '25/03/2023', '1129', 'N/A', 'items/featuresbook6.jpg', 1, 'Paperback', '978935513359', 'Bengali', 50),
(13, '108 Panchatantra Story', 'Depicting the five principle conduct about life, The Panchatantra Stories are timeless classics. Readers of all age groups enjoy reading and rereading the Panchatantra Stories as they  impart profou ...', 'Maple Press', 'Maple Press', '01/06/2021', '180', 'N/A', 'items/featuresbook4.jpg', 4, 'Paperback', '978939112906', 'Hindi', 56),
(14, 'The Lightning Thief', 'Look, I didn\'t want to be a half-blood. I never asked to be the son of a Greek God. I was just a normal kid, going to school, playing basketball, skateboarding. The usual. Until I accidentally vaporized my maths teacher. Now I spend my time battling monsters and generally trying to stay alive. This title tells the author story.', 'Rick Riordan', 'Penguin Books Ltd', '04/07/2013', '450', 'N/A', 'items/arrivalsBook1.jpg', 4, 'Paperback', '978000734176', 'English', 240),
(15, 'Ranger\'s Apprentice', 'The first three books in John Flanagan\'s New York Times bestselling series collected in one boxed set. Perfect for gift giving!\r\n\r\nThe Ranger\'s Apprentice series has taken readers by storm, captivating them with the adventures of Will, apprentice to the secretive Ranger Halt. This epic story of heroes and villians is perfect for fantasy adventure fans of all ages.\r\n\r\nBooks included: The Ruins of Gorlan, The Burning Bridge, and The Icebound Land\r\n\r\nFor readers of J.R.R. Tolkien\'s Lord of the Rings, T.H. White\'s The Sword in the Stone, Christopher Paolini\'s Eragon series, and George R. R. Martin\'s Game of Thrones/A Song of Ice and Fire series', 'John Flanagan', 'Puffin Books', '11/09/2008', '2638', 'N/A', 'items/arrival_9.jpg', 4, 'SB', '9780142411735', 'English', 190),
(16, 'Diary of a Wimpy Kid', 'Diary of a Wimpy Kid: Squid Game is a spin-off Wimpy Kid book based on the popular and gory Netflix show Squid Game. It was created by u/Johnwasnever, who is a mod of the r/LodedDiper subreddit.', 'Jeff Kinney', 'Penguin Random House Children\'s UK', '28/01/2021', '903', 'N/A', 'items/arrival_8.webp', 1, 'Paperback', '9780241396926', 'English', 240),
(17, 'Modern India', 'Modern India | Brief History | Spectrum | Rajiv Ahir | UPSC | Civil Services Exam | State Administrative Exams - 2023/edition', 'Rajiv Ahir', 'Spectrum Books Pvt. Ltd.', '09/09/2023', '595', 'N/A', 'items/arrivalbook6.jpg', 1, 'Paperback', '9788179308622', 'English', 1016),
(18, 'Wright Brothers', 'Two-time winner of the Pulitzer Prize David McCullough tells the dramatic story-behind-the-story about the courageous brothers who taught the world how to fly: Wilbur and Orville Wright.', 'David McCullough', 'Simon & Schuster', '05/05/2015', '2816', 'N/A', 'items/arrivalsBook2.jpg', 4, 'HARDBACK', '978147672874', 'English', 336),
(19, 'Recruitment Exam Book', 'Best Selling Book in English Edition for RPF/RPSF Constable Recruitment Exam with objective-type questions as per the latest syllabus. - Compare your performance with other students using Smart Answer Sheets in EduGorilla\'s RPF/RPSF Constable Recruitment Exam Practice Book Kit. - RPF/RPSF Constable Recruitment Exam Book comes with 10 Practice Tests with the best quality content. - Increase your chances of selection by 16X. - RPF/RPSF Constable Recruitment Exam Book Prep Kit comes with well-structured and 100% detailed solutions for all the questions. - Clear exam with good grades using thoroughly Researched Content by experts, etc.', 'Repro India Limited', 'Edugorilla Community Pvt Ltd', '16/06/2023', '541', 'N/A', 'items/arrivalbook10.jpg', 1, 'Paperback', '9789355567321', 'English', 222);

-- --------------------------------------------------------

--
-- Table structure for table `myapp_order`
--

CREATE TABLE `myapp_order` (
  `id` bigint(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `date_ordered` datetime(6) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `payment_id` varchar(255) NOT NULL,
  `address` longtext NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `myapp_order`
--

INSERT INTO `myapp_order` (`id`, `quantity`, `date_ordered`, `payment_status`, `payment_id`, `address`, `item_id`, `user_id`) VALUES
(1, 2, '2025-04-10 10:28:51.993729', 'success', '', '', 7, 2),
(2, 1, '2025-04-10 14:43:37.740076', 'success', '', '', 5, 2),
(3, 1, '2025-04-10 15:06:09.800763', 'success', '', '', 16, 2),
(4, 1, '2025-04-10 15:38:53.984687', 'success', '', '', 17, 2),
(5, 1, '2025-04-12 14:47:30.861704', 'success', '', '', 12, 2),
(6, 1, '2025-04-12 14:57:27.385492', 'success', '', '', 10, 2),
(7, 1, '2025-04-13 06:56:17.026928', 'success', '', 'hbbbb74/5', 18, 2),
(8, 1, '2025-04-17 15:43:33.883362', 'success', '', '', 9, 2);

-- --------------------------------------------------------

--
-- Table structure for table `myapp_student`
--

CREATE TABLE `myapp_student` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `myapp_student`
--

INSERT INTO `myapp_student` (`id`, `name`, `email`, `mobile`) VALUES
(3, 'subho', 'debansuguho@gmail.com', '945687231'),
(4, 'hello', 'hello@gmail.com', '6549871230');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_myapp_customuser_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `myapp_cartitem`
--
ALTER TABLE `myapp_cartitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `myapp_cartitem_user_id_eb2b3823_fk_myapp_customuser_id` (`user_id`),
  ADD KEY `myapp_cartitem_item_id_3131e44a_fk_myapp_item_id` (`item_id`);

--
-- Indexes for table `myapp_category`
--
ALTER TABLE `myapp_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myapp_customuser`
--
ALTER TABLE `myapp_customuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `myapp_customuser_groups`
--
ALTER TABLE `myapp_customuser_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `myapp_customuser_groups_customuser_id_group_id_8dfb17af_uniq` (`customuser_id`,`group_id`),
  ADD KEY `myapp_customuser_groups_group_id_9a436a56_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `myapp_customuser_user_permissions`
--
ALTER TABLE `myapp_customuser_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `myapp_customuser_user_pe_customuser_id_permission_a9e136bb_uniq` (`customuser_id`,`permission_id`),
  ADD KEY `myapp_customuser_use_permission_id_4ffda77e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `myapp_item`
--
ALTER TABLE `myapp_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `isbn` (`isbn`),
  ADD KEY `myapp_item_category_id_aa348b57_fk_myapp_category_id` (`category_id`);

--
-- Indexes for table `myapp_order`
--
ALTER TABLE `myapp_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `myapp_order_item_id_00f727c9_fk_myapp_item_id` (`item_id`),
  ADD KEY `myapp_order_user_id_98783cea_fk_myapp_customuser_id` (`user_id`);

--
-- Indexes for table `myapp_student`
--
ALTER TABLE `myapp_student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `myapp_cartitem`
--
ALTER TABLE `myapp_cartitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `myapp_category`
--
ALTER TABLE `myapp_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `myapp_customuser`
--
ALTER TABLE `myapp_customuser`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `myapp_customuser_groups`
--
ALTER TABLE `myapp_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `myapp_customuser_user_permissions`
--
ALTER TABLE `myapp_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `myapp_item`
--
ALTER TABLE `myapp_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `myapp_order`
--
ALTER TABLE `myapp_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `myapp_student`
--
ALTER TABLE `myapp_student`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_myapp_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `myapp_customuser` (`id`);

--
-- Constraints for table `myapp_cartitem`
--
ALTER TABLE `myapp_cartitem`
  ADD CONSTRAINT `myapp_cartitem_item_id_3131e44a_fk_myapp_item_id` FOREIGN KEY (`item_id`) REFERENCES `myapp_item` (`id`),
  ADD CONSTRAINT `myapp_cartitem_user_id_eb2b3823_fk_myapp_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `myapp_customuser` (`id`);

--
-- Constraints for table `myapp_customuser_groups`
--
ALTER TABLE `myapp_customuser_groups`
  ADD CONSTRAINT `myapp_customuser_gro_customuser_id_4b46b787_fk_myapp_cus` FOREIGN KEY (`customuser_id`) REFERENCES `myapp_customuser` (`id`),
  ADD CONSTRAINT `myapp_customuser_groups_group_id_9a436a56_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `myapp_customuser_user_permissions`
--
ALTER TABLE `myapp_customuser_user_permissions`
  ADD CONSTRAINT `myapp_customuser_use_customuser_id_afabd7b0_fk_myapp_cus` FOREIGN KEY (`customuser_id`) REFERENCES `myapp_customuser` (`id`),
  ADD CONSTRAINT `myapp_customuser_use_permission_id_4ffda77e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Constraints for table `myapp_item`
--
ALTER TABLE `myapp_item`
  ADD CONSTRAINT `myapp_item_category_id_aa348b57_fk_myapp_category_id` FOREIGN KEY (`category_id`) REFERENCES `myapp_category` (`id`);

--
-- Constraints for table `myapp_order`
--
ALTER TABLE `myapp_order`
  ADD CONSTRAINT `myapp_order_item_id_00f727c9_fk_myapp_item_id` FOREIGN KEY (`item_id`) REFERENCES `myapp_item` (`id`),
  ADD CONSTRAINT `myapp_order_user_id_98783cea_fk_myapp_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `myapp_customuser` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
