CREATE TABLE `data_collection`.`registration_otp` ( `registration_otp_id` INT NOT NULL AUTO_INCREMENT , `code` VARCHAR(266) NOT NULL , `otp` INT(6) NOT NULL , PRIMARY KEY (`registration_otp_id`)) ENGINE = InnoDB;
ALTER TABLE `userinfo` ADD `extra_json` JSON NULL AFTER `status`;
ALTER TABLE `school_matser` CHANGE `status` `status` ENUM('Active','Inactive','PendingApproval') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Active';
INSERT INTO `config_setting` (`id`, `name`, `title`, `value`, `description`, `type`, `company_id`) VALUES (NULL, 'linkPaymentQr', 'Link Payment Qr Code ', 'public/assets/payment_qr/qrcode.png', 'Link Payment Qr Code ', 'input', '1');
INSERT INTO `config_setting` (`id`, `name`, `title`, `value`, `description`, `type`, `company_id`) VALUES (NULL, 'whatsAppNumber', 'whats App Number', '8485835691', 'whats App Number', 'input', '1');
INSERT INTO `menu_master` (`menu_master_id`, `menu_category_id`, `diaplay_name`, `url`, `status`) VALUES (NULL, '1', 'Group Field Configuration', 'field_selection_list', 'Active'), (NULL, '1', 'Configuration Settings', 'config_setting_list', 'Active');

-- phpMyAdmin SQL Dump
-- version 4.9.10
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 17, 2026 at 04:04 PM
-- Server version: 8.0.42-0ubuntu0.20.04.1
-- PHP Version: 7.0.33-75+ubuntu20.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `phase3_sheet`
--

-- --------------------------------------------------------

--
-- Table structure for table `widget`
--

CREATE TABLE `widget` (
  `widget_id` int NOT NULL,
  `tab_name` enum('Sales','Account','PurchaseGRN','Stores','Production','BusinessAnalytics','Quality','Subcon','PendingTask') COLLATE utf8mb4_general_ci NOT NULL,
  `widget_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `widget_type` enum('Block','SingleBar','DoubleBar','Pie','SemiCircle','SingleColumnBar','Table','Spline','ImageBlock') COLLATE utf8mb4_general_ci NOT NULL,
  `widget_funtion` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `widget`
--
ALTER TABLE `widget`
  ADD PRIMARY KEY (`widget_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `widget`
--
ALTER TABLE `widget`
  MODIFY `widget_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;
COMMIT;


INSERT INTO `widget` (`widget_id`, `tab_name`, `widget_name`, `widget_type`, `widget_funtion`, `status`) VALUES (NULL, 'OverViewDetails', 'TODAY_USER', 'Block', 'get_total_users', 'Active'), (NULL, 'OverViewDetails', 'TOTAL_EMPLOYEE', 'Block', 'get_total_employee', 'Active'), (NULL, 'OverViewDetails', 'TOTAL_CHANNEL_PATNER', 'Block', 'get_total_channel_patner', 'Active'), (NULL, 'OverViewDetails', 'TOTAL_SCHOOL', 'Block', 'get_total_school', 'Active');
INSERT INTO `widget` (`widget_id`, `tab_name`, `widget_name`, `widget_type`, `widget_funtion`, `status`) VALUES (NULL, 'OverViewDetails', 'TODAY_GENERATED_LINK', 'Block', 'get_today_generated_link', 'Active'), (NULL, 'OverViewDetails', 'YESTERDAY_GENERATED_LINK', 'Block', 'get_yesterday_generated_link', 'Active'), (NULL, 'OverViewDetails', 'CURRENT_MONTH_GENERATED_LINK', 'Block', 'get_current_month_generated_link', 'Active'), (NULL, 'OverViewDetails', 'CURRENT_YEAR_GENERATED_LINK', 'Block', 'get_current_year_generated_link', 'Active');
INSERT INTO `widget` (`tab_name`, `widget_name`, `widget_type`, `widget_funtion`, `status`) VALUES
('ChannelPatnerDetails', 'TODAY_GENERATED_LINK_CHANNEL', 'Block', 'get_today_generated_link_chanel', 'Active'),
('ChannelPatnerDetails', 'YESTERDAY_GENERATED_LINK_CHANNEL', 'Block', 'get_yesterday_generated_link_chanel', 'Active'),
('ChannelPatnerDetails', 'CURRENT_MONTH_GENERATED_LINK_CHANNEL', 'Block', 'get_current_month_generated_link_chanel', 'Active'),
('ChannelPatnerDetails', 'CURRENT_YEAR_GENERATED_LINK_CHANNEL', 'Block', 'get_current_year_generated_link_chanel', 'Active');

INSERT INTO `widget` (`tab_name`, `widget_name`, `widget_type`, `widget_funtion`, `status`) VALUES
('SchoolDetails', 'TODAY_GENERATED_LINK_SCHOOL', 'Block', 'get_today_generated_link_school', 'Active'),
('SchoolDetails', 'YESTERDAY_GENERATED_LINK_SCHOOL', 'Block', 'get_yesterday_generated_link_school', 'Active'),
('SchoolDetails', 'CURRENT_MONTH_GENERATED_LINK_SCHOOL', 'Block', 'get_current_month_generated_link_school', 'Active'),
('SchoolDetails', 'CURRENT_YEAR_GENERATED_LINK_SCHOOL', 'Block', 'get_current_year_generated_link_school', 'Active');

INSERT INTO `menu_category` (`menu_category_id`, `menu_category_code`, `menu_category_name`) VALUES (NULL, '', ''), (NULL, 'dashboard', 'Dashboard');
INSERT INTO `menu_master` (`menu_master_id`, `menu_category_id`, `diaplay_name`, `url`, `status`) VALUES (NULL, '4', 'Overall Detail Tab', 'overall_detail_tab', 'Active'), (NULL, '4', 'Channel Patner Tab', 'channel_patner_tab', 'Inactive'), (NULL, '4', 'School Tab', 'school_tab', 'Active');