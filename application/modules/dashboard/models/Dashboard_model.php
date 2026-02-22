<?php
class Dashboard_model extends CI_Model
{
    function __construct()
    {
        parent::__construct();
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

    public function get_unit($tab_name = '',$widget_name = '')
	{
	    $this->db->select('c.id as id,c.client_unit as val');
	    $this->db->from('client as c');
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
	    return $ret_data;
	}

    public function get_widgets($tab_name = '',$widget_name = '')
	{
		
	    $this->db->select('w.*');
	    $this->db->from('widget as w');
	    $this->db->where('w.tab_name',$tab_name);
	    if($widget_name != '' && $widget_name != null){
	    	$this->db->where('w.widget_name',$widget_name);
	    }
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
	    return $ret_data;
	}


	// Overview tab

	public function get_total_users($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.id) as total_user');
	    $this->db->from('userinfo as u');
		$this->db->where('u.user_role != ',"SuperAdmin");
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_total_employee($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.id) as total_user');
	    $this->db->from('userinfo as u');
		$this->db->where('u.user_role',"Employee");
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_total_channel_patner($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.id) as total_user');
	    $this->db->from('userinfo as u');
		$this->db->where('u.user_role',"ChannelPartner");
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_total_school($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.id) as total_user');
	    $this->db->from('userinfo as u');
		$this->db->where('u.user_role',"School");
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_today_generated_link($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->where("DATE(u.added_date) =", date('Y-m-d'));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_yesterday_generated_link($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->where('DATE(u.added_date)', date('Y-m-d', strtotime('-1 day')));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_current_month_generated_link($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->where('u.added_date >=', date('Y-m-01'));
		$this->db->where('u.added_date <', date('Y-m-01', strtotime('+1 month')));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_current_year_generated_link($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->where('u.added_date >=', date('Y-01-01'));
		$this->db->where('u.added_date <', date('Y-01-01', strtotime('+1 year')));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_today_generated_link_chanel($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->where("u.channel_patner_id > ",0);
		$this->db->where("DATE(u.added_date) =", date('Y-m-d'));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_yesterday_generated_link_chanel($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->where("u.channel_patner_id > ",0);
		$this->db->where('DATE(u.added_date)', date('Y-m-d', strtotime('-1 day')));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_current_month_generated_link_chanel($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->where("u.channel_patner_id > ",0);
		$this->db->where('u.added_date >=', date('Y-m-01'));
		$this->db->where('u.added_date <', date('Y-m-01', strtotime('+1 month')));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_current_year_generated_link_chanel($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->where("u.channel_patner_id > ",0);
		$this->db->where('u.added_date >=', date('Y-01-01'));
		$this->db->where('u.added_date <', date('Y-01-01', strtotime('+1 year')));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}
	public function get_today_generated_link_school($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->join('userinfo as ua','ua.id = u.added_by AND ua.user_role = "School"');
		$this->db->where("u.channel_patner_id > ",0);
		$this->db->where("DATE(u.added_date) =", date('Y-m-d'));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_yesterday_generated_link_school($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->join('userinfo as ua','ua.id = u.added_by AND ua.user_role = "School"');
		$this->db->where("u.channel_patner_id > ",0);
		$this->db->where('DATE(u.added_date)', date('Y-m-d', strtotime('-1 day')));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_current_month_generated_link_school($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->join('userinfo as ua','ua.id = u.added_by AND ua.user_role = "School"');
		$this->db->where("u.channel_patner_id > ",0);
		$this->db->where('u.added_date >=', date('Y-m-01'));
		$this->db->where('u.added_date <', date('Y-m-01', strtotime('+1 month')));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	public function get_current_year_generated_link_school($year = '',$month_arr = '')
	{
	    $this->db->select('COUNT(u.school_id) as total_user');
	    $this->db->from('school_matser as u');
		$this->db->join('userinfo as ua','ua.id = u.added_by AND ua.user_role = "School"');
		$this->db->where("u.channel_patner_id > ",0);
		$this->db->where('u.added_date >=', date('Y-01-01'));
		$this->db->where('u.added_date <', date('Y-01-01', strtotime('+1 year')));
	    $result_obj = $this->db->get();
	    $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
	    return $ret_data;
	}

	

}

?>
