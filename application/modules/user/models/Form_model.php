<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Form_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }
    public function getFieldData($allowFileds = []){
        $this->db->select('f.*');
        $this->db->from('form_field_master as f');
        if(is_array($allowFileds) && count($allowFileds) > 0){
            $this->db->where_in('f.form_field_master_id', $allowFileds);
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function insertSchoolData($insert_date = array()){
        $this->db->insert("school_matser", $insert_date);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }
    public function deleteSchoolData($school_id){
        $this->db->where('school_id', $school_id);
        $this->db->delete('school_matser');
    }
    public function updateSchoolData($update_data, $id) {
        $this->db->where('school_id', $id);
        $this->db->update('school_matser', $update_data);
        $afftectedRows = $this->db->affected_rows() > 0 ? $this->db->affected_rows() : 1; 
        return $afftectedRows;
    }



    /* school listing */
    public function getSchoolData($condition_arr = [],$search_params = "",$is_deleted = 0){
        
        $this->db->select('sm.*,COUNT(fdc.school_master_id) as total_record,ua.user_name as channel_patner');
        $this->db->from('school_matser sm');
        $this->db->join('form_data_collection as fdc','fdc.school_master_id = sm.school_id','left');
        $this->db->join('userinfo as ua','ua.id = sm.channel_patner_id','left');
        if($this->session->userdata("role") == "ChannelPartner" || $this->session->userdata("role") == "School"){
            $this->db->where('sm.channel_patner_id',$this->session->userdata("user_id"));
        }
        $this->db->where('sm.is_delete',$is_deleted);
        if (!empty($search_params['value'])) {
            $keyword = $search_params['value'];
            $this->db->group_start(); // Start a group of OR conditions
    
            $fields = [
                'sm.name', // Replace 'some_field' with actual fields in 'customer_po_tracking' you want to search
                'sm.url',
                'sm.status',
                'sm.contact_person',
                'sm.mobile_number',
                'sm.address',
                'ua.user_name',
                // Add more fields if needed
            ];
    
            foreach ($fields as $field) {
                $this->db->or_like($field, $keyword);
            }
    
            $this->db->group_end(); // End the group of OR conditions
        }
        
        if (count($condition_arr) > 0) {
            if($condition_arr["length"] > 0 ){
                $this->db->limit($condition_arr["length"], $condition_arr["start"]);
            }
            
            if ($condition_arr["order_by"] != "") {
                $this->db->order_by($condition_arr["order_by"]);
            }else{
                $this->db->order_by("sm.school_id","DESC");
            }
        }
        $this->db->group_by('sm.school_id');
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        // pr($this->db->last_query(),1);
        return $ret_data;
    }

    public function getSchoolDataCount($condition_arr = [],$search_params = "",$is_deleted = 0){
        
        $this->db->select('COUNT(sm.school_id) as total_record');
        $this->db->from('school_matser sm');
        $this->db->join('userinfo as ua','ua.id = sm.channel_patner_id','left');
        if($this->session->userdata("role") == "ChannelPartner" || $this->session->userdata("role") == "School"){
            $this->db->where('sm.channel_patner_id',$this->session->userdata("user_id"));
        }
        $this->db->where('sm.is_delete',$is_deleted);
        if (!empty($search_params['value'])) {
            $keyword = $search_params['value'];
            $this->db->group_start(); // Start a group of OR conditions
    
            $fields = [
                'sm.name', // Replace 'some_field' with actual fields in 'customer_po_tracking' you want to search
                'sm.url',
                'sm.status',
                'sm.contact_person',
                'sm.mobile_number',
                'sm.address',
                'ua.user_name',
                // Add more fields if needed
            ];
    
            foreach ($fields as $field) {
                $this->db->or_like($field, $keyword);
            }
    
            $this->db->group_end(); // End the group of OR conditions
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        // pr($this->db->last_query(),1);
        return $ret_data;
    }


    /* form field listing */
    public function getFieldDetails($condition_arr = [],$search_params = ""){
        
        $this->db->select('f.*,ua.user_name as added_by,uu.user_name as updated_by');
        $this->db->from('form_field_master f');
        $this->db->join('userinfo as ua','ua.id = f.added_by','left');
        $this->db->join('userinfo as uu','uu.id = f.updated_by','left');
        if (!empty($search_params['value'])) {
            $keyword = $search_params['value'];
            $this->db->group_start(); // Start a group of OR conditions
    
            $fields = [
                'f.form_title', 'f.form_name','f.form_type','f.field_type','f.form_value','f.prefix','f.length',
                'ua.user_name','uu.user_name'
                // Add more fields if needed
            ];
    
            foreach ($fields as $field) {
                $this->db->or_like($field, $keyword);
            }
    
            $this->db->group_end(); // End the group of OR conditions
        }

        if (count($condition_arr) > 0) {
            if($condition_arr["length"] > 0 ){
            $this->db->limit($condition_arr["length"], $condition_arr["start"]);
            }
            if ($condition_arr["order_by"] != "") {
                $this->db->order_by($condition_arr["order_by"]);
            }else{
                $this->db->order_by("f.form_field_master_id","DESC");
            }
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        // pr($this->db->last_query(),1);
        return $ret_data;
    }


    public function getFieldDetailsCount($condition_arr = [],$search_params = ""){
        
         $this->db->select('COUNT(f.form_field_master_id) as total_record');
        $this->db->from('form_field_master f');
        $this->db->join('userinfo as ua','ua.id = f.added_by','left');
        $this->db->join('userinfo as uu','uu.id = f.updated_by','left');
        if (!empty($search_params['value'])) {
            $keyword = $search_params['value'];
            $this->db->group_start(); // Start a group of OR conditions
    
            $fields = [
                'f.form_title', 'f.form_name','f.form_type','f.field_type','f.form_value','f.prefix','f.length',
                'ua.user_name','uu.user_name'
                // Add more fields if needed
            ];
    
            foreach ($fields as $field) {
                $this->db->or_like($field, $keyword);
            }
    
            $this->db->group_end(); // End the group of OR conditions
        }

        
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        // pr($this->db->last_query(),1);
        return $ret_data;
    }

    /* dyanamic form creation */
    public function checkDublicateUrl($page_url = ""){
        $this->db->select('sm.*');
        $this->db->from('school_matser as sm');
        $this->db->where("url",$page_url);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }
    public function getFormJson($page_url = ""){
        $this->db->select('sm.*');
        $this->db->from('school_matser as sm');
        $this->db->where("url",$page_url);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }
    public function insertFormData($insert_date = array()){
        $this->db->insert("form_data_collection", $insert_date);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }
    public function updateFormData($update_data, $id) {
        $this->db->where('form_data_collection_id', $id);
        $this->db->update('form_data_collection', $update_data);
        $afftectedRows = $this->db->affected_rows() > 0 ? $this->db->affected_rows() : 1; 
        return $afftectedRows;
    }
    public function getFormJsonData($school_id = ""){
        $this->db->select('sm.*');
        $this->db->from('school_matser as sm');
        $this->db->where("school_id",$school_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }
    public function getFormCollectionData($from_data_collection_id = 0){
        $this->db->select('fdc.*');
        $this->db->from('form_data_collection as fdc');
        $this->db->where("fdc.form_data_collection_id",$from_data_collection_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }
    public function getSchoolFormCollectionData($school_id = 0,$from_data_id = 0,$selected_ids = ""){
        
        $this->db->select('fdc.*');
        $this->db->from('form_data_collection as fdc');
        $this->db->where("fdc.school_master_id",$school_id);
        if($from_data_id > 0){
            $this->db->where("fdc.form_data_collection_id",$from_data_id); 
        }
        if($selected_ids != ""){
            $this->db->where_in("fdc.form_data_collection_id",explode(",", $selected_ids)); 
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function checkFormFieldUnique($form_name = "",$id = 0){
        $this->db->select('fdc.*');
        $this->db->from('form_field_master as fdc');
        $this->db->where("fdc.form_name",$form_name);
        if($id > 0){
            $this->db->where("fdc.form_field_master_id !=",$id);
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function insertFormField($insert_date = array()){
        $this->db->insert("form_field_master", $insert_date);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }
    public function updateFormField($update_data, $id) {
        $this->db->where('form_field_master_id', $id);
        $this->db->update('form_field_master', $update_data);
        return true;
    }
    public function deleteFieldMasterRow($data_id){
        $this->db->where('form_field_master_id', $data_id);
        $this->db->delete('form_field_master');
    }

    public function getFormDetails($condition_arr = [],$search_params = "",$school_id = "",$row_search){
        $this->db->select('fd.*,sm.url as url');
        $this->db->from('form_data_collection as fd');
        $this->db->join('school_matser as sm','sm.school_id = fd.school_master_id','left');                                                                                                  
        $this->db->where("fd.school_master_id",$school_id);
        if (count($condition_arr) > 0) {
            if($condition_arr["length"] > 0 ){
            $this->db->limit($condition_arr["length"], $condition_arr["start"]);
            }
        }
            if(count($row_search) > 0){
                foreach ($row_search as $key => $value) {
                    if($value['key'] != "sr_no" && $value['key'] != "card_generated"){
                        $name= $value['key'];
                        $val= $value['val'];
                        $this->db->where("fd.form_data LIKE '%\"$name\": \"$val%' ESCAPE '!'", null, false);
                    }else if($value['key'] == "card_generated"){
                        $name= $value['key'];
                        $val= $value['val'];
                        $this->db->like("fd.card_generated",$value['val']);
                    }else{
                        $this->db->where("fd.sr_no",$value['val']);
                    }
                }
            }
            if (!empty($search_params['value'])) {
                $keyword = $search_params['value'];
                $this->db->group_start(); 
                $fields = [
                    'fd.form_data'
                ];
        
                foreach ($fields as $field) {
                    $this->db->or_like($field, $keyword);
                }
        
                $this->db->group_end(); // End the group of OR conditions
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        // pr($this->db->last_query(),1);
        return $ret_data;
    }
    public function getSchoolFormCollectionDataCount($school_id = 0){
        
        $this->db->select('fdc.sr_no as count');
        $this->db->from('form_data_collection as fdc');
        $this->db->where("fdc.school_master_id",$school_id);
        $this->db->order_by("fdc.form_data_collection_id","DESC");
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }
    public function get_school_data($date = ""){
        
        $this->db->select('sm.*,COUNT(fdc.school_master_id) as total_record,u.user_name as channel_patner_name,ua.user_role');
        $this->db->from('school_matser sm');
        $this->db->join('form_data_collection as fdc','fdc.school_master_id = sm.school_id','left');
        $this->db->join('userinfo as u','u.id = sm.channel_patner_id','left');
        $this->db->join('userinfo as ua','ua.id = sm.added_by','left');
        $this->db->where("sm.is_delete",0);
        if($date != "" && $date != null){
            $this->db->where("DATE(sm.added_date) =", $date);
        }
        $this->db->group_by('sm.school_id');
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function getSchoolFormCollectionDetail($school_id = 0){
        
        $this->db->select('fdc.*');
        $this->db->from('school_matser as fdc');
        $this->db->where("fdc.school_id",$school_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }
    public function getChannelPatnerList(){
        $this->db->select('u.*');
        $this->db->from('userinfo as u');
        $this->db->where("u.user_role","ChannelPartner");
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function checkChannelPatnerAccessFormData($channel_patner_id = 0,$school_id=0){
        $this->db->select('fdc.*');
        $this->db->from('school_matser as fdc');
        $this->db->where("fdc.channel_patner_id",$channel_patner_id);
        $this->db->where("fdc.school_id",$school_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function getFormCollectionEditData($from_data_collection_id = 0){
        $this->db->select('fdc.*,sm.*');
        $this->db->from('form_data_collection as fdc');
        $this->db->join('school_matser as sm','sm.school_id = fdc.school_master_id','left');
        $this->db->where("fdc.form_data_collection_id",$from_data_collection_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function updateCardGenerated($ids = [],$status = "") {
        $update_data = ["card_generated"=>$status];
        $this->db->where_in('form_data_collection_id', $ids);
        $this->db->update('form_data_collection', $update_data);
        $afftectedRows = $this->db->affected_rows() > 0 ? $this->db->affected_rows() : 1; 
        return $afftectedRows;
    }

    public function insertBatchFormData($insert_date = array()){
        $this->db->insert_batch("form_data_collection", $insert_date);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }

    /* design changes */
    public function save_design($design_data = []) {
        
        if(!is_array($design_data) && count($design_data) <= 0) return [];
       
        if(!empty($design_data['entity_id'])){
            $old_data = $this->get_design($design_data['entity_id']);
        }
        if (!empty($design_data['entity_id']) && (is_array($old_data) && count($old_data) > 0)){
            
            $this->db->where('entity_id', $design_data['entity_id']);
            $this->db->update('id_card_designs', $design_data);
           
            // return $design_data['entity_id'];
        } else {
            $this->db->insert('id_card_designs', $design_data);
            // return $this->db->insert_id();
        }
        
    }

    public function get_design($id) {
        
        $design = $this->db->get_where('id_card_designs', ['entity_id' => $id])->row_array();
        if ($design) {
            $design_data = json_decode($design['design_data'], true);
            $design['design_data'] = $design_data;
            if ($design['background_image']) {
                $design_data['backgroundImage'] = base_url($design['background_image']);
            }
        }
        return $design;
        
    }

    public function get_all_designs() {
        return $this->db->get('id_card_designs')->result_array();
    }

    public function getIdCardFieldComp($school_id = 0){
        $this->db->select('idd.design_data as design_data,idd.background_image,idd.width,idd.height,col_per_row');
        $this->db->from('id_card_designs as idd');
        $this->db->where("idd.entity_id",$school_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }
    public function getGroupdFieldData($group_code = ""){
        $this->db->select('gfc.*');
        $this->db->from('group_master as g');
        $this->db->join('group_field_config as gfc','gfc.group_master_id = g.group_master_id','left');
        $this->db->where("g.group_code",$group_code);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    
    
}
