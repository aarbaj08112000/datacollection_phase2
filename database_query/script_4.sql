ALTER TABLE `form_field_master` CHANGE `field_type` `field_type` ENUM('Number','Text','AlphaNumeric','Date','Uppecase','TitleCase','SentenceCase','Email') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL;
ALTER TABLE `school_matser` CHANGE `form_type` `form_type` ENUM('collage','school','office') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;
