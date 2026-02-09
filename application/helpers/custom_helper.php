<?php 

function pr($data,$exit = 0)
{
        echo("<pre>");

        print_r($data);
        echo("</pre>");

        if($exit == 1){
        	exit;
        }
}
function convertDateTime($value =''){
	return new DateTime($value);
}

function display_no_character($value = ''){
	if($value == "" ||  $value == null ){
		$value = "--";
	}
	return $value;
}


function is_valid_array($data = []){
	if( is_array($data) && count($data) > 0){
		return true;
	}
	return false;
}
function defaultDateFormat($date = "") {
    // Define an array of possible input date formats
    $formats = [
    	'd/m/Y',
    	'd/Y/m',  // Format like 12-2024-02
        'Y/m/d',
        'Y/d/m',
        'd-m-Y',  // Format like 12-02-2024
        'd-Y-m',  // Format like 12-2024-02
        'Y-m-d',
        'Y-d-m'  // Format like 2024-12-02
    ];
    
    foreach ($formats as $format) {
        $dateTime = DateTime::createFromFormat($format, $date);
        if ($dateTime) {
            // Return the date in the desired format
            return $dateTime->format('d-m-Y');
        }
    }

    $date = $date == "" || $date == null ? display_no_character() : display_no_character();
    
    // Return false if none of the formats match
    return $date;
}

function formateFormDate($date =''){
	$date=date_create($date);
	$date = date_format($date,"Y-m-d");
	return $date;
}
function dbFormDate($date ='',$format = ""){
	$date=date_create($date);
	$date = date_format($date,$format);
	return $date;
}

 function getDefaultDateTime($str = ''){
	$formats = [
        'Y-m-d H:i:s',
        'd-m-Y H:i:s',
        'm/d/Y H:i:s', 
        'Y/m/d H:i:s', 
        'd/m/Y H:i:s',
        
    ];

    foreach ($formats as $format) {
        $dateTime = DateTime::createFromFormat($format, $str);
        if ($dateTime !== false) {
            return $dateTime->format('d/m/Y H:i:s');
        }
    }
}

function checkGroupAccess($page_url = "",$type = "",$redirect ="Yes"){

	$CI = &get_instance();
	$CI->load->model('Group_model');
    // return true;
	$acces = $CI->Group_model->check_group_access($page_url,$type);
	if(!$acces && $redirect == "Yes"){
		$previous_page = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : 'No previous page';
		$forbidden_page = base_url('forbidden_page');
		$CI->session->set_userdata('previous_page', $previous_page);
		header("Location: $forbidden_page");
		die();
	}
	return $acces;
}
function numberToWords(float $number)
    {
        $ones = array(
            0 => '', 1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four', 5 => 'Five', 6 => 'Six', 7 => 'Seven', 8 => 'Eight', 9 => 'Nine',
            10 => 'Ten', 11 => 'Eleven', 12 => 'Twelve', 13 => 'Thirteen', 14 => 'Fourteen', 15 => 'Fifteen', 16 => 'Sixteen', 17 => 'Seventeen',
            18 => 'Eighteen', 19 => 'Nineteen',
        );
        $tens = array(
            0 => 'Twenty', 1 => 'Thirty', 2 => 'Forty', 3 => 'Fifty', 4 => 'Sixty', 5 => 'Seventy', 6 => 'Eighty', 7 => 'Ninety',
        );

        $number = number_format($number, 2, '.', '');
        $parts = explode('.', $number);
        $wholeNumber = (int) $parts[0];
        $fraction = isset($parts[1]) ? (int) $parts[1] : 0;

        $wholeNumberInWords = '';
        if ($wholeNumber >= 10000000) {
            $wholeNumberInWords .= numberToWords(floor($wholeNumber / 10000000)) . ' Crore ';
            $wholeNumber %= 10000000;
        }
        if ($wholeNumber >= 100000) {
            $wholeNumberInWords .= numberToWords(floor($wholeNumber / 100000)) . ' Lakh ';
            $wholeNumber %= 100000;
        }
        if ($wholeNumber >= 1000) {
            $wholeNumberInWords .= numberToWords(floor($wholeNumber / 1000)) . ' Thousand ';
            $wholeNumber %= 1000;
        }
        if ($wholeNumber >= 100) {
            $wholeNumberInWords .= numberToWords(floor($wholeNumber / 100)) . ' Hundred ';
            $wholeNumber %= 100;
        }
        if ($wholeNumber >= 20) {
            $wholeNumberInWords .= $tens[floor($wholeNumber / 10) - 2] . ' ';
            $wholeNumber %= 10;
        }
        if ($wholeNumber > 0) {
            $wholeNumberInWords .= $ones[$wholeNumber];
        }

        $fractionInWords = '';
        if ($fraction > 0) {
            $fractionInWords = ' Rupees ';
            if ($fraction >= 20) {
                $fractionInWords .= $tens[floor($fraction / 10) - 2] . ' ';
                $fraction %= 10;
            }
            if ($fraction > 0) {
                $fractionInWords .= $ones[$fraction];
            }
            $fractionInWords .= ' Paise';
        }

        return $wholeNumberInWords . $fractionInWords;
    }
function NoDataFoundMessage($module_name =""){
    $module_message = [
        "user" => "user"
    ];

    $message = $module_message[$module_name];

    $html = '<div class="p-3 no-data-found-block">
                <img class="p-2" src="http://localhost/extra_work/HRMS/public/assets/images/images/no_data_found_new.png" height="150" width="150">
                <br> No '.$message.' data found..!
            </div>';

    return $html;
}

function createFolder($folderPath = ""){
    if (!is_dir($folderPath) && $folderPath != "") {
        mkdir($folderPath, 0777, true);
    }
}

function sent_email($data = array(), $email = "") {
    error_reporting(0);
    ini_set('display_errors', 0);

    $CI = &get_instance(); // Get the CI instance
    
    $mail = $CI->phpmailer_lib->load(); // Load PHPMailer
    $mail->isSMTP();                                      
    $mail->Host = 'smtp.gmail.com';                      
    $mail->SMTPAuth = true;     
    // $mail->SMTPDebug = 2; 
    $mail->SMTPDebug = 0; // Disable debugging output

    $mail->Username = "mullaaarbaj10@gmail.com";  // Corrected email (removed "mailto:")
    $mail->Password = "qnow eyjy mbrr yykp"; 
    $mail->SMTPSecure = 'tls';                            
    $mail->Port = 587;    
    $mail->From = "mullaaarbaj10@gmail.com";  // Removed "mailto:"
    $mail->FromName = "Data Collection ERP System";
    $mail->addAddress($email);
    $mail->isHTML(true);
    $mail->Subject = $data['subject'];
    
    $html = $data['msg'];
    $mail->Body = $html;
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    if (!$mail->send()) {
        echo 'Mailer Error: ' . $mail->ErrorInfo;
    } else {
        return true;
    }
}


function sent_otp($otp = "",$mobile_number=""){
        // Endpoint URL
        $url = "http://msg.msgclub.net/rest/services/sendSMS/sendGroupSms";
        $api_key = "NN3W33MCOH2YNAG3CC6J1RF5NZINU3G1";
        
      
        $url = "http://msg.msgclub.net/rest/services/sendSMS/sendGroupSms?AUTH_KEY=a9351d889897dee&message=" . urlencode("Dear user, $otp is your OTP to login to our system. Do not share this with anyone. BHARAT ID SOFTWARE SOLUTION") . "&senderId=BHARID&routeId=1&mobileNos=$mobile_number&smsContentType=english";

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $response = curl_exec($ch);
        // Check for errors
        if(curl_errno($ch)) {
            echo 'Error while doing digital signature : ' . curl_error($ch);
            exit();
        }
    
        // Close cURL session
        curl_close($ch);
        // exit();
    }




?>