CREATE TABLE `registration_otp` ( `registration_otp_id` INT NOT NULL AUTO_INCREMENT , `code` VARCHAR(266) NOT NULL , `otp` INT(6) NOT NULL , PRIMARY KEY (`registration_otp_id`)) ENGINE = InnoDB;
ALTER TABLE `userinfo` ADD `extra_json` JSON NULL AFTER `status`;
ALTER TABLE `school_matser` CHANGE `status` `status` ENUM('Active','Inactive','PendingApproval') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Active';
INSERT INTO `config_setting` (`id`, `name`, `title`, `value`, `description`, `type`, `company_id`) VALUES (NULL, 'linkPaymentQr', 'Link Payment Qr Code ', 'public/assets/payment_qr/qrcode.png', 'Link Payment Qr Code ', 'input', '1');
INSERT INTO `config_setting` (`id`, `name`, `title`, `value`, `description`, `type`, `company_id`) VALUES (NULL, 'whatsAppNumber', 'whats App Number', '8485835691', 'whats App Number', 'input', '1');
INSERT INTO `menu_master` (`menu_master_id`, `menu_category_id`, `diaplay_name`, `url`, `status`) VALUES (NULL, '1', 'Group Field Configuration', 'field_selection_list', 'Active'), (NULL, '1', 'Configuration Settings', 'config_setting_list', 'Active');

CREATE TABLE `widget` (
  `widget_id` int NOT NULL,
  `tab_name` enum('OverViewDetails','ChannelPatnerDetails','SchoolDetails') COLLATE utf8mb4_general_ci NOT NULL,
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





CREATE TABLE `group_field_config` (
  `id` int NOT NULL,
  `group_master_id` int NOT NULL,
  `selected_fields` text COLLATE utf8mb4_general_ci NOT NULL COMMENT 'JSON array of field IDs from form_field_master',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Stores field visibility configuration per user group';

--
-- Dumping data for table `group_field_config`
--

INSERT INTO `group_field_config` (`id`, `group_master_id`, `selected_fields`, `created_at`) VALUES
(1, 6, '[\"16\",\"17\",\"18\",\"19\",\"20\",\"22\"]', '2026-02-17 13:01:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `group_field_config`
--
ALTER TABLE `group_field_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_group` (`group_master_id`),
  ADD KEY `idx_group_master_id` (`group_master_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `group_field_config`
--
ALTER TABLE `group_field_config`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;