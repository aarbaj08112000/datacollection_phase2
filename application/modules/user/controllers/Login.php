<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Login extends MY_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->model('Login_model');
        $this->load->model('form_model');
    }
	public function index() {
		$data['base_url'] = base_url();
		$this->smarty->loadView('login.tpl',$data,'No','No');
	}
	public function logout()
	{

		$user_data = array();
		$this->session->set_userdata($user_data);
		unset($_SESSION["userdata"]);
		session_destroy();
		redirect(base_url("login"));
	}
	public function signin()
	{
		$login_attempt_count = $this->config->item("login_attempt");
		$user_id = 0;
		// pr($_POST,1);
		// $data['userInfo'] = $this->Crud->read_data("userInfo");
		$this->form_validation->set_rules('email', ' Email', 'trim|required|min_length[3]');
		$this->form_validation->set_rules('password', ' Password', 'trim|required|min_length[3]');

		$email = trim($this->input->post('email'));
		$password = $this->input->post('password');
		$result = $this->Login_model->get_user_details($email, $password);	
		
		$redirect_url = "";
		if (empty($result)) {
			$result = $this->Login_model->get_user_exist($email);
			$success = 0;
			if($result['login_attempt'] > $login_attempt_count){
				$messages = "User temporary block!";
				$update_data = array(
	                'status' => "Block",
	            );
			}else{
				$login_attempt = $result['login_attempt']+1;
				$update_data = array(
	                'login_attempt' => $login_attempt,
	            );
				$messages = "Invalid credentials!";
			}
			if(!in_array($result['user_role'],['Admin','SuperAdmin'])){
				$result = $this->Login_model->updateUserData($update_data, $result['id']);	
			}			
		} else {
			
			$company_name =$this->config->item('company_name');
			$sent_email = $email;
			$data['base_url'] = base_url();
			$otp = rand(100000, 999999); // Generate 6-digit OTP
			// $data['subject'] = $company_name . " Login OTP";
			// $data['msg'] = "
			// 		<html>
			// 		<head>
			// 			<title>OTP for Login</title>
			// 		</head>
			// 		<body style='font-family: Arial, sans-serif;'>
			// 			<div style='max-width: 500px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;'>
			// 				<h2 style='color: #333;'>Your OTP for Login</h2>
			// 				<p style='font-size: 16px; color: #555;'>
			// 					Your OTP for login is: <strong style='font-size: 18px; color: #000;'>$otp</strong>
			// 				</p>
			// 				<p style='font-size: 14px; color: #888;'>
			// 					Please do not share this OTP with anyone. It is valid for 10 minutes.
			// 				</p>
			// 				<br>
			// 				<p style='font-size: 14px; color: #555;'>Best regards,<br><strong>$company_name</strong></p>
			// 			</div>
			// 		</body>
			// 		</html>
			// ";
				
			// sent_email($data,$sent_email);
// 			$otp = "271078";
			$update_data = array(
				'otp' => $otp
			);
			$update_result = $this->Login_model->updateUserData($update_data, $result['id']);
			$role_arr = ['Admin','ChannelPartner','SuperAdmin'];
			if(in_array($result['user_role'],$role_arr)){
				$email = $result['user_email'];
				$user_mobile_number = $result['user_mobile_number'];
			}else{
				$user_admin_data = $this->Login_model->get_user_admin_data();
				$email = $user_admin_data['user_email'];
				$user_mobile_number = $user_admin_data['user_mobile_number'];
			}
			if($update_result && $user_mobile_number != ""){
				sent_otp($otp,$user_mobile_number);
				$success = 1;
				$messages = "Otp send successfully";
				$user_id = $result['id'];
			}else{
				$messages = "Mobile number not valid!";
			}
			
		}
		$return_arr['redirect_url']= $redirect_url;
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		$return_arr['user_id']=$user_id;
		echo json_encode($return_arr);
		exit;
	}
	public function reset_password(){
		$username = $this->input->post('username');
		$result = $this->Login_model->get_user_exist_check($username);	
		if(is_valid_array($result)){
	        $success = 1;
			$messages = "Password reset link sent successfully to your email!";
			$user_id = $result['id'];
			$email_data = [
				"time_stramp" => time(),
				"user_id" => $user_id,
				"email_name" => "Reset Password ",
				"email_subject" => "Reset Password Of ".$this->config->item("company_name")
			];
			$this->email_sender($email_data,$result['user_email'],"forgot_password");
		}else{
			$success = 0;
			$messages = "User not exist";
		}
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		echo json_encode($return_arr);
		exit;
		
	}
	public function reset_password_action(){
		$post_data = $this->input->post();
		$update_data = array(
	        'user_password' => $post_data['password']
	    );
	    $result = $this->Login_model->updateUserData($update_data, $post_data['user_id']);
	    $success = 0;
		$messages = "Password not reset";
	    if($result > 0){
	    	$success = 1;
			$messages = "Password reset successful!";
	    }
	    $return_arr['redirect_url'] = "login";
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		echo json_encode($return_arr);
		exit;
	}
	public function forgot_password($timestamp="",$user_id){
		$current_time = time();
		$time_difference = $current_time - $timestamp;
		$expiry_time = $this->config->item("password_link_expiry")*60;
		$expired_link = "Yes";
		if ($time_difference <= $expiry_time) {
		    $expired_link = "No";
		}
		$data['base_url'] = base_url();
		$data['user_id'] = $user_id;
		$data['expired_link'] = $expired_link;
		$this->smarty->setTemplateDir(APPPATH.'modules/user/views/');
		$this->smarty->loadView('forgot_password.tpl',$data,'No','No');
	}
	public function site_map(){
		$data['base_url'] = base_url();
		$data['sitemap'] = true;
		$data['site_path'] = $this->config->item("site_path")."views/templates/quick_menu.tpl";
		$this->smarty->loadView('site_map.tpl',$data,'Yes','Yes');
	}
	public function dashboard(){
		checkGroupAccess("dashboard","list","Yes");
		$data['base_url'] = base_url();
		$colleges = $this->form_model->get_school_data();
		// pr($colleges,1);
		$data['colleges'] = $colleges;
		
		$this->smarty->loadView('dashboard.tpl',$data,'Yes','Yes');
	}
	
	public function opt_submit(){
		$post_data = $this->input->post();
		
		$result = $this->Login_model->check_otp($post_data['otp'],$post_data['user_id']);
		if($result){
			$this->session->unset_userdata($user_data);
			$user_data = array(
				'user_id' => $result['id'],
				'user_email' => $result['user_email'],
				'user_login' => true,
				'user_name' => $result['user_name'],
				'type' => $result['type'],
				'role' => $result['user_role'],
				'groups' => $result['groups']
			);
			$this->session->set_userdata($user_data);

			$group_rights = $this->Login_model->getGroupRightData($result['groups'],"");
			$this->session->set_userdata('group_rights_arr', base64_encode(json_encode($group_rights)));
			if(checkGroupAccess("dashboard","list","No")){
					$redirect_url = "dashboard";
			}else{
					$redirect_url = "form_listing";
			}

			$success = 1;
			$messages = "User login successfully!";
		
		}else{
			$success = 0;
			$messages = "Something went wrong. Please try again later.";
		}
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		$return_arr['redirect_url']=$redirect_url;
		echo json_encode($return_arr);
		exit;
	}
	public function resent_otp(){
		$post_data = $this->input->post();
		$user_data = $this->Login_model->get_user_data($post_data['user_id']);
		
		if($user_data['user_role'] == "Admin" || $user_data['user_role'] == "ChannelPartner" || $user_data['user_role'] == "SuperAdmin"){
			$email = $user_data['user_email'];
			$user_mobile_number = $user_data['user_mobile_number'];
		}else{
			$user_admin_data = $this->Login_model->get_user_admin_data();
			$email = $user_admin_data['user_email'];
			$user_mobile_number = $user_admin_data['user_mobile_number'];
		}
		$company_name =$this->config->item('company_name');
		$data['base_url'] = base_url();
		$otp = rand(100000, 999999); // Generate 6-digit OTP
		// $data['subject'] = $company_name . " Login OTP";
		// $data['msg'] = "
		// 		<html>
		// 		<head>
		// 			<title>OTP for Login</title>
		// 		</head>
		// 		<body style='font-family: Arial, sans-serif;'>
		// 			<div style='max-width: 500px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;'>
		// 				<h2 style='color: #333;'>Your OTP for Login</h2>
		// 				<p style='font-size: 16px; color: #555;'>
		// 					Your OTP for login is: <strong style='font-size: 18px; color: #000;'>$otp</strong>
		// 				</p>
		// 				<p style='font-size: 14px; color: #888;'>
		// 					Please do not share this OTP with anyone. It is valid for 10 minutes.
		// 				</p>
		// 				<br>
		// 				<p style='font-size: 14px; color: #555;'>Best regards,<br><strong>$company_name</strong></p>
		// 			</div>
		// 		</body>
		// 		</html>
		// 	";
		
		// sent_email($data,$email);
		
		$update_data = array(
			'otp' => $otp
		);
		$update_result = $this->Login_model->updateUserData($update_data, $post_data['user_id']);
		if($update_result){
			sent_otp($otp,$user_mobile_number);
			$success = 1;
			$messages = "OTP has been resent successfully!";
		}else{
			$success = 0;
			$messages = "Something went wrong. Please try again later.";
		}
		
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		echo json_encode($return_arr);
		exit;
	}
	
	
}

