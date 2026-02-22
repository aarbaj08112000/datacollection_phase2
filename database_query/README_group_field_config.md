# Quick Fix: Run Database Script

The error "Error saving field configuration" is happening because the `group_field_config` table doesn't exist yet.

## Solution: Run the SQL Script

**Option 1: Via phpMyAdmin**
1. Open phpMyAdmin
2. Select your database
3. Go to "SQL" tab
4. Copy and paste this SQL:

```sql
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
```

5. Click "Go"

**Option 2: Via Command Line**
```bash
mysql -u your_username -p your_database_name < /var/www/html/extra_work/project_2026/database_query/group_field_config.sql
```

## After Running the Script

1. Refresh the configure fields page
2. Select the fields you want
3. Click "Save Configuration"
4. It should now work!

## Verify Table Was Created

Run this query to check:
```sql
SHOW TABLES LIKE 'group_field_config';
```

You should see the table listed.
