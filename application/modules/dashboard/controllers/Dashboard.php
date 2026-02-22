<?php

defined('BASEPATH') or exit('No direct script access allowed');
#Test auto deployment
class Dashboard extends MY_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('Dashboard_model');
        $this->unit = '';
        ini_set('memory_limit', '512M');
        
    }
    public function dashboard_old(){
       checkGroupAccess("dashboard","list");
       $data = $this->acmData();
       $data['selected_unit'] = $this->session->userdata('clientUnit');
       $data['unit_data'] = $this->Dashboard_model->get_unit();
       $current_year = date("Y");
       if(date("m") < 4){
        $current_year--;
       }
      
       $start_year = 2018;
       $year = [];
       for ($i= $current_year; $i >= $start_year; $i--) { 
           array_push($year, ['id'=>$i,'val'=>$i]);
       }
       $data['year'] = $year;
       $data['month_arr'] = [['id'=>'4','val'=>'Apr'],['id'=>'5','val'=>'May'],['id'=>'6','val'=>'Jun'],['id'=>'7','val'=>'Jul'],['id'=>'8','val'=>'Aug'],['id'=>'9','val'=>'Sep'],['id'=>'10','val'=>'Oct'],['id'=>'11','val'=>'Nov'],['id'=>'12','val'=>'Dec'],['id'=>'1','val'=>'Jan'],['id'=>'2','val'=>'Feb'],['id'=>'3','val'=>'Mar']];
       $data['customer_type'] = $this->session->userdata("AROMCustomerType");

       // get active menu
       $selected_menu = "";
       if(checkGroupAccess("dashboard_ba","list",false)){
            $selected_menu = "dashboard_ba";
       }else if(checkGroupAccess("dashboard_pending_task","list",false)){
            $selected_menu = "dashboard_pending_task";
       }else if(checkGroupAccess("dashboard_sales","list",false)){
            $selected_menu = "dashboard_sales";
       }else if(checkGroupAccess("dashboard_account","list",false)){
            $selected_menu = "dashboard_account";
       }else if(checkGroupAccess("dashboard_purchase_grn","list",false)){
            $selected_menu = "dashboard_purchase_grn";
       }else if(checkGroupAccess("dashboard_store","list",false)){
            $selected_menu = "dashboard_store";
       }else if(checkGroupAccess("dashboard_subcon","list",false)){
            $selected_menu = "dashboard_subcon";
       }else if(checkGroupAccess("dashboard_production","list",false)){
            $selected_menu = "dashboard_production";
       }else if(checkGroupAccess("dashboard_quality","list",false)){
            $selected_menu = "dashboard_quality";
       }
       $data['selected_menu'] = $selected_menu;
       $data['isMultipleClientUnits'] = $this->session->userdata("isMultipleClientUnits");
       $config_data = $this->session->userdata('entitlements');
       $data['isSheetMetal'] = $config_data['isSheetMetal'] ? "Yes" : "No";
       $current_year = date("Y");
        if(date("m") < 4) {
            $current_year--;
        }
        $financial_year = "FY-$current_year";
        $data['financial_year'] = $financial_year;
        $month =  strtoupper(date("M"));
        $data['month'] = $month;
        
       $this->loadView("dashboard/dashboard",$data);
    }
    public function dashboard(){
        // pr(checkGroupAccess("dashboard","list","No"),1);
		checkGroupAccess("dashboard","list","Yes");
		$data['base_url'] = base_url();
		$colleges = $this->Dashboard_model->get_school_data();
		$date = date("Y-m-d");
		$today_count = $this->Dashboard_model->get_school_data($date);
		$today_count = array_column($today_count,"total_record","school_id");
		$channelPatnerData = [];
		$schoolData = [];
		foreach ($colleges as $key => $value) {
			$colleges[$key]['today_response'] = isset($today_count[$value['school_id']]) && $today_count[$value['school_id']] > 0 ? $today_count[$value['school_id']] : 0;
			if($value['channel_patner_id'] > 0 ){
				$channelPatnerData[] = $colleges[$key];
			}
			if($value['user_role'] == "School" ){
				$schoolData[] = $colleges[$key];
			}
			
		}
		$selected_menu = "";
        // pr(checkGroupAccess("overall_detail_tab","list",false),1);
		if(checkGroupAccess("overall_detail_tab","list",false)){
				$selected_menu = "overall_detail_tab";
		}else if(checkGroupAccess("channel_patner_tab","list",false)){
				$selected_menu = "channel_patner_tab";
		}else if(checkGroupAccess("school_tab","list",false)){
				$selected_menu = "school_tab";
		}
		$data['selected_menu'] = $selected_menu;
		// pr($selected_menu,1);
		$data['colleges'] = $colleges;
		$data['channelPatnerData'] = $channelPatnerData;
		$data['schoolData'] = $schoolData;
		// pr($schoolData,1);
		
		$this->smarty->loadView('dashboard.tpl',$data,'Yes','Yes');
	}
    public function acmData()
	{
		/* acm dashboard */
		$queryval = $this->db->select_sum('calibration_charges')->get('history_variable_instruments');
        $resultval = $queryval->row();
        $data['totalvariablecalvalue'] = $resultval->calibration_charges;
        
        $queryatr = $this->db->select_sum('calibration_charges')->get('history_attribute');
        $resultatr = $queryatr->row();
        $data['totalatrcalvalue'] = $resultatr->calibration_charges;
        
        $totalvariableassets=0;
        $variableredassets = 0;
        $variablepurchasedvalue = 0;
		$variableblackassets = 0;
		$variableyellowassets = 0;
        
		$variable_instruments_list =$this->Common_admin_model->read_data("variable_instruments");
        
		if(!empty($variable_instruments_list))
		{
        foreach ($variable_instruments_list as $pv) 
        {
			
            $variablepurchasedvalue += !empty($pv->purchased_value) ? (int) $pv->purchased_value:0;
            
            $variable_instruments_counts = $this->Common_admin_model->get_data_by_id_count_new('history_variable_instruments', $pv->id, 'instrument_id ');
        		if(empty($variable_instruments_list))
        		{
        		    $totalvariableassets = '0';
        		}
        		else
        		{
        		    $totalvariableassets = count($variable_instruments_list);
                    
        		    $variable_history_instruments = $this->Common_admin_model->get_data_by_id_data('history_variable_instruments', $pv->id, 'instrument_id');
        		    
                    if(!(empty($variable_history_instruments)))
        		    {
        		    $variable_due_calibration_date = $variable_history_instruments[0]->due_calibration_date;
                        $current_date = date("Y-m-d");
                    		
                		$date = date_create($variable_due_calibration_date);
                		$current_date = date_create($current_date);
                
                		$diff = date_diff($current_date, $date);
                		$diff = $diff->format("%r%a");
                		
                		if ($diff > 30) 
                                    {
                                           
                            		} 
                            		else if ($diff <= 15 && $diff > 0) 
                            	    {
                            	        $variableredassets = $variableredassets + 1;
                            		} 
                            		else if ($diff < 0) 
                            		{
                                		$variableblackassets = $variableblackassets + 1;
                            		} 
                            		else 
                            		{
                            		    $variableyellowassets = $variableyellowassets + 1;
                            		}
        		    }
        		}
        }
		}
        $data['totalvariableassets'] = $totalvariableassets;
        $data['variableredassets'] = $variableredassets;
        $data['variablepurchasedvalue'] = $variablepurchasedvalue;
        $data['variableblackassets'] = $variableblackassets;
        $data['variableyellowassets'] = $variableyellowassets;
        
        
        
        // Attribute
        
        $totalattrassets=0;
        $attriredassets = 0;
		$attriblackassets = 0;
		$attriyellowassets = 0;
		$attributepurchasedvalue = 0;
        
		$attributs_list =$this->Common_admin_model->read_data("attributes");
		if(!empty($attributs_list))
		{
			foreach ($attributs_list as $pa) 
			{
				$attributepurchasedvalue += $pa->purchased_value;
				$attributs_instruments_counts = $this->Common_admin_model->get_data_by_id_count_new('history_attribute', $pa->id, 'instrument_id ');
					if(empty($attributs_list))
					{
						$totalattrassets = '0';
					}
					else
					{
						$totalattrassets = count($attributs_list);
						$attribute_history_instruments = $this->Common_admin_model->get_data_by_id_data('history_attribute', $pa->id, 'instrument_id');
						if(!(empty($attribute_history_instruments)))
						{
							$attributes_due_calibration_date = $attribute_history_instruments[0]->due_calibration_date;
							$attribute_current_date = date("Y-m-d");
									
							$attribute_date = date_create($attributes_due_calibration_date);
							$attribute_current_date = date_create($attribute_current_date);
					
							$attribute_diff = date_diff($attribute_current_date, $attribute_date);
							$attribute_diff = $attribute_diff->format("%r%a");
								
								if ($attribute_diff > 30) 
											{
												
											} 
											else if ($attribute_diff <= 15 && $attribute_diff > 0) 
											{
												$attriredassets = $attriredassets + 1;
											} 
											else if ($attribute_diff < 0) 
											{
												$attriblackassets = $attriblackassets + 1;
											} 
											else 
											{
												$attriyellowassets = $attriyellowassets + 1;
											}
						}
					}
			}
		}
        
        $data['totalattrassets'] = $totalattrassets;
        $data['attriredassets'] = $attriredassets;
        $data['attributepurchasedvalue'] = $attributepurchasedvalue;
        $data['attriblackassets'] = $attriblackassets;
        $data['attriyellowassets'] = $attriyellowassets;
        
		
        return $data;
	}
    public function get_dashboard_widget_data()
    {
//         ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);
        $post_data = $this->input->post(); 
        $widget_name = $post_data['widget_name'];
        $tab_name = $post_data['tab_name'];
        $year = $post_data['year'];
        $month = $post_data['month'] == 'All' ? '' : $post_data['month'];
        $this->unit = $post_data['unit'] == 'All' ? '' : $post_data['unit'];
        $widgets = $this->Dashboard_model->get_widgets($tab_name,$widget_name);
        $widget_data_arr = [];
        // finatial year condition
            // month wise filter 
            if((int) $month > 0){
                $month_arr = ["year"=>$year,"month"=>$month];
            }else{
                $month_arr = ["start_year"=>$year,"start_month"=>4,"end_year"=>$year+1,"end_month"=>3];
            }
        foreach ($widgets as $key => $value) {
            $function_name = $value['widget_funtion'];
            // pr($function_name,1);
            $widget_data = $this->$function_name($year,$month_arr,$unit);

            $return_arr['widget_name'] = $value['widget_name'];
            $return_arr['widget_type'] = $value['widget_type'];
            $return_arr['widget_data'] = $widget_data;
            array_push($widget_data_arr, $return_arr);
        }
        // pr($widget_data_arr);
        // pr("ok1",1);
	// Manually end monitoring
    	
        //echo json_encode($widget_data_arr);
        //exit();
	
	$this->output
        //->set_content_type('application/json')
        ->set_output(json_encode($widget_data_arr));
    }

    // Sales Tab

    public function get_total_users($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_total_users();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_total_employee($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_total_employee();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_total_channel_patner($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_total_channel_patner();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_total_school($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_total_school();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_today_generated_link($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_today_generated_link();
        // pr($this->db->last_query(),1);
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_yesterday_generated_link($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_yesterday_generated_link();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_current_month_generated_link($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_current_month_generated_link();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_current_year_generated_link($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_current_year_generated_link();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_today_generated_link_chanel($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_today_generated_link_chanel();
        // pr($this->db->last_query(),1);
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_yesterday_generated_link_chanel($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_yesterday_generated_link_chanel();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_current_month_generated_link_chanel($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_current_month_generated_link_chanel();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_current_year_generated_link_chanel($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_current_year_generated_link_chanel();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

     public function get_today_generated_link_school($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_today_generated_link_school();
        // pr($this->db->last_query(),1);
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_yesterday_generated_link_school($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_yesterday_generated_link_school();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_current_month_generated_link_school($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_current_month_generated_link_school();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }

    public function get_current_year_generated_link_school($year = '',$month_arr = []){
        $user_data = $this->Dashboard_model->get_current_year_generated_link_school();
        $count_arr['count'] = $user_data['total_user'];// - $total_discount;
        return $count_arr;
    }


}