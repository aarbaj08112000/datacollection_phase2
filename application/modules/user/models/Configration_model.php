<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Configration_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    /**
     * Get Configuration Settings with pagination and search
     */
    public function getConfigSettings($condition_arr = [], $search_params = "") {
        $this->db->select('cs.*');
        $this->db->from('config_setting cs');
        
        // Apply search filter
        if (!empty($search_params['value'])) {
            $keyword = $search_params['value'];
            $this->db->group_start();
            
            $fields = [
                'cs.name',
                'cs.title',
                'cs.value',
                'cs.description',
                'cs.type'
            ];
            
            foreach ($fields as $field) {
                $this->db->or_like($field, $keyword);
            }
            
            $this->db->group_end();
        }
        
        // Apply pagination and ordering
        if (count($condition_arr) > 0) {
            if ($condition_arr["length"] > 0) {
                $this->db->limit($condition_arr["length"], $condition_arr["start"]);
            }
            
            if ($condition_arr["order_by"] != "") {
                $this->db->order_by($condition_arr["order_by"]);
            } else {
                $this->db->order_by("cs.id", "ASC");
            }
        }
        
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        
        return $ret_data;
    }

    /**
     * Get Configuration Settings Count
     */
    public function getConfigSettingsCount($condition_arr = [], $search_params = "") {
        $this->db->select('COUNT(cs.id) as total_record');
        $this->db->from('config_setting cs');
        
        // Apply search filter
        if (!empty($search_params['value'])) {
            $keyword = $search_params['value'];
            $this->db->group_start();
            
            $fields = [
                'cs.name',
                'cs.title',
                'cs.value',
                'cs.description',
                'cs.type'
            ];
            
            foreach ($fields as $field) {
                $this->db->or_like($field, $keyword);
            }
            
            $this->db->group_end();
        }
        
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        
        return $ret_data;
    }

    /**
     * Get Configuration Setting by ID
     */
    public function getConfigSettingById($id) {
        $this->db->select('cs.*');
        $this->db->from('config_setting cs');
        $this->db->where('cs.id', $id);
        
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        
        return $ret_data;
    }

    /**
     * Get Configuration Setting by Name
     */
    public function getConfigSettingByName($name) {
        $this->db->select('cs.*');
        $this->db->from('config_setting cs');
        $this->db->where('cs.name', $name);
        
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        
        return $ret_data;
    }

    /**
     * Insert Configuration Setting
     */
    public function insertConfigSetting($insert_data = array()) {
        $this->db->insert("config_setting", $insert_data);
        $insert_id = $this->db->insert_id();
        
        return $insert_id;
    }

    /**
     * Update Configuration Setting
     */
    public function updateConfigSetting($update_data, $id) {
        $this->db->where('id', $id);
        $this->db->update('config_setting', $update_data);
        $affected_rows = $this->db->affected_rows() > 0 ? $this->db->affected_rows() : 1;
        
        return $affected_rows;
    }

    /**
     * Delete Configuration Setting
     */
    public function deleteConfigSetting($id) {
        $this->db->where('id', $id);
        $this->db->delete('config_setting');
        
        return true;
    }

    /**
     * Get All Configuration Settings (for config loading)
     */
    public function getAllConfigSettings() {
        $this->db->select('cs.*');
        $this->db->from('config_setting cs');
        $this->db->order_by('cs.name', 'ASC');
        
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        
        return $ret_data;
    }

    /**
     * Get Configuration Settings by Company ID
     */
    public function getConfigSettingsByCompanyId($company_id) {
        $this->db->select('cs.*');
        $this->db->from('config_setting cs');
        $this->db->where('cs.company_id', $company_id);
        $this->db->order_by('cs.name', 'ASC');
        
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        
        return $ret_data;
    }

    /**
     * ========================================
     * FIELD SELECTION MODULE METHODS
     * ========================================
     */

    /**
     * Get all groups with pagination and search
     */
    public function getAllGroups($condition_arr = [], $search_params = "") {
        $this->db->select('gm.*');
        $this->db->from('group_master gm');
        
        // Search functionality
        if (!empty($search_params["value"])) {
            $this->db->group_start();
            $this->db->like('gm.group_name', $search_params["value"]);
            $this->db->or_like('gm.group_code', $search_params["value"]);
            $this->db->group_end();
        }
        
        // Ordering
        if (isset($condition_arr["order_by"]) && $condition_arr["order_by"] != '') {
            $this->db->order_by($condition_arr["order_by"]);
        } else {
            $this->db->order_by('gm.group_name', 'ASC');
        }
        
        // Pagination
        if (isset($condition_arr["start"]) && isset($condition_arr["length"])) {
            if ($condition_arr["length"] != -1) {
                $this->db->limit($condition_arr["length"], $condition_arr["start"]);
            }
        }
        
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }

    /**
     * Get total count of groups
     */
    public function getAllGroupsCount($condition_arr = [], $search_params = "") {
        $this->db->select('COUNT(gm.group_master_id) as total_record');
        $this->db->from('group_master gm');
        
        // Search functionality
        if (!empty($search_params["value"])) {
            $this->db->group_start();
            $this->db->like('gm.group_name', $search_params["value"]);
            $this->db->or_like('gm.group_code', $search_params["value"]);
            $this->db->group_end();
        }
        
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : ['total_record' => 0];
    }

    /**
     * Get group by ID
     */
    public function getGroupById($group_id) {
        $this->db->select('*');
        $this->db->from('group_master');
        $this->db->where('group_master_id', $group_id);
        
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : null;
    }

    /**
     * Get all form fields from form_field_master
     */
    public function getAllFormFields() {
        $this->db->select('form_field_master_id as id, form_title as field_name, form_name as field_label, form_type');
        $this->db->from('form_field_master');
        $this->db->order_by('form_field_master_id', 'ASC');
        
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }

    /**
     * Get group field configuration
     */
    public function getGroupFieldConfig($group_id) {
        $this->db->select('*');
        $this->db->from('group_field_config');
        $this->db->where('group_master_id', $group_id);
        
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : null;
    }

    /**
     * Save or update group field configuration
     */
    public function saveGroupFieldConfig($data) {
        // Check if configuration already exists
        $existing = $this->getGroupFieldConfig($data['group_master_id']);
        
        if ($existing) {
            // Update existing configuration
            $this->db->where('group_master_id', $data['group_master_id']);
            return $this->db->update('group_field_config', [
                'selected_fields' => $data['selected_fields'],
                'updated_at' => date('Y-m-d H:i:s')
            ]);
        } else {
            // Insert new configuration
            return $this->db->insert('group_field_config', $data);
        }
    }
}