-- Create table for group field configuration
CREATE TABLE IF NOT EXISTS `group_field_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_master_id` int NOT NULL,
  `selected_fields` TEXT NOT NULL COMMENT 'JSON array of field IDs from form_field_master',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_group` (`group_master_id`),
  KEY `idx_group_master_id` (`group_master_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Stores field visibility configuration per user group';
