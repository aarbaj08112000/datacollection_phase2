INSERT INTO `group_master` (`group_master_id`, `group_name`, `group_code`, `status`) VALUES (NULL, 'School', 'School', 'Active');
ALTER TABLE `userinfo` CHANGE `status` `status` ENUM('Active','Inactive','Block','Pending') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Active';
