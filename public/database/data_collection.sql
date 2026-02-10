-- phpMyAdmin SQL Dump
-- version 4.9.10
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 20, 2025 at 07:40 PM
-- Server version: 8.0.41-0ubuntu0.20.04.1
-- PHP Version: 7.0.33-75+ubuntu20.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `data_collection`
--

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` int NOT NULL,
  `client_unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `contact_person` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pan_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `billing_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shifting_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `gst_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_id` int DEFAULT NULL,
  `date` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `time` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` int DEFAULT '0',
  `state` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `state_no` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bank_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pin` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `client_unit`, `client_name`, `contact_person`, `pan_no`, `billing_address`, `shifting_address`, `phone_no`, `gst_number`, `created_id`, `date`, `time`, `timestamp`, `deleted`, `state`, `state_no`, `bank_details`, `address1`, `location`, `pin`) VALUES
(1, 'Talegaon Unit', 'TEST TECHNOPLAST', 'MR. Suresh Kamat', 'BIZPB5715', 'S.no. 123/4, Near PCMC water tank, Whalekarwadi Road, Pimple Goan, Pune-411111  Email: xxxxaaa@yahoo.com   PH: 1234567890', 'Gat no.5648, House no 133, near Hotel, Pimple Road, Pune-411111', '1111111110', '11ABCDE2222FGHI', 3, '03-04-2024', '10:58:33', '2024-02-09 08:27:30', 0, 'MAHARASHTRA', '27', 'ICICI BANK - Ac.No. 1111', 'xxxxx, xxxxxxxxxxx, xxxxxxxxxxxxxxxxxxxxxxx', 'Chinchwad', '411111'),
(2, 'Akurdi Unit', 'TEST TECHNOPLAST', 'MR. Suresh Kamat', 'BIZPB5715', 'S.no. 123/4, Near PCMC water tank, Whalekarwadi Road, Pimple Goan, Pune-411111  Email: xxxxaaa@yahoo.com   PH: 1234567890', 'Gat no.5648, House no 133, near Hotel, Pimple Road, Pune-411111', '1111111110', '11ABCDE2222FGHI', 3, '21-04-2024', '06:53:03', '2024-02-09 10:29:41', 0, 'Maharashtra', '27', 'ICICI BANK 1111', 'xxxxx, xxxxxxxxxxx, xxxxxxxxxxxxxxxxxxxxxxx', 'Chinchwad', '411111');

-- --------------------------------------------------------

--
-- Table structure for table `config_setting`
--

CREATE TABLE `config_setting` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('check_box','input','date','file') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `company_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `config_setting`
--

INSERT INTO `config_setting` (`id`, `name`, `title`, `value`, `description`, `type`, `company_id`) VALUES
(9, 'company_logo', 'Company Logo', 'public/assets/images/data_collection_lgo.png', 'Company logo', 'file', 0),
(10, 'company_name', 'Company name', 'Data Collection', 'Company name', 'input', 0),
(11, 'company_fav_icon', 'Company fav icon', 'public/assets/img/favicon/favicon.png', 'Company fav icon', 'file', 0),
(12, 'login_attempt', 'Login attempt', '5', 'Login attempt', 'input', 0),
(13, 'menu_type', 'Menu Type', 'vertical', 'horizontal|vertical', 'input', 0),
(14, 'default_page_view_type', 'Default Page View Type for listing', '{\"User\":\"Grid\"}', 'Table/Grid', 'input', 0),
(15, 'smtp_user_name', 'SMTP User Name', 'mullaaarbaj10@gmail.com', 'SMTP User Name', 'input', 0),
(16, 'smtp_user_password', 'SMTP User Password', 'csoh fxfg hvfk egju', 'SMTP User Password', 'input', 0),
(17, 'company_email', 'Company Email', 'erp.system@gmail.com', 'Company Email', 'input', 0),
(18, 'password_link_expiry', 'Password Link Expiry', '10', 'Password Link Expiry In Minutes', 'input', 0),
(19, 'email_notification_enable', 'Email Notification Enable', 'Yes', 'Email Notification Enable', 'input', 0);

-- --------------------------------------------------------

--
-- Table structure for table `form_data_collection`
--

CREATE TABLE `form_data_collection` (
  `form_data_collection_id` int NOT NULL,
  `school_master_id` int NOT NULL,
  `sr_no` int NOT NULL,
  `form_data` json NOT NULL,
  `added_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `form_data_collection`
--

INSERT INTO `form_data_collection` (`form_data_collection_id`, `school_master_id`, `sr_no`, `form_data`, `added_date`) VALUES
(1, 10, 1, '{\"image\": \"public/uploads/data_collection_img/kit/image/kit_1.jpg\", \"course\": \"B.A. 1st Year\", \"pan_no\": \"AABCJ4550A1Z2\", \"married\": \"No\", \"father_name\": \"Aslam Mulla\", \"mobile_no_1\": \"9511886810\", \"mobile_no_2\": \"\", \"mother_name\": \"Laila Mulla\", \"student_name\": \"AARBAJ MULLA\", \"date_of_birth\": \"11-03-2025\"}', '2025-03-11 11:13:33'),
(2, 10, 2, '{\"image\": \"public/uploads/data_collection_img/kit/image/kit_2.jpg\", \"course\": \"MS\", \"pan_no\": \"AABCJ4550A1Z2\", \"married\": \"No\", \"father_name\": \"Narayan Hedau\", \"mobile_no_1\": \"9511886810\", \"mobile_no_2\": \"\", \"mother_name\": \"Lata Hedau\", \"student_name\": \"GAYATRI HEDAU\", \"date_of_birth\": \"11-03-2025\"}', '2025-03-11 13:16:15'),
(3, 10, 3, '{\"image\": \"public/uploads/data_collection_img/kit/image/kit_3.jpg\", \"course\": \"B.A. 1st Year\", \"pan_no\": \"BIZPB5715\", \"married\": \"No\", \"father_name\": \"Aslam Mulla\", \"mobile_no_1\": \"9511886810\", \"mobile_no_2\": \"testst\", \"mother_name\": \"Laila Mulla\", \"student_name\": \"JUNED MULLA\", \"date_of_birth\": \"11-03-2025\"}', '2025-03-11 13:16:47'),
(4, 10, 4, '{\"image\": \"public/uploads/data_collection_img/kit/image/kit_4.jpg\", \"course\": \"B Sc\", \"pan_no\": \"AABCJ4550A1Z2\", \"married\": \"No\", \"father_name\": \"Niyaj Mulla\", \"mobile_no_1\": \"8381058482\", \"mobile_no_2\": \"\", \"mother_name\": \"Kousar Mulla\", \"student_name\": \"REHAN MULLA\", \"date_of_birth\": \"11-03-2025\"}', '2025-03-11 13:17:38'),
(5, 10, 5, '{\"image\": \"public/uploads/data_collection_img/kit/image/kit_5.jpg\", \"course\": \"MS\", \"pan_no\": \"AABCJ4550A1Z2\", \"married\": \"No\", \"father_name\": \"Niyaj Mulla\", \"mobile_no_1\": \"9511886810\", \"mobile_no_2\": \"\", \"mother_name\": \"Kousar Mulla\", \"student_name\": \"KHUSHI MULLA\", \"date_of_birth\": \"11-03-2025\"}', '2025-03-11 13:18:33'),
(6, 10, 6, '{\"image\": \"public/uploads/data_collection_img/kit/image/kit_6.jpg\", \"course\": \"B Sc\", \"pan_no\": \"BIZPB5715\", \"married\": \"No\", \"father_name\": \"Salim Khan\", \"mobile_no_1\": \"8381058482\", \"mobile_no_2\": \"\", \"mother_name\": \"Salma Khan\", \"student_name\": \"SLAMAN KHAN\", \"date_of_birth\": \"2025-03-12\"}', '2025-03-12 23:24:12'),
(7, 10, 7, '{\"image\": \"public/uploads/data_collection_img/kit/image/kit_7.jpg\", \"course\": \"B Sc\", \"pan_no\": \"BIZPB5715\", \"married\": \"No\", \"father_name\": \"Narayan Hedau\", \"mobile_no_1\": \"9511886810\", \"mobile_no_2\": \"\", \"mother_name\": \"Lata Hedau\", \"student_name\": \"SHENA HEDAU\", \"date_of_birth\": \"2025-03-12\"}', '2025-03-12 23:26:35'),
(8, 11, 1, '{\"\": \"\", \"image\": \"public/uploads/data_collection_img/anand_vidya_mandir_collage/image/anand_vidya_mandir_collage_1.jpg\", \"course\": \"B Tech\", \"married\": \"No\", \"father_name\": \"ASLAM MULLA\", \"mobile_no_1\": \"8485835691\", \"mobile_no_2\": \"\", \"mother_name\": \"LAILA MULLA\", \"student_name\": \"JUNED MULLA\"}', '2025-03-14 20:12:36'),
(9, 12, 1, '{\"\": \"\", \"image\": \"public/uploads/data_collection_img/bharat_id_card_katni/image/bharat_id_card_katni_1.jpg\", \"course\": \"M Tech\", \"pan_no\": \"AABCJ4550A1Z2\", \"married\": \"No\", \"father_name\": \"Mr. NARAYAN HEDAU\", \"mobile_no_1\": \"9511886810\", \"mobile_no_2\": \"\", \"mother_name\": \"Miss. LATA HEDAU\", \"student_name\": \"GAYATRI HEDAU\", \"date_of_birth\": \"2025-03-18\"}', '2025-03-18 13:47:56');

-- --------------------------------------------------------

--
-- Table structure for table `form_field_master`
--

CREATE TABLE `form_field_master` (
  `form_field_master_id` int NOT NULL,
  `form_title` varchar(255) NOT NULL,
  `form_name` varchar(255) NOT NULL,
  `form_type` enum('input','radio','drop_down','file') NOT NULL,
  `field_type` enum('Number','Text','AlphaNumeric','Date','Uppecase') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `form_value` longtext NOT NULL,
  `prefix` enum('Mr.','Miss.') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `length` int NOT NULL,
  `added_by` int NOT NULL,
  `added_date` datetime NOT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `form_field_master`
--

INSERT INTO `form_field_master` (`form_field_master_id`, `form_title`, `form_name`, `form_type`, `field_type`, `form_value`, `prefix`, `length`, `added_by`, `added_date`, `updated_by`, `updated_date`) VALUES
(1, 'School Name', 'school_name', 'input', 'Text', '', '', 0, 1, '2025-03-06 22:26:52', 1, '2025-03-12 22:28:05'),
(16, 'Student Name', 'student_name', 'input', 'Uppecase', '', NULL, 0, 1, '2025-03-06 22:27:56', 1, '2025-03-10 16:29:38'),
(17, 'Father Name', 'father_name', 'input', 'Uppecase', '', 'Mr.', 0, 1, '2025-03-06 22:27:56', 1, '2025-03-12 22:26:26'),
(18, 'Mother Name', 'mother_name', 'input', 'Uppecase', '', 'Miss.', 0, 1, '2025-03-06 22:29:24', 1, '2025-03-13 10:51:56'),
(19, 'Image', 'image', 'file', NULL, '', NULL, 0, 1, '2025-03-06 22:29:24', NULL, NULL),
(20, 'Married', 'married', 'radio', NULL, 'Yes,No', NULL, 0, 1, '2025-03-08 03:57:31', NULL, NULL),
(21, 'Course', 'course', 'drop_down', NULL, '', NULL, 0, 1, '2025-03-08 03:57:31', NULL, NULL),
(22, 'Mobile No 1', 'mobile_no_1', 'input', 'Number', '', NULL, 10, 1, '2025-03-08 12:48:52', NULL, NULL),
(23, 'PAN No', 'pan_no', 'input', 'Text', '', '', 0, 1, '2025-03-10 15:30:02', NULL, NULL),
(26, 'Mobile No 2', 'mobile_no_2', 'input', 'Number', '', NULL, 0, 1, '2025-03-10 15:38:28', 1, '2025-03-10 16:21:39'),
(27, 'SSSMID', 'sssmid', 'input', 'Number', '', NULL, 9, 1, '2025-03-10 16:23:47', 1, '2025-03-10 16:24:17'),
(28, 'Date of Birth', 'date_of_birth', 'input', 'Date', '', NULL, 0, 1, '2025-03-10 16:44:31', NULL, NULL),
(29, 'Employee Code', '', 'input', 'AlphaNumeric', '', '', 0, 1, '2025-03-12 22:27:36', NULL, NULL),
(30, 'PF No.', '', 'input', 'Number', '', '', 10, 1, '2025-03-13 10:52:47', NULL, NULL),
(31, 'Blood Group', '', 'drop_down', '', 'A +ve, A -ve, B +ve, B -ve, AB +ve, AB -ve, O +ve, O -ve', '', 0, 1, '2025-03-14 20:07:47', NULL, NULL),
(32, 'Section', 'section', 'drop_down', '', 'NA', '', 0, 1, '2025-03-18 13:51:10', 1, '2025-03-18 14:03:02');

-- --------------------------------------------------------

--
-- Table structure for table `group_master`
--

CREATE TABLE `group_master` (
  `group_master_id` int NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `group_code` varchar(255) NOT NULL,
  `status` enum('Active','Inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `group_master`
--

INSERT INTO `group_master` (`group_master_id`, `group_name`, `group_code`, `status`) VALUES
(1, 'Admin', 'Admin', 'Active'),
(2, 'Super Admin', 'SuperAdmin', 'Inactive'),
(5, 'Employee', 'Employee', 'Active'),
(6, 'Channel Partner', 'ChannelPartner', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `group_rights`
--

CREATE TABLE `group_rights` (
  `group_rights_id` int NOT NULL,
  `group_master_id` int NOT NULL,
  `menu_master_id` int NOT NULL,
  `list` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'No',
  `add` enum('Yes','No') NOT NULL DEFAULT 'No',
  `update` enum('Yes','No') NOT NULL DEFAULT 'No',
  `delete` enum('Yes','No') NOT NULL DEFAULT 'No',
  `export` enum('Yes','No') NOT NULL DEFAULT 'No',
  `import` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `group_rights`
--

INSERT INTO `group_rights` (`group_rights_id`, `group_master_id`, `menu_master_id`, `list`, `add`, `update`, `delete`, `export`, `import`) VALUES
(21, 5, 8, 'Yes', 'No', 'No', 'No', 'No', 'No'),
(22, 5, 9, 'Yes', 'No', 'No', 'No', 'No', 'No'),
(23, 6, 8, 'Yes', 'No', 'No', 'No', 'No', 'No'),
(30, 2, 1, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(31, 2, 2, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(32, 2, 3, 'Yes', 'Yes', 'No', 'No', 'No', 'No'),
(33, 2, 8, 'Yes', 'Yes', 'No', 'No', 'No', 'No'),
(34, 2, 9, 'Yes', 'No', 'No', 'No', 'No', 'No'),
(35, 1, 1, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(36, 1, 8, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(37, 1, 9, 'Yes', 'Yes', 'Yes', 'No', 'No', 'No'),
(38, 1, 10, 'Yes', 'Yes', 'No', 'No', 'No', 'No');

-- --------------------------------------------------------

--
-- Table structure for table `menu_category`
--

CREATE TABLE `menu_category` (
  `menu_category_id` int NOT NULL,
  `menu_category_code` varchar(255) NOT NULL,
  `menu_category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `menu_category`
--

INSERT INTO `menu_category` (`menu_category_id`, `menu_category_code`, `menu_category_name`) VALUES
(1, 'user_managemnet', 'User Management'),
(2, 'data_management', 'Data Management');

-- --------------------------------------------------------

--
-- Table structure for table `menu_master`
--

CREATE TABLE `menu_master` (
  `menu_master_id` int NOT NULL,
  `menu_category_id` int NOT NULL,
  `diaplay_name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `menu_master`
--

INSERT INTO `menu_master` (`menu_master_id`, `menu_category_id`, `diaplay_name`, `url`, `status`) VALUES
(1, 1, 'User', 'user_list', 'Active'),
(2, 1, 'Group Master', 'group_master', 'Active'),
(3, 2, 'Sitemap', 'sitemap', 'Active'),
(8, 2, 'College/School Master', 'form_listing', 'Active'),
(9, 2, 'Form Data', 'data_collection_list', 'Active'),
(10, 2, 'Form Field Master', 'form_field_listing', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `school_matser`
--

CREATE TABLE `school_matser` (
  `school_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `form_type` enum('collage','school') NOT NULL,
  `contact_person` varchar(255) NOT NULL,
  `mobile_number` int NOT NULL,
  `designation` varchar(255) NOT NULL,
  `display_template` varchar(255) NOT NULL,
  `course` varchar(255) NOT NULL,
  `section` varchar(255) NOT NULL,
  `house` varchar(255) NOT NULL,
  `from_field` json NOT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `added_by` int NOT NULL,
  `added_date` datetime NOT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `school_matser`
--

INSERT INTO `school_matser` (`school_id`, `name`, `image`, `url`, `form_type`, `contact_person`, `mobile_number`, `designation`, `display_template`, `course`, `section`, `house`, `from_field`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`) VALUES
(1, 'Sharad Institute Of Technology', 'public/uploads/school_image/A_(1)12.png', 'sharad_institute_of_technology', 'school', 'Aarbaj Mulla', 2147483647, 'Delvopler', 'public/uploads/form_template_img/A_(1)13.png', '1st, 2nd, 3rd, 4th, 15th', 'A, Z', '', '[{\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"19\\\",\\\"form_title\\\":\\\"Image\\\",\\\"form_name\\\":\\\"image\\\",\\\"form_type\\\":\\\"file\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"16\\\",\\\"form_title\\\":\\\"Student Name\\\",\\\"form_name\\\":\\\"student_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"17\\\",\\\"form_title\\\":\\\"Father Name\\\",\\\"form_name\\\":\\\"father_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Mr.\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"18\\\",\\\"form_title\\\":\\\"Mother Name\\\",\\\"form_name\\\":\\\"mother_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Miss.\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"20\\\",\\\"form_title\\\":\\\"Married\\\",\\\"form_name\\\":\\\"married\\\",\\\"form_type\\\":\\\"radio\\\",\\\"form_value\\\":\\\"Yes,No\\\",\\\"prefix\\\":null,\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}]', 'Active', 3, '2025-03-08 04:01:22', NULL, NULL),
(7, 'DKTE', 'public/uploads/school_image/A_(1)14.png', 'dkte', 'collage', 'Gayatir Hedau', 2147483647, 'Senior Software Developer', 'public/uploads/form_template_img/A_(1)15.png', 'B.A. 1st Year, B.A. 2st Year, B TEC, M Tech', '', '', '[{\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"16\\\",\\\"form_title\\\":\\\"Student Name\\\",\\\"form_name\\\":\\\"student_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"17\\\",\\\"form_title\\\":\\\"Father Name\\\",\\\"form_name\\\":\\\"father_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Mr.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"18\\\",\\\"form_title\\\":\\\"Mother Name\\\",\\\"form_name\\\":\\\"mother_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Miss.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"19\\\",\\\"form_title\\\":\\\"Image\\\",\\\"form_name\\\":\\\"image\\\",\\\"form_type\\\":\\\"file\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"20\\\",\\\"form_title\\\":\\\"Married\\\",\\\"form_name\\\":\\\"married\\\",\\\"form_type\\\":\\\"radio\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"Yes,No\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"21\\\",\\\"form_title\\\":\\\"Course\\\",\\\"form_name\\\":\\\"course\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"B.A. 1st Year, B.A. 2st Year, B TEC, M Tech\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"22\\\",\\\"form_title\\\":\\\"Mobile No 1\\\",\\\"form_name\\\":\\\"mobile_no_1\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"10\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 12:48:52\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}]', 'Active', 3, '2025-03-08 17:01:39', NULL, NULL),
(8, 'GHRC', 'public/uploads/school_image/gsrc.jpeg', 'ghrc', 'collage', 'Gayatir Hedau', 2147483647, 'Senior Software Developer', 'public/uploads/form_template_img/gsrc1.jpeg', 'B.Sc. 1st Year, B TEch, M Tech', '', '', '[{\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"19\\\",\\\"form_title\\\":\\\"Image\\\",\\\"form_name\\\":\\\"image\\\",\\\"form_type\\\":\\\"file\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"16\\\",\\\"form_title\\\":\\\"Student Name\\\",\\\"form_name\\\":\\\"student_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"17\\\",\\\"form_title\\\":\\\"Father Name\\\",\\\"form_name\\\":\\\"father_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Mr.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"18\\\",\\\"form_title\\\":\\\"Mother Name\\\",\\\"form_name\\\":\\\"mother_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Miss.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"20\\\",\\\"form_title\\\":\\\"Married\\\",\\\"form_name\\\":\\\"married\\\",\\\"form_type\\\":\\\"radio\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"Yes,No\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"21\\\",\\\"form_title\\\":\\\"Course\\\",\\\"form_name\\\":\\\"course\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"B.Sc. 1st Year, B TEch, M Tech\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"22\\\",\\\"form_title\\\":\\\"Mobile No 1\\\",\\\"form_name\\\":\\\"mobile_no_1\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"10\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 12:48:52\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}]', 'Active', 1, '2025-03-09 23:02:07', NULL, NULL),
(9, 'Chate Collage', 'public/uploads/school_image/support_system.png', 'chate_collage', 'collage', 'john brama', 2147483647, 'Delvopler', 'public/uploads/form_template_img/support_system1.png', 'B.Com. 1st Year, B Tech, 12 th, 11 th', '', '', '[{\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"16\\\",\\\"form_title\\\":\\\"Student Name\\\",\\\"form_name\\\":\\\"student_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:29:38\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"17\\\",\\\"form_title\\\":\\\"Father Name\\\",\\\"form_name\\\":\\\"father_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Mr.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"18\\\",\\\"form_title\\\":\\\"Mother Name\\\",\\\"form_name\\\":\\\"mother_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Miss.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"19\\\",\\\"form_title\\\":\\\"Image\\\",\\\"form_name\\\":\\\"image\\\",\\\"form_type\\\":\\\"file\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"20\\\",\\\"form_title\\\":\\\"Married\\\",\\\"form_name\\\":\\\"married\\\",\\\"form_type\\\":\\\"radio\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"Yes,No\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"21\\\",\\\"form_title\\\":\\\"Course\\\",\\\"form_name\\\":\\\"course\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"B.Com. 1st Year, B Tech, 12 th, 11 th\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"22\\\",\\\"form_title\\\":\\\"Mobile No 1\\\",\\\"form_name\\\":\\\"mobile_no_1\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"10\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 12:48:52\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"23\\\",\\\"form_title\\\":\\\"PAN No\\\",\\\"form_name\\\":\\\"pan_no\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Text\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 15:30:02\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"26\\\",\\\"form_title\\\":\\\"Mobile No 2\\\",\\\"form_name\\\":\\\"mobile_no_2\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 15:38:28\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:21:39\\\"}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"27\\\",\\\"form_title\\\":\\\"SSSMID\\\",\\\"form_name\\\":\\\"sssmid\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"9\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 16:23:47\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:24:17\\\"}\"}]', 'Active', 1, '2025-03-10 16:31:40', NULL, NULL),
(10, 'KIT', 'public/uploads/school_image/240_F_871603234_fTMmjlUOpt4F9mDudj8wjyzkt0khEtSZ-fotor-202412241956251.png', 'kit', 'collage', 'Koushal Hodage', 2147483647, 'Delvopler', 'public/uploads/form_template_img/attachment_1_169115708709320230804145130554502-202308041351307748153.jpg', 'B.A. 1st Year, B Sc, MS', '', '', '[{\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"19\\\",\\\"form_title\\\":\\\"Image\\\",\\\"form_name\\\":\\\"image\\\",\\\"form_type\\\":\\\"file\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"16\\\",\\\"form_title\\\":\\\"Student Name\\\",\\\"form_name\\\":\\\"student_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:29:38\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"17\\\",\\\"form_title\\\":\\\"Father Name\\\",\\\"form_name\\\":\\\"father_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Mr.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"18\\\",\\\"form_title\\\":\\\"Mother Name\\\",\\\"form_name\\\":\\\"mother_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Miss.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"20\\\",\\\"form_title\\\":\\\"Married\\\",\\\"form_name\\\":\\\"married\\\",\\\"form_type\\\":\\\"radio\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"Yes,No\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"21\\\",\\\"form_title\\\":\\\"Course\\\",\\\"form_name\\\":\\\"course\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"B.A. 1st Year, B Sc, MS\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"22\\\",\\\"form_title\\\":\\\"Mobile No 1\\\",\\\"form_name\\\":\\\"mobile_no_1\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"10\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 12:48:52\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"26\\\",\\\"form_title\\\":\\\"Mobile No 2\\\",\\\"form_name\\\":\\\"mobile_no_2\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 15:38:28\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:21:39\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"23\\\",\\\"form_title\\\":\\\"PAN No\\\",\\\"form_name\\\":\\\"pan_no\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Text\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 15:30:02\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"28\\\",\\\"form_title\\\":\\\"Date of Birth\\\",\\\"form_name\\\":\\\"date_of_birth\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Date\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 16:44:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}]', 'Active', 1, '2025-03-10 16:52:37', NULL, NULL),
(11, 'Anand vidya mandir collage', 'public/uploads/school_image/240_F_871603234_fTMmjlUOpt4F9mDudj8wjyzkt0khEtSZ-fotor-202412241956252.png', 'anand_vidya_mandir_collage', 'collage', 'Aarbaj Mulla', 2147483647, 'Teacher', 'public/uploads/form_template_img/240_F_871603234_fTMmjlUOpt4F9mDudj8wjyzkt0khEtSZ-fotor-202412241956253.png', 'B.A. 1st Year, B.Com. 1st Year, B.Sc. 1st Year, B Tech, M tech', '', '', '[{\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"16\\\",\\\"form_title\\\":\\\"Student Name\\\",\\\"form_name\\\":\\\"student_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:29:38\\\"}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"17\\\",\\\"form_title\\\":\\\"Father Name\\\",\\\"form_name\\\":\\\"father_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Mr.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-12 22:26:26\\\"}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"18\\\",\\\"form_title\\\":\\\"Mother Name\\\",\\\"form_name\\\":\\\"mother_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Miss.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-13 10:51:56\\\"}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"19\\\",\\\"form_title\\\":\\\"Image\\\",\\\"form_name\\\":\\\"image\\\",\\\"form_type\\\":\\\"file\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"20\\\",\\\"form_title\\\":\\\"Married\\\",\\\"form_name\\\":\\\"married\\\",\\\"form_type\\\":\\\"radio\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"Yes,No\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"21\\\",\\\"form_title\\\":\\\"Course\\\",\\\"form_name\\\":\\\"course\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"B.A. 1st Year, B.Com. 1st Year, B.Sc. 1st Year, B Tech, M tech\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"22\\\",\\\"form_title\\\":\\\"Mobile No 1\\\",\\\"form_name\\\":\\\"mobile_no_1\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"10\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 12:48:52\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"26\\\",\\\"form_title\\\":\\\"Mobile No 2\\\",\\\"form_name\\\":\\\"mobile_no_2\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 15:38:28\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:21:39\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"31\\\",\\\"form_title\\\":\\\"Blood Group\\\",\\\"form_name\\\":\\\"\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":\\\"\\\",\\\"form_value\\\":\\\"A +ve, A -ve, B +ve, B -ve, AB +ve, AB -ve, O +ve, O -ve\\\",\\\"prefix\\\":\\\"\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-14 20:07:47\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}]', 'Active', 1, '2025-03-14 20:10:14', NULL, NULL),
(12, 'Bharat ID Card Katni', 'public/uploads/school_image/collotion.jpeg', 'bharat_id_card_katni', 'collage', 'Salman Khan', 2147483647, 'Software Developer', 'public/uploads/form_template_img/Admin.png', 'B.A. 1st Year, B.Com. 1st Year, B.Sc. 1st Year, M Tech, B Tech', '', '', '[{\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"19\\\",\\\"form_title\\\":\\\"Image\\\",\\\"form_name\\\":\\\"image\\\",\\\"form_type\\\":\\\"file\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"16\\\",\\\"form_title\\\":\\\"Student Name\\\",\\\"form_name\\\":\\\"student_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:29:38\\\"}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"17\\\",\\\"form_title\\\":\\\"Father Name\\\",\\\"form_name\\\":\\\"father_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Mr.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-12 22:26:26\\\"}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"18\\\",\\\"form_title\\\":\\\"Mother Name\\\",\\\"form_name\\\":\\\"mother_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Miss.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-13 10:51:56\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"20\\\",\\\"form_title\\\":\\\"Married\\\",\\\"form_name\\\":\\\"married\\\",\\\"form_type\\\":\\\"radio\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"Yes,No\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"21\\\",\\\"form_title\\\":\\\"Course\\\",\\\"form_name\\\":\\\"course\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"B.A. 1st Year, B.Com. 1st Year, B.Sc. 1st Year, M Tech, B Tech\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"22\\\",\\\"form_title\\\":\\\"Mobile No 1\\\",\\\"form_name\\\":\\\"mobile_no_1\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"10\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 12:48:52\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"23\\\",\\\"form_title\\\":\\\"PAN No\\\",\\\"form_name\\\":\\\"pan_no\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Text\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 15:30:02\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"No\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"26\\\",\\\"form_title\\\":\\\"Mobile No 2\\\",\\\"form_name\\\":\\\"mobile_no_2\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Number\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 15:38:28\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:21:39\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"28\\\",\\\"form_title\\\":\\\"Date of Birth\\\",\\\"form_name\\\":\\\"date_of_birth\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Date\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-10 16:44:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"31\\\",\\\"form_title\\\":\\\"Blood Group\\\",\\\"form_name\\\":\\\"\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":\\\"\\\",\\\"form_value\\\":\\\"A +ve, A -ve, B +ve, B -ve, AB +ve, AB -ve, O +ve, O -ve\\\",\\\"prefix\\\":\\\"\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-14 20:07:47\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}]', 'Active', 1, '2025-03-18 13:17:52', NULL, NULL),
(13, 'Electronics', 'public/uploads/school_image/240_F_871603234_fTMmjlUOpt4F9mDudj8wjyzkt0khEtSZ-fotor-202412241956254.png', 'electronics', 'school', 'Salman Khan', 2147483647, 'Delvopler', 'public/uploads/form_template_img/5822259-2920x1640-desktop-hd-cute-laptop-background-image.jpg', 'Pre-Nursery, UKG, KG-2', 'A, C, E, G', 'House 1, House 2', '[{\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"19\\\",\\\"form_title\\\":\\\"Image\\\",\\\"form_name\\\":\\\"image\\\",\\\"form_type\\\":\\\"file\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"16\\\",\\\"form_title\\\":\\\"Student Name\\\",\\\"form_name\\\":\\\"student_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-10 16:29:38\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"17\\\",\\\"form_title\\\":\\\"Father Name\\\",\\\"form_name\\\":\\\"father_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Mr.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-12 22:26:26\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"18\\\",\\\"form_title\\\":\\\"Mother Name\\\",\\\"form_name\\\":\\\"mother_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Miss.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-13 10:51:56\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"21\\\",\\\"form_title\\\":\\\"Course\\\",\\\"form_name\\\":\\\"course\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"Pre-Nursery, UKG, KG-2\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"32\\\",\\\"form_title\\\":\\\"Section\\\",\\\"form_name\\\":\\\"\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":\\\"\\\",\\\"form_value\\\":\\\"NA\\\",\\\"prefix\\\":\\\"\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-18 13:51:10\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}]', 'Active', 1, '2025-03-18 13:52:19', NULL, NULL),
(14, 'Electronics1', 'public/uploads/school_image/240_F_871603234_fTMmjlUOpt4F9mDudj8wjyzkt0khEtSZ-fotor-202412241956255.png', 'electronics1', 'school', 'Salman Khan', 2147483647, 'Delvopler', 'public/uploads/form_template_img/5822259-2920x1640-desktop-hd-cute-laptop-background-image1.jpg', 'Pre-Nursery, UKG, KG-2', 'A, B, D, E', 'House 1, House 2', '[{\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"1\\\",\\\"form_title\\\":\\\"School Name\\\",\\\"form_name\\\":\\\"school_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Text\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:26:52\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-12 22:28:05\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"17\\\",\\\"form_title\\\":\\\"Father Name\\\",\\\"form_name\\\":\\\"father_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Mr.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:27:56\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-12 22:26:26\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"18\\\",\\\"form_title\\\":\\\"Mother Name\\\",\\\"form_name\\\":\\\"mother_name\\\",\\\"form_type\\\":\\\"input\\\",\\\"field_type\\\":\\\"Uppecase\\\",\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":\\\"Miss.\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-13 10:51:56\\\"}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"19\\\",\\\"form_title\\\":\\\"Image\\\",\\\"form_name\\\":\\\"image\\\",\\\"form_type\\\":\\\"file\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-06 22:29:24\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"21\\\",\\\"form_title\\\":\\\"Course\\\",\\\"form_name\\\":\\\"course\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":null,\\\"form_value\\\":\\\"Pre-Nursery, UKG, KG-2\\\",\\\"prefix\\\":null,\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-08 03:57:31\\\",\\\"updated_by\\\":null,\\\"updated_date\\\":null}\"}, {\"required\": \"Yes\", \"field_data\": \"{\\\"form_field_master_id\\\":\\\"32\\\",\\\"form_title\\\":\\\"Section\\\",\\\"form_name\\\":\\\"section\\\",\\\"form_type\\\":\\\"drop_down\\\",\\\"field_type\\\":\\\"\\\",\\\"form_value\\\":\\\"A, B, D, E\\\",\\\"prefix\\\":\\\"\\\",\\\"length\\\":\\\"0\\\",\\\"added_by\\\":\\\"1\\\",\\\"added_date\\\":\\\"2025-03-18 13:51:10\\\",\\\"updated_by\\\":\\\"1\\\",\\\"updated_date\\\":\\\"2025-03-18 14:03:02\\\"}\"}]', 'Active', 1, '2025-03-18 14:04:51', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `userinfo`
--

CREATE TABLE `userinfo` (
  `id` int NOT NULL,
  `user_email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `user_role` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `otp` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int NOT NULL,
  `deleted` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `unit_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `groups` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `login_attempt` int NOT NULL DEFAULT '0',
  `status` enum('Active','Inactive','Block') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userinfo`
--

INSERT INTO `userinfo` (`id`, `user_email`, `user_role`, `user_name`, `user_password`, `otp`, `added_date`, `added_by`, `deleted`, `unit_ids`, `groups`, `login_attempt`, `status`) VALUES
(1, 'mullaaarbaj10@gmail.com', 'Admin', 'Aarbaj Mulla', 'Test@123', '928282', '2024-11-19 12:41:29', 3, NULL, '', '1,2', 0, 'Active'),
(2, 'mullajuned0@gmail.com', 'Admin', 'Juned Mulla', '123456', '237582', '2024-11-19 12:42:40', 3, '0', '', '6', 0, 'Active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `config_setting`
--
ALTER TABLE `config_setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `form_data_collection`
--
ALTER TABLE `form_data_collection`
  ADD PRIMARY KEY (`form_data_collection_id`);

--
-- Indexes for table `form_field_master`
--
ALTER TABLE `form_field_master`
  ADD PRIMARY KEY (`form_field_master_id`);

--
-- Indexes for table `group_master`
--
ALTER TABLE `group_master`
  ADD PRIMARY KEY (`group_master_id`);

--
-- Indexes for table `group_rights`
--
ALTER TABLE `group_rights`
  ADD PRIMARY KEY (`group_rights_id`);

--
-- Indexes for table `menu_category`
--
ALTER TABLE `menu_category`
  ADD PRIMARY KEY (`menu_category_id`);

--
-- Indexes for table `menu_master`
--
ALTER TABLE `menu_master`
  ADD PRIMARY KEY (`menu_master_id`);

--
-- Indexes for table `school_matser`
--
ALTER TABLE `school_matser`
  ADD PRIMARY KEY (`school_id`);

--
-- Indexes for table `userinfo`
--
ALTER TABLE `userinfo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `config_setting`
--
ALTER TABLE `config_setting`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `form_data_collection`
--
ALTER TABLE `form_data_collection`
  MODIFY `form_data_collection_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `form_field_master`
--
ALTER TABLE `form_field_master`
  MODIFY `form_field_master_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `group_master`
--
ALTER TABLE `group_master`
  MODIFY `group_master_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `group_rights`
--
ALTER TABLE `group_rights`
  MODIFY `group_rights_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `menu_category`
--
ALTER TABLE `menu_category`
  MODIFY `menu_category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu_master`
--
ALTER TABLE `menu_master`
  MODIFY `menu_master_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `school_matser`
--
ALTER TABLE `school_matser`
  MODIFY `school_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `userinfo`
--
ALTER TABLE `userinfo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
