<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_user_details($email ="",$password="")
	{
		$this->db->select('*');
		$this->db->from('userinfo u');
		$this->db->where('u.user_email', $email);
		$this->db->where('u.user_password', $password);
		$this->db->where('u.status', 'Active');
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function get_user_exist($email ="")
	{
		$this->db->select('*');
		$this->db->from('userinfo u');
		$this->db->where('u.user_email', $email);
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function updateUserData($update_date = array(),$user_id = 0){
        $this->db->where('id', $user_id);
        $this->db->update('userinfo', $update_date);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
        return $affected_rows;
    }
	public function get_company_details($company_id)
	{
		$this->db->select('*');
		$this->db->from('userinfo u');
		$this->db->where('u.user_email', $email);
		$this->db->where('u.user_password', $password);
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function getGroupRightData($group_id = [],$menu_url = ''){
        $group_id = explode(",",$group_id);
        $this->db->select('g.*,m.diaplay_name,m.url');
        $this->db->from('group_rights as g');
        $this->db->join("menu_master as m","m.menu_master_id = g.menu_master_id");
        $this->db->where_in("g.group_master_id",$group_id);
        if($menu_url != ""){
            $this->db->where("m.url",$menu_url);
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function get_user_exist_check($usename="")
	{
		$this->db->select('*');
		$this->db->from('userinfo u');
		$this->db->where('u.user_email', $usename);
		$this->db->where('u.status', 'Active');
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function check_otp($otp ='',$user_id ="")
	{
		$this->db->select('u.*');
		$this->db->from('userinfo u');
		$this->db->where('u.otp', $otp);
		$this->db->where('u.id', $user_id);
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function get_user_data($user_id=0)
	{
		$this->db->select('u.*');
		$this->db->from('userinfo u');
		$this->db->where('u.id', $user_id);
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function get_user_admin_data()
	{
		$this->db->select('u.*');
		$this->db->from('userinfo u');
		$this->db->where('u.user_role', "Admin");
		$this->db->where('u.user_role !=', "SuperAdmin");
		$this->db->order_by("u.id","ASC");
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}

	public function getGroupData($group_code = ""){
        $this->db->select('u.*');
		$this->db->from('group_master u');
		$this->db->where('u.group_code', $group_code);
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
    }
	public function insertUser($insert_date = array()){
        $this->db->insert("userinfo", $insert_date);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }

	public function insertRegistraionOtp($insert_date = array()){
        $this->db->insert("registration_otp", $insert_date);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }
	public function getRegistraionOtp($code = ""){
        $this->db->select('u.*');
		$this->db->from('registration_otp u');
		$this->db->where('u.code', $code);
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
    }
	
    
}
