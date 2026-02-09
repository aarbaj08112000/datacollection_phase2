<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once FCPATH.'/vendor/autoload.php';
use Dompdf\Dompdf;
class Form extends MY_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('Form_model');
        require_once(APPPATH.'libraries/tcpdf/tcpdf.php');
    }
    
    

    public function form_creation()
    {
        $data = [];
        $data['field_data'] = $this->Form_model->getFieldData();
        $data['channel_patner'] = $this->Form_model->getChannelPatnerList();
        // pr($data,1);
        $this->smarty->loadView('form.tpl', $data,'Yes','Yes');
    }
    public function form_creation_edit()
    {
        $school_id = $this->uri->segment(2);
        $data = [];
        $data['school_data'] = $this->Form_model->getSchoolFormCollectionDetail($school_id);
        $form_selected_feild = json_decode($data['school_data']['from_field'],TRUE);
        $form_selected_feild_arr = [];
        foreach ($form_selected_feild as $key => $value) {
            $feild = json_decode($value['field_data'],TRUE);
            $form_selected_feild_arr[$feild['form_field_master_id']] = $value['required'];
        }
       
        $data['form_selected_feild'] =$field_data= $form_selected_feild_arr;
        $data['field_data'] =  $this->Form_model->getFieldData();
        $data['channel_patner'] = $this->Form_model->getChannelPatnerList();
        $indexing_field = [];
        
        $priority_ids = array_keys($form_selected_feild_arr);
        $priority_fields = [];
        $other_fields = [];
        // Create a lookup for fast access by ID
        $field_map = [];
        foreach ($data['field_data'] as $field) {
            $field_map[$field['form_field_master_id']] = $field;
        }

        // Add priority fields in the exact order of $priority_ids
        $sequence = 1;
        foreach ($priority_ids as $id) {
            if (isset($field_map[$id])) {
                $field = $field_map[$id];
                $field['sequence'] = $sequence++;
                $priority_fields[] = $field;
                unset($field_map[$id]); // Remove from map so we don’t include it again
            }
        }

        // Remaining fields (non-priority) go after, with sequence = null
        foreach ($field_map as $field) {
            $field['sequence'] = null;
            $other_fields[] = $field;
        }

        // Final reordered array
        $final_fields = array_merge($priority_fields, $other_fields);

        $data['field_data'] = $final_fields;
        $index = 0;
        foreach ($field_data as $key => $value) {
            $indexing_field[$key] = $index;
            $index++;
        }
        $data['indexing_field'] = $indexing_field;
        $this->smarty->loadView('form_edit.tpl', $data,'Yes','Yes');
    }

    public function formListing()
    {
        $current_route = $this->uri->segment(1);
        checkGroupAccess($current_route,"list","Yes");
        $column[] = [
            "data" => "image",
            "title" => "Image",
            "width" => "5%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "name",
            "title" => "Name",
            "width" => "10%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "url",
            "title" => "Url",
            "width" => "10%",
            "className" => "dt-left",
            
        ];
        
        $column[] = [
            "data" => "contact_person",
            "title" => "Contact Person",
            "width" => "5%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "mobile_number",
            "title" => "Mobile Number",
            "width" => "5%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "channel_patner",
            "title" => "Channel Patner",
            "width" => "5%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "address",
            "title" => "Address",
            "width" => "5%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "comment",
            "title" => "Comment",
            "width" => "5%",
            "className" => "dt-left",
            "visible" => false
        ];
        $column[] = [
            "data" => "total_record",
            "title" => "Total Data Collection",
            "width" => "5%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "status",
            "title" => "Status",
            "width" => "5%",
            "className" => "status dt-center",
        ];
        $column[] = [
            "data" => "action",
            "title" => "Action",
            "width" => "7%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "url",
            "title" => "Url",
            "width" => "10%",
            "className" => "dt-left",
            "visible" => false
        ];
        $column[] = [
            "data" => "form_type",
            "title" => "Type",
            "width" => "10%",
            "className" => "dt-left",
            "visible" => false
        ];
        $column[] = [
            "data" => "designation",
            "title" => "Designation",
            "width" => "10%",
            "className" => "dt-left",
            "visible" => false
        ];
        $column[] = [
            "data" => "course",
            "title" => "Course",
            "width" => "10%",
            "className" => "dt-left",
            "visible" => false
        ];
        $column[] = [
            "data" => "section",
            "title" => "Section",
            "width" => "10%",
            "className" => "dt-left",
            "visible" => false
        ];
        $column[] = [
            "data" => "house",
            "title" => "<H></H>ouse",
            "width" => "10%",
            "className" => "dt-left",
            "visible" => false
        ];

        $column[] = [
            "data" => "course",
            "title" => "Course",
            "width" => "10%",
            "className" => "dt-left",
            "visible" => false
        ];
        $column[] = [
            "data" => "course",
            "title" => "Course",
            "width" => "10%",
            "className" => "dt-left",
            "visible" => false
        ];
        
        $data["data"] = $column;
        $data["is_searching_enable"] = true;
        $data["is_paging_enable"] = true;
        $data["is_serverSide"] = true;
        $data["is_ordering"] = true;
        $data["is_heading_color"] = "#a18f72";
        $data["no_data_message"] =
            '<div class="p-3 no-data-found-block"><img class="p-2" src="' .
            base_url() .
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Employee data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[11, 'desc']]);
        $data["page_length_arr"] = [[10,100,500,1000,2000,2500,3000,-1], [10,100,500,1000,2000,2500,3000,'All']];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        $data["is_deleted"] = $current_route == "trash_form_listing" ? 1 : 0;
        $this->smarty->loadView('form_listing.tpl', $data,'Yes','Yes');
    }

    public function formListingData(){
        $post_data = $this->input->post();
        
        $column_index = array_column($post_data["columns"], "data");
        $order_by = "";
        foreach ($post_data["order"] as $key => $val) {
            if ($key == 0) {
                $order_by .= $column_index[$val["column"]] . " " . $val["dir"];
            } else {
                $order_by .=
                    "," . $column_index[$val["column"]] . " " . $val["dir"];
            }
        }
        $condition_arr["order_by"] = $order_by;
        $condition_arr["start"] = $post_data["start"];
        $condition_arr["length"] = $post_data["length"];
        $base_url = $this->config->item("base_url");
        $is_deleted = $post_data['data']['is_deleted'];
        $data = $this->Form_model->getSchoolData($condition_arr,$post_data["search"],$is_deleted);
        foreach ($data as $key => $val) {
            $data[$key]['image'] = "<img src='".base_url($val['image'])."' alt='' width='75' height='75' title='College Logo'>";
            $data[$key]['url'] ='<a href="' . base_url("form/" . base64_encode($val['url'])) . '" target="_blank">' . base_url("form/" . base64_encode($val['url'])) . '</a>';
            $data[$key]['channel_patner'] = display_no_character($val['channel_patner']);
            $data[$key]['address'] = display_no_character($val['address']);
            $data[$key]['comment'] = display_no_character($val['comment']);
            $edit_url = base_url("/form_creation_edit/".$val['school_id']);
            $data[$key]['action'] = "";
            if(checkGroupAccess("data_collection_list","list","No") && $is_deleted == 0){
                $data[$key]['action'] .= '
                 <span title="View">
                    <a href="'.base_url().'data_collection_list/'.$val['school_id'].'" >
                        <i class="ti ti-eye"></i>
                    </a>
                </span>';
                $data[$key]['action'] .= '
                 <span title="Edit Image">
                    <a href="'.base_url().'data_collection_image_list/'.$val['school_id'].'" >
                        <i class="ti ti-photo-up"></i>
                    </a>
                </span>';
            }
            if($is_deleted == 0){
            $data[$key]['action'] .= '
               <span class="copy-text">
                      <i class="ti ti-copy copy-url" title="Copy" data-url="'.base_url("/form/".base64_encode($val['url'])).'"></i>
                </span>
            ';
            }
            if(checkGroupAccess("form_listing","update","No")){
                if($is_deleted == 0){
                $data[$key]['action'] .= '
                <a class="" title="Edit" href="'.$edit_url.'">
                    <i class="ti ti-edit"></i>
                    </a>';
                }
                if($is_deleted == 0){
                    $data[$key]['action'] .='<span class="recycle-school" title="Rescycle Bin" data-id="'.$val['school_id'].'">
                    <i class="ti ti-trash"></i>
                    </span>';
                }else{
                    $data[$key]['action'] .='<span class="delete-school" title="Delete" data-id="'.$val['school_id'].'">
                        <i class="ti ti-trash"></i>
                    </span><span class="restore-school" title="Restore" data-id="'.$val['school_id'].'">
                        <i class="ti ti-refresh"></i>
                    </span>';
                }

                if($is_deleted == 0){
                    $data[$key]['action'] .= '
                <span class="status-school" title="Change Status" data-status="'.$val['status'].'" data-id="'.$val['school_id'].'">
                    <i class="ti ti-clock"></i>
                </span>
                    <span class="upload-school-data" title="Import Data"  data-id="'.$val['school_id'].'">
                        <i class="ti ti-upload"></i>
                    </span>
                    <a href="idcard/designer/' . $val['school_id'] . '" title="Change template">
                        <span class="" data-id="' . $val['school_id'] . '">
                            <i class="ti ti-template"></i>
                        </span>
                            </a>
            ';
            }
        }
        }
        
        
        $data["data"] = $data;
        // pr($data,1);
        $total_record = $this->Form_model->getSchoolDataCount([], $post_data["search"],$is_deleted);
        $data["recordsTotal"] = $total_record['total_record'];
        $data["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($data);
        exit();
    }
    public function recycle_school(){
        $post_data = $this->input->post();
        $update_data = ["is_delete"=>1];
        $this->Form_model->updateSchoolData($update_data,$post_data['school_id']);
        $ret_arr['messages'] = "Record add in recycle bin successfully.";
        $ret_arr['success'] = 1;
        echo json_encode($ret_arr);
        exit();
    }
    public function restore_school(){
        $post_data = $this->input->post();
        $update_data = ["is_delete"=>0];
        $this->Form_model->updateSchoolData($update_data,$post_data['school_id']);
        $ret_arr['messages'] = "Record add in recycle bin successfully.";
        $ret_arr['success'] = 1;
        echo json_encode($ret_arr);
        exit();
    }
    public function delete_school(){
        $post_data = $this->input->post();
        $this->Form_model->deleteSchoolData($post_data['school_id']);
        $ret_arr['messages'] = "Record deleted successfully.";
        $ret_arr['success'] = 1;
        echo json_encode($ret_arr);
        exit();
    }
    public function change_status(){
        $post_data = $this->input->post();
        $update_data = ["status"=>$post_data['status']];
        $this->Form_model->updateSchoolData($update_data,$post_data['school_id']);
        $ret_arr['messages'] = "Status updated successfully.";
        $ret_arr['success'] = 1;
        echo json_encode($ret_arr);
        exit();
    }
    
    public function dataCollectionList()
    {
        $school_id = $this->uri->segment(2);
        $page_name = $this->uri->segment(1);
        if($this->session->userdata("role") == "ChannelPartner"){
            $channel_patner_id = $this->session->userdata("user_id");
            $form_data = $this->Form_model->checkChannelPatnerAccessFormData($channel_patner_id,$school_id);
            if(!(count($form_data) > 0)){
                $previous_page = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : 'No previous page';
                $forbidden_page = base_url('forbidden_page');
                header("Location: $forbidden_page");
                die();
            }
        }
        checkGroupAccess("data_collection_list","list","Yes");
        $form_data = $this->Form_model->getFormJsonData($school_id);
        $folderPath = "public/uploads/data_collection_img/" . $form_data['url'];
        $images_available = is_dir($folderPath) ? "Yes" : "No";
        // pr($form_data,1);
        $from_field = json_decode($form_data['from_field'],TRUE);
        $from_field = array_column($from_field, "field_data");
        $column = [];
        $file_column_exist = false;
        $data_for_image_edit = [];
        if($page_name == "data_collection_image_list"){
            $data_for_image_edit = ["student_name","father_name","image","section","class"];
        }
        
        foreach ($from_field as $key => $value) {
            $value = json_decode($value,TRUE);
            $position = "dt-left";
            $width = "10%";
            $hide_search_class = "";
            if($value['form_type'] == "file"){
                $position = "dt-center";
                $width = "8%";
                $file_column_exist = true;
                $hide_search_class = "hide_search";
            }
            if(in_array($value['form_name'],$data_for_image_edit) || count($data_for_image_edit) == 0){
            $column[] = [
                "name" => $value['form_name'],
                "data" => preg_replace('/[^a-zA-Z0-9\s@#!]/', '', $value['form_name']),
                "title" => $value['form_title'],
                "width" => $width,
                    "className" => "search ".$position." ".$hide_search_class,
                "formType" => $value['form_type'],
                "field_type" => $value['field_type']
            ];
        }
        
       
        }
        
        
        usort($column, function($a, $b) {
            // Put "file" formType first
            if ($a['formType'] === 'file' && $b['formType'] !== 'file') {
                return -1;
            }
            if ($a['formType'] !== 'file' && $b['formType'] === 'file') {
                return 1;
            }
            return 0; // Otherwise, leave the order unchanged
        });
        if(($this->session->userdata("role") == "Admin" || $this->session->userdata("role") == "SuperAdmin") && $page_name == "data_collection_list"){
            $column[] = [
                "name" => "card_generated",
                "data" => "card_generated",
                "title" => "Card Generated",
                "width" => "15%",
                "className" => "search dt-center"
            ];
        }
        if($file_column_exist || true){
            $column[] = [
                "data" => "action",
                "title" => "Action",
                "width" => "15%",
                "className" => "status dt-center"
            ];
            
        }
        
       
        array_unshift($column,[
               "name" => "sr_no",
                "data" => "sr_no",
                "title" => "Sr. No.",
                "width" => "5%",
                "className" => "search dt-center"
            ]);
        
        array_unshift($column,[
                "data" => "check_box",
                "title" => ' <input class="form-check-input check-all-input" type="checkbox" value="">',
                "width" => "1%",
                "className" => " dt-center checkbox-row",
                "visible" => $page_name == "data_collection_image_list" ? false : true
            ]);
        $data['images_available'] = $images_available;
        $data["data"] = $column;
        $data["is_searching_enable"] = true;
        $data["is_paging_enable"] = true;
        $data["is_serverSide"] = true;
        $data["is_ordering"] = false;
        $data["is_heading_color"] = "#a18f72";
        $data["no_data_message"] =
            '<div class="p-3 no-data-found-block"><img class="p-2" src="' .
            base_url() .
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Employee data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[11, 'desc']]);
        $data["page_length_arr"] = [[50,100,500,1000,2000,2500,3000,-1], [50,100,500,1000,2000,2500,3000,'All']];
        $data["school_id"] = $school_id;
        $data["base_url"] = base_url();
        $data['file_column_exist'] = $file_column_exist;
        $data['url'] = $form_data['url'].date("_d-m-Y_H-i");
        $data['page_name'] = $page_name;
        $data['school_name'] = $form_data['name'];
        $this->smarty->loadView('data_collection_list.tpl', $data,'Yes','Yes');
    }

    public function form_data_listing(){
        $post_data = $this->input->post();
        $row_search = [];
        foreach ($post_data['columns'] as $key => $value) {
            if($value['search']['value'] != "" && $value['search']['value'] !=  null){
                $row_search[] = [
                    "key" => $value['name'],
                    "val" => $value['search']['value']
                ];
            }
        }
        $column_details = $post_data['data']['column_details'];
        $school_id = $post_data['data']['school_id'];
        $column_index = array_column($post_data["columns"], "data");
        $order_by = "";
        foreach ($post_data["order"] as $key => $val) {
            if ($key == 0) {
                $order_by .= $column_index[$val["column"]] . " " . $val["dir"];
            } else {
                $order_by .=
                    "," . $column_index[$val["column"]] . " " . $val["dir"];
            }
        }
        $condition_arr["order_by"] = $order_by;
        $condition_arr["start"] = $post_data["start"];
        $condition_arr["length"] = $post_data["length"];
        $base_url = $this->config->item("base_url");
        $form_data = $this->Form_model->getFormDetails($condition_arr,$post_data["search"],$school_id,$row_search);
        $role = $this->session->userdata('role');
        $data = [];
        foreach ($form_data as $key => $value) {
            
            $form_data = json_decode($value['form_data'],TRUE);
            $row_value = [];
            $file_column_exist = false;
            foreach ($column_details as $ke => $val) {
                $extra_style = $post_data['data']['page_name'] == "data_collection_image_list" ? 'style="font-size: 32px !important;"' : ""; 
                if($val['data'] == "sr_no"){
                    $row_value[$val['data']] = display_no_character($value[$val['data']]);
                }else if($val['data'] == "check_box"){
                    $row_value[$val['data']] = ' <input class="form-check-input check-row-input" type="checkbox" value="'.$value['form_data_collection_id'].'">';
                }else if($val['formType'] == "file"){
                    $file_column_exist = true;
                    $form_data[$val['data']] = $form_data[$val['name']] != "" ? $form_data[$val['name']] : base_url("public/assets/images/no-pictures.png");
                    $file_name = str_replace("public/uploads/data_collection_img/","",$form_data[$val['name']]);
                    $file_name = str_replace($value['url']."/","",$file_name);
                    $file_name = explode("/",$file_name);
                    $file_name = $file_name[1] != "" ? $file_name[1] : "";
                    $file_name_only = $form_data[$val['name']]; // abc.jpg
                    if (strpos($form_data[$val['name']], '.jpg') !== false) {
                        $row_value[$val['data']] = '
                            <i class="ti ti-eye image-preview" title="View Images" '.$extra_style.' data-src="'.base_url($form_data[$val['name']]).'"></i>
                            <span class="image-info" data-image="'.$file_name_only.'" style="display:none;">'.$file_name_only.'</span>';
                    }else{
                        $row_value[$val['data']] = display_no_character();
                    }
                    // $row_value[$val['data']] = "<img src='".base_url($form_data[$val['name']])."' alt='' width='75' height='75' title='' data-image='".$file_name."'>" ;
                }else if($val['field_type'] == "Date"){
                    $row_value[$val['data']] = $form_data[$val['name']] != "" ? defaultDateFormat($form_data[$val['name']]) : display_no_character($form_data[$val['name']]);
                }else{
                    $row_value[$val['data']] = display_no_character($form_data[$val['name']]);
                }
                if($val['data'] == "action"){
                    $row_value[$val['data']] = "";
                    // pr($post_data,1);.select2-container
                    if($post_data['data']['page_name'] == "data_collection_list"){
                    if($file_column_exist && !in_array($role,['Employee'])){
                        $row_value[$val['data']] = '<a class="me-2" href="'.base_url('download_images/').$value['form_data_collection_id'].'"><i class="ti ti-photo-down" title="Download Images"></i>';   
                    }
                    if(!in_array($role,['Employee','ChannelPartner'])){
                        $row_value[$val['data']] .= '<a class="me-2" href="'.base_url('download_all_ids/').$value['school_master_id']."/".$value['form_data_collection_id'].'"><i class="ti ti-id-badge-2" title="Download Ids"></i>';
                    }
                    $row_value[$val['data']] .= '<a class="me-2 preview-id" href="javascript:void(0)" data-href="'.base_url('preview_id_card/').$value['school_master_id']."/".$value['form_data_collection_id'].'"><i class="ti ti-eye" title="Preview Id"></i>';
                        if(in_array($role,['Employee','ChannelPartner',"SuperAdmin","Admin"])){
                        $row_value[$val['data']] .= '<a class="me-2 edit-from-data" href="javascript:void(0)" data-collection-id="'.$value['form_data_collection_id'].'"><i class="ti ti-edit" title="Edit"></i>';
                    }
                    }else{
                         $row_value[$val['data']] .= '<a  class="me-2 edit-image-data" href="javascript:void(0)" data-collection-id="'.$value['form_data_collection_id'].'"><i '.$extra_style.' class="ti ti-photo-up" title="Edit"></i>';
                    }
                }
                $row_value['card_generated'] = $value['card_generated'];
                

                
            }
            $data[] = $row_value;
            # code...
        }

        $data["data"] = $data;
        
        $total_record = $this->Form_model->getFormDetails([], $post_data["search"],$school_id,$row_search);
        $data["recordsTotal"] = count($total_record);
        $data["recordsFiltered"] = count($total_record);
        echo json_encode($data);
        exit();
    }

    public function download_images(){
        $from_data_collection_id = $this->uri->segment(2);
        $from_data_collection_data = $this->Form_model->getFormCollectionData($from_data_collection_id);
        $form_details = json_decode($from_data_collection_data['form_data'],TRUE);
        $form_data = $this->Form_model->getFormJsonData($from_data_collection_data['school_master_id']);
        $from_field = json_decode($form_data['from_field'],TRUE);
        $from_field = array_column($from_field, "field_data");
        $column = [];
        $file_column_exist = false;
        $images = [];
        foreach ($from_field as $key => $value) {
            $value = json_decode($value,TRUE);
            if($value['form_type'] == "file"){
                if($form_details[$value['form_name']] != ""){
                    $images[] = $form_details[$value['form_name']];
                }
            }
        }
        $this->load->helper('url');
        $this->load->helper('file');

        // Create a temporary directory to store the images
        $temp_dir = FCPATH . 'public/temp_images/';

        // Check if the directory exists, if not, create it
        if (!is_dir($temp_dir)) {
            mkdir($temp_dir, 0755, TRUE);
        }

        // Define the ZIP file name
        $zipFile = $temp_dir . "images_".$form_data['url'].date("_d-m-Y_H-i").".zip";
        error_log("ZIP path: " . $zipFile);

        // Create a new ZIP archive
        $zip = new ZipArchive();
        if ($zip->open($zipFile, ZipArchive::CREATE | ZipArchive::OVERWRITE) !== TRUE) {
            die("Could not create ZIP file");
        }

        // Download and add files to ZIP
        foreach ($images as $index => $fileUrl) {
            $fileContents = @file_get_contents($fileUrl);
            if ($fileContents !== false) {
                $fileName = basename($fileUrl);
                $zip->addFromString($fileName, $fileContents);
            } else {
                error_log("Failed to download: $fileUrl");
            }
        }

        // Close the ZIP archive
        $zip->close();

        // Ensure the ZIP file was created
        if (file_exists($zipFile)) {
            // Set headers to force download
            header('Content-Type: application/zip');
            header('Content-Disposition: attachment; filename="' . basename($zipFile) . '"');
            header('Content-Length: ' . filesize($zipFile));

            ob_clean();
            flush();
            readfile($zipFile);

            // Delete the ZIP file after download
            unlink($zipFile);
        } else {
            die("ZIP file not found: $zipFile");
        }


    }
    public function download_all_images(){
        $school_id = $this->uri->segment(2);
        $get_data = $this->input->get();
        $selected_ids = isset($get_data['selected_ids']) ? base64_decode($get_data['selected_ids']) : "";
        $from_data_collection_data = $this->Form_model->getSchoolFormCollectionData($school_id,0,$selected_ids);
        $form_data = $this->Form_model->getFormJsonData($school_id);
        $from_field = json_decode($form_data['from_field'],TRUE);
        $from_field = array_column($from_field, "field_data");
        $images_arr = [];
        foreach ($from_data_collection_data as $ke => $val) {
            $form_details = json_decode($val['form_data'],TRUE);
            $images = [];
            foreach ($from_field as $key => $value) {
                $value = json_decode($value,TRUE);
                if($value['form_type'] == "file"){
                    if($form_details[$value['form_name']] != ""){
                        $images[] = $form_details[$value['form_name']];
                    }
                }
            }
            $images_arr[$val['sr_no']] = $images;
        }


        
        $this->load->helper('url');
        $this->load->helper('file');

        // Create a temporary directory to store the images
        $temp_dir = FCPATH . 'public/temp_images/';

        // Check if the directory exists, if not, create it
        if (!is_dir($temp_dir)) {
            mkdir($temp_dir, 0755, TRUE);
        }

        // Define the ZIP file name
        $zipFile = $temp_dir . "all_images".$form_data['url'].date("_d-m-Y_H-i").".zip";

        // Create a new ZIP archive
        $zip = new ZipArchive();
        if ($zip->open($zipFile, ZipArchive::CREATE | ZipArchive::OVERWRITE) !== TRUE) {
            die("Could not create ZIP file");
        }

        foreach ($images_arr as $key => $value) {
            $folderName = $key . "/";
            $zip->addEmptyDir($folderName);
            
            // Download and add files to ZIP
            foreach ($value as $index => $fileUrl) {
                $fileContents = @file_get_contents($fileUrl); // Suppress errors
                if ($fileContents !== false) {
                    $fileName = basename($fileUrl);
                    $zip->addFromString($folderName . $fileName, $fileContents);
                } else {
                    error_log("Failed to download: $fileUrl");
                }
            }
        }

        // Close the ZIP archive
        $zip->close();

        // Ensure the ZIP file exists
        if (file_exists($zipFile)) {
            // Set headers to force download
            header('Content-Type: application/zip');
            header('Content-Disposition: attachment; filename="all_images_'.$form_data['url'].date("_d-m-Y_H-i").'.zip"');
            header('Content-Length: ' . filesize($zipFile));
            
            ob_clean();
            flush();
            readfile($zipFile);

            // Delete the ZIP file after download
            unlink($zipFile);
        } else {
            die("ZIP file not found or creation failed.");
        }


    }
    
    public function url()
    {
        
        $fields = [
            'name',
            'father_name',
            'mother_name',
            'gender',
            'date_of_birth'
        ];
        
        $data['form_fields'] = $fields;
        // pr("ok");
        $this->smarty->loadView('url_info_form.tpl', $data,'No','No');
    }
    

    public function generateFromData()
    {

        $post_data = $this->input->post();
        
        $school_master_data = $this->Form_model->checkDublicateUrl($post_data['url']);
        $school_master_data = is_valid_array($school_master_data) ? $school_master_data : [];
        if(count($school_master_data) == 0){
            $course_value = $post_data['course'];
            $section_value = $post_data['section'];
            $house_value = $post_data['house'];
            $form_fileds = json_decode($post_data['form_fileds'],TRUE);
            $fields = $this->Form_model->getFieldData();
            $fields_id_wise = [];
            foreach ($fields as $key => $value) {
                $fields_id_wise[$value['form_field_master_id']] = $value;
            }
            $form_field_data = [];
            foreach ($form_fileds as $key => $value) {
                if($fields_id_wise[$value['field_id']]['form_name'] == "course" || $fields_id_wise[$value['field_id']]['form_name'] == "class"){
                    $fields_id_wise[$value['field_id']]['form_value'] = $course_value;
                }else if($fields_id_wise[$value['field_id']]['form_name'] == "section"){
                    $fields_id_wise[$value['field_id']]['form_value'] = $section_value;
                }else if($fields_id_wise[$value['field_id']]['form_name'] == "house"){
                    $fields_id_wise[$value['field_id']]['form_value'] = $house_value;
                }

                $row = [
                    "required" => $value['requied'],
                    "field_data" => json_encode($fields_id_wise[$value['field_id']],TRUE)
                ];
                array_push($form_field_data, $row);
            }

            /* collage logo */
            $profileImageData = $_FILES["image"]["name"] != "" ? $_FILES["image"] : [];
            $config["upload_path"] = "public/uploads/school_image/";
            $config["allowed_types"] = "jpg|jpeg|png|bmp|heic"; 
            $this->load->library("upload", $config);
            $this->upload->initialize($config);
            $upload_error_msg = [];
            $school_image = "";
            if (!empty($profileImageData)) {
                if (!$this->upload->do_upload("image")) {
                    $upload_error_msg = $error = [
                        "error" => $this->upload->display_errors(),
                    ];
                    $upload_error = 1;
                } else {
                    $upload_data = $this->upload->data();
                    $school_image = "public/uploads/school_image/".$upload_data['file_name'];
                }
            }

            /* template image */
            $profileImageData = $_FILES["template"]["name"] != "" ? $_FILES["template"] : [];
            $config["upload_path"] = "public/uploads/form_template_img/";
            createFolder($config["upload_path"]);
            $config["allowed_types"] = "jpg|png|jpeg|bmp|heic";
            $this->load->library("upload", $config);
            $this->upload->initialize($config);
            $template_error_msg = [];
            $template_image = [];
            
            if (!empty($profileImageData)) {
                if (!$this->upload->do_upload("template")) {
                    $template_error_msg = $error = [
                        "error" => $this->upload->display_errors(),
                    ];
                    $template_error = 1;
                } else {
                    $template_data = $this->upload->data();
                    $template_image = "public/uploads/form_template_img/".$template_data['file_name'];
                }
            }

            $ret_arr = [];
            $msg ='Something went wrong';
            $success = 0;
            if (count($upload_error_msg) > 0 || count($template_error_msg) > 0) {
                $msg = count($upload_error_msg) > 0
                    ? $upload_error_msg[error]
                    : $template_error_msg[error];
                $msg .= "Only jpg,jpeg,png,bmp,heic file type allowed";
            } else {
                $data = array(
                        'name' => $this->input->post('name'),
                        'image' => $school_image,
                        'url' => $this->input->post('url'),
                        'form_type' => $this->input->post('form_heder_type'),
                        "contact_person" => $post_data['contact_person'],
                        "mobile_number" => $post_data['mobile_number'],
                        "designation" => $post_data['designation'],
                        "display_template" => $template_image,
                        "course" => $post_data['course'],
                        "section" => $post_data['section'],
                        "house" => $post_data['house'],
                        'from_field' => json_encode($form_field_data,TRUE),
                        'added_date' => date("Y-m-d H:i:s"),
                        'added_by' => $this->session->userdata('user_id'),
                        "channel_patner_id" => $post_data['channel_patner_id'],
                        "address" => $post_data['address'],
                        "comment" => $post_data['comment']
                );
                // pr($data,1);
                $inser_query = $this->Form_model->insertSchoolData($data);
                if ($inser_query) {
                    if ($inser_query) {
                        $success = 1;
                        $msg = 'School date added successfully.';
                    }
                }
            }
        }else{
            $success = 0;
            $msg = 'URL must be unique.';
        }
        $ret_arr['redirect_url'] = base_url("form_listing");
        $ret_arr['messages'] = $msg;
        $ret_arr['success'] = $success;
        echo json_encode($ret_arr);
    }

    public function updateFromData()
    {

        $post_data = $this->input->post();
        // pr($post_data,1);
        $course_value = $post_data['course'];
            $section_value = $post_data['section'];
            $house_value = $post_data['house'];
            $form_fileds = json_decode($post_data['form_fileds'],TRUE);
            $fields = $this->Form_model->getFieldData();
            $fields_id_wise = [];
            foreach ($fields as $key => $value) {
                $fields_id_wise[$value['form_field_master_id']] = $value;
            }
            $form_field_data = [];
            foreach ($form_fileds as $key => $value) {
                if($fields_id_wise[$value['field_id']]['form_name'] == "course" || $fields_id_wise[$value['field_id']]['form_name'] == "class"){
                    $fields_id_wise[$value['field_id']]['form_value'] = $course_value;
                }else if($fields_id_wise[$value['field_id']]['form_name'] == "section"){
                    $fields_id_wise[$value['field_id']]['form_value'] = $section_value;
                }else if($fields_id_wise[$value['field_id']]['form_name'] == "house"){
                    $fields_id_wise[$value['field_id']]['form_value'] = $house_value;
                }

                $row = [
                    "required" => $value['requied'],
                    "field_data" => json_encode($fields_id_wise[$value['field_id']],TRUE)
                ];
                array_push($form_field_data, $row);
            }

            /* collage logo */
            $profileImageData = $_FILES["image"]["name"] != "" ? $_FILES["image"] : [];
            $config["upload_path"]   = "public/uploads/school_image/";
            $config["allowed_types"]  = "jpg|jpeg|png|bmp|heic";
            // $config["max_size"]       = 2048;  
            // $config["encrypt_name"]   = TRUE;

            $this->load->library("upload", $config);  
            $this->upload->initialize($config);
            $upload_error_msg = [];
            $school_image = "";

            if (!empty($profileImageData)) {
                if (!$this->upload->do_upload("image")) {
                    $upload_error_msg = $error = [
                        "error" => $this->upload->display_errors(),
                    ];
                    $upload_error = 1;
                } else {
                    $upload_data = $this->upload->data();
                    $school_image = "public/uploads/school_image/".$upload_data['file_name'];
                   
                }
            }else{
                $school_image = $post_data['image_old'];
            }
           
            /* template image */
            $profileImageData = $_FILES["template"]["name"] != "" ? $_FILES["template"] : [];
            $config["upload_path"] = "public/uploads/form_template_img/";
            createFolder($config["upload_path"]);
            $config["allowed_types"] = "jpg|jpeg|png|bmp|heic";
            $this->load->library("upload", $config);
            $this->upload->initialize($config);
            $template_error_msg = [];
            $template_image = [];
            
        if (!empty($profileImageData)) {
            if (!$this -> upload -> do_upload("template")) {
                $template_error_msg = $error = ["error" => $this -> upload -> display_errors()];
                $template_error = 1;
            } else {
                $template_data = $this -> upload -> data();
                $template_image = "public/uploads/form_template_img/".$template_data['file_name'];
            }
        } else {
            $template_image = $post_data['template_old'];
        }
        $ret_arr = [];
        $msg = 'Something went wrong';
        $success = 0;
        if (count($upload_error_msg) > 0 || count($template_error_msg) > 0) {
            $msg = count($upload_error_msg) > 0
                ? $upload_error_msg[error]
                : $template_error_msg[error];
            $msg .= "Only jpg,jpeg,png,bmp,heic file type allowed";
        } else {
            $data = array(
                'name' => $this -> input -> post('name'),
                'image' => $school_image,
                'url' => $this -> input -> post('url'),
                'form_type' => $this -> input -> post('form_heder_type'),
                "contact_person" => $post_data['contact_person'],
                "mobile_number" => $post_data['mobile_number'],
                "designation" => $post_data['designation'],
                "display_template" => $template_image,
                "course" => $post_data['course'],
                "section" => $post_data['section'],
                "house" => $post_data['house'],
                'from_field' => json_encode($form_field_data, TRUE),
                'added_date' => date("Y-m-d H:i:s"),
                'added_by' => $this -> session -> userdata('user_id'),
                'channel_patner_id' => $post_data['channel_patner_id'],
                'address' => $post_data['address'],
                'comment' => $post_data['comment']
            );
            $affected_row = $this -> Form_model -> updateSchoolData(
                $data,
                $post_data['school_id']
            );
            if ($affected_row > 0) {
                $success = 1;
                $msg = 'School date updated successfully.';
            }
        }
        $ret_arr['redirect_url'] = base_url("form_listing");
        $ret_arr['messages'] = $msg;
        $ret_arr['success'] = $success;
        echo json_encode($ret_arr);
    }
    
    /* daynamic form creation */
     public function form(){
        $page_url = $this->uri->segment(2);
        $page_url = base64_decode($page_url);
        $form_data = $this->Form_model->getFormJson($page_url);
        $data = [];
        if(is_valid_array($form_data) && $form_data['status'] == "Active" && $form_data['is_delete'] == 0){
            $form_fields = json_decode($form_data['from_field'],TRUE);
            foreach ($form_fields as $key => $value) {
                $fields = json_decode($value['field_data'],TRUE);
                if($fields['form_type'] == "radio" || $fields['form_type'] == "drop_down"){
                    $fields['form_value'] = explode(",", $fields['form_value']);
                }
                $form_fields[$key]['field_data'] = $fields;
            }
            $data = [];
            $data['form_fields'] = $form_fields;
            $data['form_data'] = $form_data;
            $this->smarty->loadView('url_info_form.tpl', $data,'No','No');
        }else{
            $data = [];
            $this->smarty->loadView('page_not_found.tpl', $data,'No','No');
        }
        
    }
    public function submit_form(){
        
        $post_data = $this->input->post();
        $form_data = $this->Form_model->getFormJson($post_data['from_url']);
        $form_fields = json_decode($form_data['from_field'],TRUE);
        $image_arr = [];
        
        $form_data_collection_count = $this->Form_model->getSchoolFormCollectionDataCount($post_data['matser_id']);
        $form_data_collection_count_val = $form_data_collection_count['count'] > 0 ? $form_data_collection_count['count']+1 : 1;
        // pr($form_data_collection_count,1);
        $folderPath = "public/uploads/data_collection_img/" . $post_data['from_url'];
        if (!is_dir($folderPath) && $folderPath != "") {
            mkdir($folderPath, 0777, true);
        }
        $upload_error_msg = [];
        foreach ($_FILES as $key => $value) {
            // Get the uploaded image
            $profileImageData = $_FILES[$key]["name"] != "" ? $_FILES[$key] : [];
            $fileName = $_FILES[$key]['name'];
            $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
            $_FILES[$key]["name"] = $post_data['from_url']."_".$form_data_collection_count_val.".".$fileExtension;
            $folderPath .= "/".$key;
            // Ensure the folder exists, if not, create it
            if (!is_dir($folderPath) && $folderPath != "") {
                mkdir($folderPath, 0777, true);
            }
            // Set upload configuration
            $config["upload_path"] = $folderPath;
            $config["allowed_types"] = "jpg|png|jpeg|bmp|heic";  // Allow jpg, png, and jpeg files
            $config['max_size'] = 10240;
            $this->load->library("upload", $config);
            $this->upload->initialize($config);
            if (!empty($profileImageData)) {
                
                if (!$this->upload->do_upload($key)) {
                    // If upload fails, store the error message
                    $error = $this->upload->display_errors('', '');
                    if (strpos($error, 'filetype') !== false) {
                        $custom_error = 'Only JPG, PNG, JPEG, BMP, and HEIC files are allowed.';
                    } elseif (strpos($error, 'The file you are attempting to upload is larger than the permitted size.') !== false) {
                        $custom_error = 'The file is too large. Maximum allowed size is 10 MB.';
                    } else {
                        $custom_error = $error; // fallback to default message
                    }
                    $upload_error_msg = $error = [
                        "error" => $custom_error,
                    ];
                    $upload_error = 1;
                    $image_arr[$key] = "";
                } else {
                    // Upload successful, get the uploaded file data
                    $upload_data = $this->upload->data();
                    $uploadedFilePath = $folderPath . "/" . $upload_data['file_name'];

                    // Convert image to JPG if it's PNG or JPEG
                    $fileType = strtolower(pathinfo($uploadedFilePath, PATHINFO_EXTENSION));
                    if ($fileType == 'png' || $fileType == 'jpeg') {
                        $newFilePath = $folderPath . "/" . pathinfo($upload_data['file_name'], PATHINFO_FILENAME) . '.jpg';

                        // Load the image depending on its type
                        if ($fileType == 'png') {
                            $image = imagecreatefrompng($uploadedFilePath);
                        } elseif ($fileType == 'jpeg') {
                            $image = imagecreatefromjpeg($uploadedFilePath);
                        }

                        // Save the image as JPG
                        imagejpeg($image, $newFilePath, 90); // Save with 90% quality
                        imagedestroy($image); // Free memory

                        // Delete the original uploaded PNG/JPEG file
                        unlink($uploadedFilePath);

                        // Update the image path to the new JPG
                        $image_arr[$key] = $newFilePath;
                    } else {
                        // If already JPG, just use the uploaded file
                        $image_arr[$key] = $uploadedFilePath;
                    }
                }
            }
        }
        
        $form_data_json = [];
        foreach ($form_fields as $key => $value) {
            $field_data = json_decode($value['field_data'],TRUE);
            if($field_data['form_type'] != "file"){
                $original_name = $field_data['form_name'];
                $field_data['form_name'] = str_replace('.', '_', $field_data['form_name']);
                $field_value = $post_data[$field_data['form_name']] != "" ? $post_data[$field_data['form_name']] : "";
                $field_value = $field_data['prefix'] != "" ? $field_data['prefix']." ".$field_value : $field_value;
                $form_data_json[$original_name] = $field_value;
            }else{
                $form_data_json[$field_data['form_name']] = $image_arr[$field_data['form_name']] != "" ? $image_arr[$field_data['form_name']] : "";
            }
        }
        $msg = "Something went wrong";
        $success = 0;
        if (count($upload_error_msg) > 0 ) {
            $msg = $upload_error_msg["error"];
            // $msg .= "Only jpg,jpeg,png,bmp,heic file type allowed";
        } else {
            $insert_data = [
                "school_master_id" => $post_data['matser_id'],
                "sr_no" => $form_data_collection_count_val,
                "form_data" => json_encode($form_data_json,TRUE),
                "added_date" => date("Y-m-d H:i:s")
            ];
            $inser_query = $this->Form_model->insertFormData($insert_data);
            if ($inser_query) {
                if ($inser_query) {
                    $success = 1;
                   $msg = 'Form submitted successfully with <b style="font-size:20px">Sr. no.: ' . $form_data_collection_count_val . '</b>';
                }
            }
        }
        
        $ret_arr['messages'] = $msg;
        $ret_arr['success'] = $success;
        echo json_encode($ret_arr);
        exit();
    }

    public function generate_id_card_pdf()
    {
        
        $school_id = $this->uri->segment(2);
        $data = $this->Form_model->getSchoolFormCollectionData($school_id);
        // pr($data,1);

        // pr($grn_data,1);
        $path = dirname(dirname(__DIR__)) . "/public/uploads/compan.pdf";
        $pdf = new TCPDF('P', 'mm', 'A4', true, 'UTF-8', false);
        $pdf->SetMargins(4, 7, 4, 4);
        // set document information
        $pdf->SetCreator(PDF_CREATOR);
        // remove default header/footer
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetAutoPageBreak(true);
        // set font
        $pdf->SetFont('helvetica', '', 10);
        // add a page
        $pdf->AddPage();
        $data['data'] = $data;
        $html = $this->load->view('generate_id_card_pdf.tpl', $data, true);


        // $pdf->setCellPaddings( $left = '', $top = '2px', $right = '', $bottom = '2px');
        $pdf->writeHTML($html, true, 0, true, 0);
        // $pdf->writeHTMLCell(0, 0, '', '', $html, 0, 1, 0, true, '', true);
        $pdf->Output("Id_Cards.pdf", 'D');
    }

    public function formFieldListing()
    {
        $column[] = [
            "data" => "form_title",
            "title" => "Form Title",
            "width" => "10%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "form_type",
            "title" => "Form Type",
            "width" => "7%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "field_type",
            "title" => "Input Type",
            "width" => "7%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "form_value",
            "title" => "Input Value",
            "width" => "8%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "prefix",
            "title" => "Prefix",
            "width" => "5%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "length",
            "title" => "Length",
            "width" => "5%",
            "className" => "status dt-center",
        ];
         $column[] = [
            "data" => "added_by",
            "title" => "Added By",
            "width" => "8%",
            "className" => "status dt-center",
        ];
         $column[] = [
            "data" => "added_date",
            "title" => "Added Date",
            "width" => "8%",
            "className" => "status dt-center",
        ];
         $column[] = [
            "data" => "updated_by",
            "title" => "Updated By",
            "width" => "8%",
            "className" => "status dt-center",
        ];
         $column[] = [
            "data" => "updated_date",
            "title" => "Updated Date",
            "width" => "8%",
            "className" => "status dt-center",
        ];
        $column[] = [
            "data" => "action",
            "title" => "Action",
            "width" => "8%",
            "className" => "dt-center",
        ];
        
        $data["data"] = $column;
        $data["is_searching_enable"] = true;
        $data["is_paging_enable"] = true;
        $data["is_serverSide"] = true;
        $data["is_ordering"] = true;
        $data["is_heading_color"] = "#a18f72";
        $data["no_data_message"] =
            '<div class="p-3 no-data-found-block"><img class="p-2" src="' .
            base_url() .
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Employee data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[11, 'desc']]);
        $data["page_length_arr"] = [[20,100,500,1000,2000,2500,3000,-1], [20,100,500,1000,2000,2500,3000,'All']];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        $this->smarty->loadView('form_field_listing.tpl', $data,'Yes','Yes');
    }

    public function formFieldListingData(){
        $post_data = $this->input->post();
        
        $column_index = array_column($post_data["columns"], "data");
        $order_by = "";
        foreach ($post_data["order"] as $key => $val) {
            if ($key == 0) {
                $order_by .= $column_index[$val["column"]] . " " . $val["dir"];
            } else {
                $order_by .=
                    "," . $column_index[$val["column"]] . " " . $val["dir"];
            }
        }
        $condition_arr["order_by"] = $order_by;
        $condition_arr["start"] = $post_data["start"];
        $condition_arr["length"] = $post_data["length"];
        $base_url = $this->config->item("base_url");
        $data = $this->Form_model->getFieldDetails($condition_arr,$post_data["search"]);
        foreach ($data as $key => $val) {
            $data[$key]['prefix'] = display_no_character($val['prefix']);
            $data[$key]['field_type'] = display_no_character($val['field_type']);
            $data[$key]['form_value'] = display_no_character($val['form_value']);
            $data[$key]['length'] = $val['length'] > 0 ? $val['length'] : display_no_character();
            $data[$key]['updated_by'] = display_no_character($val['updated_by']);
            $data[$key]['updated_date'] = $val['updated_date'] != "" ? defaultDateFormat(date("Y-m-d", strtotime($val['updated_date']))) : display_no_character();
            $data[$key]['added_date'] = $val['added_date'] != "" ? defaultDateFormat(date("Y-m-d", strtotime($val['added_date']))) : display_no_character();
            $row_data = base64_encode(json_encode($val));
            $data[$key]['action'] = '
                <span class="edit-field-row" title="Edit" data-row="'.$row_data.'">
                    <i class="ti ti-edit"></i>
                </span>
                <span class="delete-feild" title="Delete" data_id="'.$val['form_field_master_id'].'">
                    <i class="ti ti-trash"></i>
                </span>
            ';
        }
        
        
        $data["data"] = $data;
        // pr($data,1);
        $total_record = $this->Form_model->getFieldDetailsCount([], $post_data["search"]);
        $data["recordsTotal"] = $total_record['total_record'];
        $data["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($data);
        exit();
    }
    public function delete_form_field(){
        $post_data = $this->input->post();
        $this->Form_model->deleteFieldMasterRow($post_data['data_id']);
        $ret_arr['messages'] = "Record deleted successfully.";
        $ret_arr['success'] = 1;
        echo json_encode($ret_arr);
        exit();
    }

    public function addUpdateFormField(){
        $post_data = $this->input->post();
        $id = $post_data['id'];
        $msg = "Something went wrong";
        $success = 0;
        if($id > 0){
            $update_date = [
                "form_title" => $post_data['form_title'],
                "form_name" => preg_replace("/[^a-zA-Z0-9_]/", "", $post_data['form_name']),
                "form_type" => $post_data['form_type'],
                "field_type" => $post_data['field_type'],
                "form_value" => $post_data['form_value'],
                "prefix" => $post_data['extra_prefix_value'] != "" ? $post_data['extra_prefix_value'] : $post_data['prefix'],
                "length" => $post_data['length'],
                'updated_date' => date("Y-m-d H:i:s"),
                'updated_by' => $this->session->userdata('user_id')
            ];
            $inser_query = $this->Form_model->updateFormField($update_date,$id);
            if ($inser_query) {
                    $success = 1;
                    $msg = 'Form field updated successfully.';
            }
        }else{
            $insert_date = [
                "form_title" => $post_data['form_title'],
                "form_name" => preg_replace("/[^a-zA-Z0-9_]/", "", $post_data['form_name']),
                "form_type" => $post_data['form_type'],
                "field_type" => $post_data['field_type'],
                "form_value" => $post_data['form_value'],
                "prefix" => $post_data['extra_prefix_value'] != "" ? $post_data['extra_prefix_value'] : $post_data['prefix'],
                "length" => $post_data['length'],
                'added_date' => date("Y-m-d H:i:s"),
                'added_by' => $this->session->userdata('user_id')
            ];
            $inser_query = $this->Form_model->insertFormField($insert_date);
            if ($inser_query) {
                    $success = 1;
                    $msg = 'Form field added successfully.';
            }
        }

        $ret_arr['messages'] = $msg;
        $ret_arr['success'] = $success;
        echo json_encode($ret_arr);
        exit();
    }

    public function download_all_ids(){
        // ini_set('display_errors', 1);
        // ini_set('display_startup_errors', 1);
        // error_reporting(E_ALL);  
        $school_id = $this->uri->segment(2);
        
        $form_data_collection_id = $this->uri->segment(3) > 0 ? $this->uri->segment(3) : 0;
        $get_data = $this->input->get();
        $selected_ids = isset($get_data['selected_ids']) ? base64_decode($get_data['selected_ids']) : "";
        $from_data_collection_data = $this->Form_model->getSchoolFormCollectionData($school_id,$form_data_collection_id,$selected_ids);
        $form_data = $this->Form_model->getFormJsonData($school_id);
        $from_field = json_decode($form_data['from_field'],TRUE);
        $from_field = array_column($from_field, "field_data");
        $id_card_data = [];
        $data_collection = [];
        $arry_key = -1;
        
        foreach ($from_data_collection_data as $ke => $val) {
            $form_details = json_decode($val['form_data'],TRUE);
            $image_value = [];
            $other_data = [];
            foreach ($from_field as $key => $value) {
                $value = json_decode($value,TRUE);
                $field_name_arr[] = $value['form_name'];
                if($value['form_type'] == "file" && $value['form_name'] == "image"){
                    if($form_details[$value['form_name']] != ""){
                        $image_value = base_url($form_details[$value['form_name']]);
                    }
                }else{
                    if($value['field_type'] == "Date"){
                        $value_ret = $form_details[$value['form_name']] != "" ? defaultDateFormat($form_details[$value['form_name']]) : display_no_character($form_details[$value['form_name']]);
                    }else{
                        $value_ret = $form_details[$value['form_name']];
                    }
                        $other_data[] = [
                            "key" => $value['form_name'],
                            "value" => display_no_character($value_ret)
                        ]; 
                        $fieldMapping['<%$'.$value['form_name'].'%>'] = $value['form_name'];
                    }
            }
            $fieldMapping['<%$image%>'] = 'image';
            $fieldMapping['<%$sr_no%>'] = 'sr_no';
            if($ke % 2 == 0){
                $arry_key += 1;
            }
            // if(array)
            $id_card_data[$arry_key][] = [
                "sr_no" => $val['sr_no'],
                "image" => $image_value,
                "other_data" => $other_data
            ];
        }
       // testing starts
        $design_data = $this->Form_model->getIdCardFieldComp($school_id);
        $fieldsConfig = json_decode($design_data['design_data'],true);
        $config_arr = array_column($fieldsConfig,'type');
        $image_index = array_search('image',$config_arr);
        $image_height = $fieldsConfig[$image_index]['height'] .'px';
        $image_width = $fieldsConfig[$image_index]['width'].'px';
        $students = [];
        $chuck_data = $design_data['col_per_row'];
       
    foreach ($id_card_data as $row) {
        foreach ($row as $student) {
            // Create key-value pairs for student data
            $studentData = [];
            $student['other_data'][]= ["key" => "sr_no" ,"value" => $student['sr_no']];
            foreach ($student['other_data'] as $item) {
                $studentData[$item['key']] = $item['value'];
                $studentData['image'] = '<img style="object-fit: contain; height: '.$image_height.'; width: '.$image_width.';" src="'.$student['image'].'">';
            }
            $students[] = $studentData;
        }
    }
    $tem_pte = ['fieldsConfig' => $fieldsConfig,
            'students' => array_chunk($students, $chuck_data),
            'fieldMapping' => $fieldMapping,
            'backgroundImage' => base_url('/public/design_backgrounds/'.$design_data['background_image']),
        ];
        $tem_pte['width'] = $design_data['width'];
        $tem_pte['height'] = $design_data['height'];
        $html = $this->smarty->fetch('new_pdf_generate.tpl', $tem_pte, TRUE);
        $data['id_card_data'] = $id_card_data;

        $file_name = "id_cards_".$form_data['url'].date("_d-m-Y_H-i").".pdf";
        $file_path = FCPATH . 'public/card_designs/design_' . uniqid() . '.html';
        if (!is_dir(dirname($file_path))) {
            mkdir(dirname($file_path), 0755, true);
        }
        write_file($file_path, $html);
        if($form_data_collection_id > 0){
            $file_name ="id_cards_".$form_data['url'].date("_d-m-Y_H-i").".pdf";;
        }
        
        // $html = $this->smarty->fetch('pdf_generate.tpl', $data, TRUE);
        // $this->generatePdf($html,"D",$file_name,"Normal");
        
        $this->generatePdfWithDom($html);
    }
    public function preview_id_card(){
        $school_id = $this->uri->segment(2);
        $form_data_collection_id = $this->uri->segment(3) > 0 ? $this->uri->segment(3) : 0;
        $from_data_collection_data = $this->Form_model->getSchoolFormCollectionData($school_id,$form_data_collection_id);
        $form_data = $this->Form_model->getFormJsonData($school_id);
        $from_field = json_decode($form_data['from_field'],TRUE);
        $from_field = array_column($from_field, "field_data");
        $id_card_data = [];
        $data_collection = [];
        $arry_key = -1;

        foreach ($from_data_collection_data as $ke => $val) {
            $form_details = json_decode($val['form_data'],TRUE);
            $image_value = [];
            $other_data = [];
            foreach ($from_field as $key => $value) {
                $value = json_decode($value,TRUE);
                if($value['form_type'] == "file"){
                    if($form_details[$value['form_name']] != "" && $value['form_name'] == "image"){
                        $image_value = base_url($form_details[$value['form_name']]);
                    }
                }else{
                    if($value['field_type'] == "Date"){
                        $value_ret = $form_details[$value['form_name']] != "" ? defaultDateFormat($form_details[$value['form_name']]) : display_no_character($form_details[$value['form_name']]);
                    }else{
                        $value_ret = $form_details[$value['form_name']];
                    }
                        $other_data[] = [
                            "key" => $value['form_title'],
                            "value" => display_no_character($value_ret)
                        ]; 
                    }
            }
            if($ke % 2 == 0){
                $arry_key += 1;
            }
            // if(array)
            $id_card_data[$arry_key][] = [
                "sr_no" => $val['sr_no'],
                "image" => $image_value,
                "other_data" => $other_data
            ];
        }
        $data['id_card_data'] = $id_card_data;
        $data['type'] = "Preview";
        $html = $this->smarty->fetch('pdf_generate.tpl', $data, TRUE);
        $file_name = "id_card.pdf";
        $this->generatePdf($html,"I",$file_name,"Preview");
    }
    public function generatePdf($html_content = "",$type="D",$file_name="id_card.pdf",$sizeType){
        ob_start();
        require_once APPPATH . 'libraries/Pdf1.php';
        if($sizeType == "Preview"){
            $width = 110; 
            $height = 110;
            $size = array($width, $height);
        }else{
            $size = "A4";
        }
        
        $pdf = new Pdf1('P', 'mm',$size, true, 'UTF-8', false,'',0,0,0, 0);

        $pdf->SetMargins(-5, 0, 0, 0);

        // set document information

        $pdf->SetCreator(PDF_CREATOR);

        // set default monospaced font
        $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

        

        // set image scale factor
        $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);

        $pdf->AddPage(); // Left, Top, Right margins
        $pdf->SetAutoPageBreak(TRUE, 0); 
        

        $pdf->writeHTMLCell(0, 0, '', '', $html_content, 0, 0, 0, true, '', true);
        // $pdf->Output("id_card_fixed.pdf", 'D');

            $pdf->Output($file_name, $type);
             ob_end_flush();
       
        
       
    } 

    public function form_data_edit(){
        $post_data = $this->input->post();
        $form_data = $this->Form_model->getFormCollectionEditData($post_data['collection_id']);
        // pr($form_data,1);
        $data = [];
        $prefix_data_arr = [];
        if(is_valid_array($form_data)){
            $form_fields = json_decode($form_data['from_field'],TRUE);
            foreach ($form_fields as $key => $value) {
                $fields = json_decode($value['field_data'],TRUE);
                if($fields['form_type'] == "radio" || $fields['form_type'] == "drop_down"){
                    $fields['form_value'] = explode(",", $fields['form_value']);
                }
                if($fields['prefix'] != ""){
                    $prefix_data_arr[$fields['form_name']] = $fields['prefix'];
                }
                $form_fields[$key]['field_data'] = $fields;
            }
           
            $form_values = json_decode($form_data['form_data'],TRUE);
            foreach ($form_values as $key => $value) {
                if(array_key_exists($key,$prefix_data_arr)){
                    $value = trim(str_replace($prefix_data_arr[$key], "", $value));
                    $form_values[$key] = $value;
                }
            }
            $data = [];
            $data['form_fields'] = $form_fields;
            $data['form_data'] = $form_data;
            $data['form_values'] = $form_values;
            $html_content = $this->smarty->fetch('edit_form_data.tpl', $data,TRUE);
        }else{
            $data = [];
            $html_content = "";
        }
        

        $return = [
            "html_content" => $html_content
        ];
        echo json_encode($return);
    }
    public function form_image_data_edit(){
        $post_data = $this->input->post();
        $form_data = $this->Form_model->getFormCollectionEditData($post_data['collection_id']);
        // pr($form_data,1);
        $data = [];
        $prefix_data_arr = [];
        if(is_valid_array($form_data)){
            $form_fields = json_decode($form_data['from_field'],TRUE);
            foreach ($form_fields as $key => $value) {
                $fields = json_decode($value['field_data'],TRUE);
                if($fields['form_type'] == "radio" || $fields['form_type'] == "drop_down"){
                    $fields['form_value'] = explode(",", $fields['form_value']);
                }
                if($fields['prefix'] != ""){
                    $prefix_data_arr[$fields['form_name']] = $fields['prefix'];
                }
                $form_fields[$key]['field_data'] = $fields;
            }
           
            $form_values = json_decode($form_data['form_data'],TRUE);
            foreach ($form_values as $key => $value) {
                if(array_key_exists($key,$prefix_data_arr)){
                    $value = trim(str_replace($prefix_data_arr[$key], "", $value));
                    $form_values[$key] = $value;
                }
            }
            $data = [];
            $data['form_fields'] = $form_fields;
            $data['form_data'] = $form_data;
            $data['form_values'] = $form_values;
            $html_content = $this->smarty->fetch('edit_form_image_data.tpl', $data,TRUE);
        }else{
            $data = [];
            $html_content = "";
        }
        

        $return = [
            "html_content" => $html_content
        ];
        echo json_encode($return);
    }
    public function submit_edit_form(){
        
        $post_data = $this->input->post();
       
        $form_collected_data = $this->Form_model->getFormCollectionEditData($post_data['form_data_collection_id']);
        $form_data = $this->Form_model->getFormJson($post_data['from_url']);
        $form_fields = json_decode($form_data['from_field'],TRUE);
        $image_arr = [];

        $form_data_collection_count = $this->Form_model->getSchoolFormCollectionDataCount($post_data['matser_id']);
        $form_data_collection_count_val = $form_data_collection_count['count'] > 0 ? $form_data_collection_count['count']+1 : 1;
        $form_data_json = [];
        foreach ($form_fields as $key => $value) {
            $field_data = json_decode($value['field_data'],TRUE);
            if($field_data['form_type'] != "file"){
                $original_name = $field_data['form_name'];
                $field_data['form_name'] = str_replace('.', '_', $field_data['form_name']);
                $field_value = $post_data[$field_data['form_name']] != "" ? $post_data[$field_data['form_name']] : "";
                $field_value = $field_data['prefix'] != "" ? $field_data['prefix']." ".$field_value : $field_value;
                $form_data_json[$original_name] = $field_value;
            }
        }
        $form_collected_data_values = json_decode($form_collected_data['form_data'],TRUE);
        $form_collected_data_values = array_merge($form_collected_data_values,$form_data_json);
        // pr($data,1);
        // foreach ($form_collected_data_values as $key => $value) {
        //     if(array_key_exists($key,$form_data_json)){
        //         $form_collected_data_values[$key] = $form_data_json[$key] != "" ? $form_data_json[$key] : "";
        //     }
        // }
        $msg = "Something went wrong";
        $success = 0;
        $update_data = [
            "form_data" => json_encode($form_collected_data_values,TRUE),
            "updated_by" => $this->session->userdata('user_id'),
            "updated_date" => date("Y-m-d H:i:s")
        ];
        // pr($update_data,1);
        $affected_row = $this->Form_model->updateFormData($update_data,$post_data['form_data_collection_id']);
        if ($affected_row > 0) {
            $success = 1;
            $msg = 'Form data updated successfully.';
        }
        
        $ret_arr['messages'] = $msg;
        $ret_arr['success'] = $success;
        echo json_encode($ret_arr);
        exit();
    }
    public function submit_edit_image_form(){
        
        $post_data = $this->input->post();
        $form_collected_data = $this->Form_model->getFormCollectionEditData($post_data['form_data_collection_id']);
        $form_data = $this->Form_model->getFormJson($post_data['from_url']);
        $form_fields = json_decode($form_data['from_field'],TRUE);
        $image_arr = [];
        $form_data_collection_count_val = $form_collected_data['sr_no'];
        $folderPath = "public/uploads/data_collection_img/" . $post_data['from_url'];
        if (!is_dir($folderPath) && $folderPath != "") {
            mkdir($folderPath, 0777, true);
        }
        $upload_error_msg = [];
        foreach ($_FILES as $key => $value) {
            // Get the uploaded image
            $profileImageData = $_FILES[$key]["name"] != "" ? $_FILES[$key] : [];
            $fileName = $_FILES[$key]['name'];
            $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
            $_FILES[$key]["name"] = $post_data['from_url']."_".$form_data_collection_count_val.".".$fileExtension;
            $folderPath .= "/".$key;
            // Ensure the folder exists, if not, create it
            if (!is_dir($folderPath) && $folderPath != "") {
                mkdir($folderPath, 0777, true);
            }
            // Set upload configuration
            $config["upload_path"] = $folderPath;
            $config["allowed_types"] = "jpg|png|jpeg|bmp|heic";  // Allow jpg, png, and jpeg files
            $config['max_size'] = 10240;
            $this->load->library("upload", $config);
            $this->upload->initialize($config);
            if (!empty($profileImageData)) {
                
                if (!$this->upload->do_upload($key)) {
                    // If upload fails, store the error message
                    $error = $this->upload->display_errors('', '');
                    if (strpos($error, 'filetype') !== false) {
                        $custom_error = 'Only JPG, PNG, JPEG, BMP, and HEIC files are allowed.';
                    } elseif (strpos($error, 'The file you are attempting to upload is larger than the permitted size.') !== false) {
                        $custom_error = 'The file is too large. Maximum allowed size is 10 MB.';
                    } else {
                        $custom_error = $error; // fallback to default message
                    }
                    $upload_error_msg = $error = [
                        "error" => $custom_error,
                    ];
                    $upload_error = 1;
                    $image_arr[$key] = "";
                } else {
                    // Upload successful, get the uploaded file data
                    $upload_data = $this->upload->data();
                    $uploadedFilePath = $folderPath . "/" . $upload_data['file_name'];

                    // Convert image to JPG if it's PNG or JPEG
                    $fileType = strtolower(pathinfo($uploadedFilePath, PATHINFO_EXTENSION));
                    if ($fileType == 'png' || $fileType == 'jpeg') {
                        $newFilePath = $folderPath . "/" . pathinfo($upload_data['file_name'], PATHINFO_FILENAME) . '.jpg';

                        // Load the image depending on its type
                        if ($fileType == 'png') {
                            $image = imagecreatefrompng($uploadedFilePath);
                        } elseif ($fileType == 'jpeg') {
                            $image = imagecreatefromjpeg($uploadedFilePath);
                        }

                        // Save the image as JPG
                        imagejpeg($image, $newFilePath, 90); // Save with 90% quality
                        imagedestroy($image); // Free memory

                        // Delete the original uploaded PNG/JPEG file
                        unlink($uploadedFilePath);

                        // Update the image path to the new JPG
                        $image_arr[$key] = $newFilePath;
                    } else {
                        // If already JPG, just use the uploaded file
                        $image_arr[$key] = $uploadedFilePath;
                    }
                }
            }
        }
        if (count($upload_error_msg) > 0 ) {
            $msg = $upload_error_msg["error"];
        } else {
            $form_data_json = [];
            foreach ($form_fields as $key => $value) {
                $field_data = json_decode($value['field_data'],TRUE);
                if($field_data['form_type'] == "file"){
                    $form_data_json[$field_data['form_name']] = $image_arr[$field_data['form_name']] != "" ? $image_arr[$field_data['form_name']] : "";
                }
            }
            $form_collected_data_values = json_decode($form_collected_data['form_data'],TRUE);
            $form_collected_data_values = array_merge($form_collected_data_values,$form_data_json);
            $msg = "Something went wrong";
            $success = 0;
            $update_data = [
                "form_data" => json_encode($form_collected_data_values,TRUE),
                "updated_by" => $this->session->userdata('user_id'),
                "updated_date" => date("Y-m-d H:i:s")
            ];
            // pr($update_data,1);
            $affected_row = $this->Form_model->updateFormData($update_data,$post_data['form_data_collection_id']);
            if ($affected_row > 0) {
                $success = 1;
                $msg = 'Form image data updated successfully.';
            }
        }
        
        $ret_arr['messages'] = $msg;
        $ret_arr['success'] = $success;
        echo json_encode($ret_arr);
        exit();
    }

    public function change_card_generated(){
        $post_data = $this->input->post();
        $selected_records = $post_data['selected_records'];
        $selectedReason = $post_data['selectedReason']."_".date("d-m-Y_H_i");
        $afftectedRows = $this->Form_model->updateCardGenerated($selected_records,$selectedReason);
        if($afftectedRows > 0){
            $ret_arr['messages'] = "Card genrated updated successfully.";
            $ret_arr['success'] = 1;
        }else{
            $ret_arr['messages'] = "Something went wrong";
            $ret_arr['success'] = 0;
        }
        
        echo json_encode($ret_arr);
        exit();
    }

    public function export_form_data(){
        // error_reporting(-1);
		// ini_set('display_errors', 1);
        require_once APPPATH . 'libraries/PHPExcel/IOFactory.php';
        $this->load->library('excel');
        $object = new PHPExcel();
        $sheet = $object->getActiveSheet();
        $school_id = $this->uri->segment(2);
        $form_data = $this->Form_model->getFormJsonData($school_id);
        $sheet->setTitle(substr($form_data['name'], 0, 31));
        // pr($form_data['name'],1);
        $from_field = json_decode($form_data['from_field'],TRUE);
        $from_field = array_column($from_field, "field_data");
        $headings = [];
        $headings[] = "SR. NO.";
        foreach ($from_field as $key => $value) {
            $value = json_decode($value,TRUE);
            $headings[] = $value['form_title'];
        }
        // Set headers only
        $sheet->fromArray([$headings], NULL, 'A1');

        // Optional styling
        $sheet->getStyle($sheet->calculateWorksheetDimension())->getFont()->setBold(true);;

        $filename = $form_data['url']."_" . date('d-m-Y_H_i') . '.xlsx';
        $colCount = count($headings); // e.g., 3
        for ($i = 0; $i < $colCount; $i++) {
            $colLetter = PHPExcel_Cell::stringFromColumnIndex($i); // A, B, C...
            $sheet->getColumnDimension($colLetter)->setWidth(20);
        }
        // Fix corruption: clean buffer before output
        ob_end_clean();

        // Send headers
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header("Content-Disposition: attachment;filename=\"$filename\"");
        header('Cache-Control: max-age=0');

        // Output Excel file
        $writer = PHPExcel_IOFactory::createWriter($object, 'Excel2007');
        $writer->save('php://output');
        exit;
    }

    public function importFormData(){
        require_once APPPATH . 'libraries/PHPExcel/IOFactory.php';

        if (!empty($_FILES['import_file']['name'])) {
            $fileTmpPath = $_FILES['import_file']['tmp_name'];
            $fileType = $_FILES['import_file']['type'];
            $school_id = $this->input->post("school_id");
            $form_data = $this->Form_model->getFormJsonData($school_id);
            $from_field = json_decode($form_data['from_field'],TRUE);
            $from_field = array_column($from_field, "field_data");

            $form_data_collection_count = $this->Form_model->getSchoolFormCollectionDataCount($school_id);
            $form_data_collection_count_val = $form_data_collection_count['count'] > 0 ? $form_data_collection_count['count']+1 : 1;
            $message = "Something went wrong";
            $success = 0;
            try {
                // Read directly from temp location
                $objPHPExcel = PHPExcel_IOFactory::load($fileTmpPath);
                $sheetData = $objPHPExcel->getActiveSheet()->toArray(null, true, true, true);
                // pr($sheetData,1);
                if(count($sheetData[1]) == (count($from_field)+1)){
                    unset($sheetData[1]);
                    $form_data_json = [];
                    $formattedData = [];
                    foreach ($sheetData as $rowNum => $row) {
                        $formattedRow = array_values($row); // Converts ['A'=>..., 'B'=>...] to [0=>..., 1=>...]
                        $formattedData[$rowNum] = $formattedRow;
                    }
                    foreach ($formattedData as $key => $val) {
                        
                        foreach ($from_field as $key => $value) {
                            
                            $field_data = json_decode($value,TRUE);
                            if($field_data['form_type'] == "file"){
                                $original_name = $field_data['form_name'];
                                $folderPath = "public/uploads/data_collection_img/" . $form_data['url']."/";
                                $image_name = $original_name."/".$form_data['url']."_".$val[0].".jpg";
                                $folderPath .= $image_name;
                                $form_data_json[$original_name] = $folderPath;
                            }else{
                                $original_name = $field_data['form_name'];
                                $field_data['form_name'] = str_replace('.', '_', $field_data['form_name']);
                                $field_value = $val[$key+1] != "" ? $val[$key+1] : "";
                                $field_value = $field_data['prefix'] != "" ? $field_data['prefix']." ".$field_value : $field_value;
                                $form_data_json[$original_name] = $field_value;
                            }
                        }
                        
                        $insert_data[] = [
                            "school_master_id" => $school_id,
                            "sr_no" => $val[0],
                            "form_data" => json_encode($form_data_json,TRUE),
                            "added_date" => date("Y-m-d H:i:s")
                        ];
                        $form_data_collection_count_val++;
                    }
                    $inser_query = $this->Form_model->insertBatchFormData($insert_data);
                    if ($inser_query) {
                        $success = 1;
                        $message = 'Import data succesfully.';
                    }
                } else {
                    $message = "Please add proper column data";
                }
                
            } catch (Exception $e) {
                // die('Error loading file: ' . $e->getMessage());
            }
        }

        $ret_arr['messages'] = $message;
        $ret_arr['success'] = $success;
        echo json_encode($ret_arr);
        exit();

    }
     /* design changes */
    // below code is editor.
    public function designer($id = null) {
        $data['design'] = null;
        $data['design_id'] = $id;
        $school_data = $this->Form_model->getSchoolFormCollectionDetail($id);
        $data['school_data'] = $school_data;
        if ($id) {
            $design = $this->Form_model->get_design($id);
            if ($design) {
                $design_data = $design['design_data'];
                if (isset($design_data['fields'])) {
                    $fields = $design_data['fields'];
                } else {
                    $fields = [];
                    foreach ($design_data as $key => $value) {
                        if (is_array($value) && isset($value['type'])) {
                            $fields[] = $value;
                        }
                    }
                }
               
                $data['design'] = [
                    'width' => $design['width'],
                    'height' => $design['height'],
                    'fields' => $fields,
                ];
                
            }
        }

        $form_data = $this->Form_model->getFormJsonData($id);
        $from_field = json_decode($form_data['from_field'],TRUE);
        $from_field = array_column($from_field, "field_data");
        
        $newField = json_encode([
            "form_field_master_id" => "15",
            "form_title" => "Sr No",
            "form_name" => "sr_no",
            "form_type" => "input",
            "field_type" => "Text",
            "form_value" => "",
            "prefix" => null,
            "length" => "0",
            "added_by" => "1",
            "added_date" => date("Y-m-d H:i:s"),
            "updated_by" => null,
            "updated_date" => null
        ]);
        array_unshift($from_field, $newField);
        foreach ($from_field as $key => $value) {
            $value = json_decode($value,TRUE);
            $column[$value['form_name']] = '<%$'.$value['form_name'].'%>';
            $form_tittle[$value['form_name']] =  $value['form_title'];
            $field_type[] = $value['form_name'];
        }
        $data['field_types'] = $field_type;
        $data['placeholder_data'] = $column;
        $data['form_tittle'] = $form_tittle;
        $data['save_url'] = site_url('idcard/save');
        $data['base_url'] = base_url(); 
        $data['image_url'] = base_url('public/design_backgrounds/'.$design['background_image']);
        $this->smarty->loadView('idcard_designer.tpl', $data,'Yes','No');                                                                                                          
        // $this->smarty->display('idcard_designer.tpl',$data);
                                                                                      
        // $this->smarty->display('idcard_designer.tpl',$data);

    }

    public function save() {     
        $this->load->helper('file');   
        $design = $this->input->post('design');
        $design_id = $this->input->post('design_id');
        // Ensure fields are properly structured
        $fields = [];
        $backgroundImage = basename($design['backgroundImage']);
        $old_url = $design['old_url'];
        if (isset($design['fields']) && is_array($design['fields'])) {
            foreach ($design['fields'] as $key => $field) {
                if (isset($field['type'])) {
                    $fields[] = $field;
                    $design['fields'][$key]['html'] = html_entity_decode($field['html']);
                }
            }
        }
        // pr($fields,1);
        if($old_url != ''){
            $file_url = $old_url;
            $backgroundImage = basename($old_url);
        }else{
            // $file_url = base_url('public/design_backgrounds/'.$fileName);
            $file_url = $design['backgroundImage'];
        }
        
        // Prepare data for saving
        // pr($design,1);
        $html_template = $this->generate_html_template($design,$file_url);
        $save_data = [
            'entity_id' => $design_id,
            'name' => $design['name'] ?: 'ID Card Design ' . ($design_id ?: 'New'),
            'width' => $design['width'],
            'height' => $design['height'],
            'design_data' => json_encode($fields),
            'html_template' => $html_template,
            'background_image' => $backgroundImage,
            'col_per_row' => isset($design['col_per_row']) && $design['col_per_row'] > 0 ? $design['col_per_row'] : 2
        ];
       
        // Save to database
        $saved_id = $this->Form_model->save_design($save_data);
        
        // ... rest of your save logic
        $file_path = FCPATH . 'public/card_designs/design_' . $saved_id . '.html';
        if (!is_dir(dirname($file_path))) {
            mkdir(dirname($file_path), 0755, true);
        }
        write_file($file_path, $html_template);
        // $pdf_path = $this->generate_pdf($html_template, 5);
        
        $dompdf = new Dompdf();
        
        $dompdf->set_option('isRemoteEnabled', true);
        $dompdf->set_option('isPhpEnabled', true);
        $dompdf->set_option('tempDir', sys_get_temp_dir());
        // Load HTML content
        $dompdf->loadHtml($html_template);
        
        // (Optional) Setup the paper size and orientation
        // $dompdf->setPaper('A4', 'portrait');
        $dompdf->setPaper('A4', 'landscape');

        // Render the HTML as PDF
        $dompdf->render();
        
        // Output the generated PDF
        $filename = 'document_' . date('Ymd_His') . '.pdf';
        $filepath =  FCPATH . 'public/card_designs/design_' . $saved_id .'.pdf';
    
    // 7. Save the PDF to file
        file_put_contents($filepath, $dompdf->output());
        // echo json_encode($ret_arr);
        // exit;
    }

    public function generatePdfWithDom($html = ''){
        $dompdf = new Dompdf();
        
        $dompdf->set_option('isRemoteEnabled', true);
        $dompdf->set_option('isPhpEnabled', true);
        $dompdf->set_option('tempDir', sys_get_temp_dir());
        // Load HTML content
        $dompdf->loadHtml($html);
        
        // (Optional) Setup the paper size and orientation
        $dompdf->setPaper('A4', 'portrait');
        
        // Render the HTML as PDF
        $dompdf->render();
        $saved_id = uniqid();
        // Output the generated PDF
        $filename = 'design_' . $saved_id .'.pdf';
        $filepath =  FCPATH . 'public/card_designs/'.$filename;
    
    // 7. Save the PDF to file
        file_put_contents($filepath, $dompdf->output());
        $this->download_pdf($filepath);
    }
    

    public function download_pdf($filepath) {
        // $filepath = FCPATH.'public/card_designs/'.$filename;
        // pr($fie)
        if (file_exists($filepath)) {
            header('Content-Description: File Transfer');
            header('Content-Type: application/pdf');
            header('Content-Disposition: attachment; filename="'.basename($filepath).'"');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($filepath));
            readfile($filepath);
            
            // Optional: Delete after download
            // unlink($filepath);
            exit;
        } else {
            show_404();
        }
    }

    private function generate_html_template($design = [], $bg_url = '') {
        // Set default dimensions if not provided
        
        $width = isset($design['width']) ? $design['width'] : 595; // Default A4 width in pixels
        $height = isset($design['height']) ? $design['height'] : 842; // Default A4 height in pixels
        $html = '<table>';
        // Start HTML with proper DOCTYPE and meta tags
        $html .= '<tr>';
        
        // Start card container
        $html .= '<td><div class="id-card" style="position:relative;width: 350px; height: 300px;">';
        
        // Add background image (as img tag instead of CSS background for better PDF compatibility)
        if (!empty($bg_url)) {
            $html .= '<img src="'.htmlspecialchars($bg_url, ENT_QUOTES).'" style="
                position: absolute;
                top: 0;
                left: 0;
                width: 350px;
                height: 300px;
                object-fit: contain;
                z-index: -1;
            ">';
        }
        
        // Add all fields
        if (isset($design['fields']) && is_array($design['fields'])) {
            foreach ($design['fields'] as $field) {
                if (!isset($field['type'])) continue;
                $top = isset($field['top']) ? $field['top'] : 0;
                $left = isset($field['left']) ? $field['left'] : 0;
                $width = isset($field['width']) ? $field['width'] : 50;
                $height = isset($field['height']) ? $field['height'] : 50;
                $html .= '<div style="
                    position: absolute;
                    top: '.$top.'px;
                    left: '.$left.'px;
                    width: '.$width.'px;
                    height: '.$height.'px;';
                
                // Add specific styles based on field type
                switch ($field['type']) {
                    
                    case 'image':
                        $html .= 'overflow: hidden;';
                        break;
                    case 'barcode':
                    case 'qr':
                        $html .= 'display: flex; align-items: center; justify-content: center;';
                        break;
                    default:
                        $html .= 'font-family: Arial, sans-serif;'; // Default font
                        break;
                }
                
                $html .= '">';
                
                // Safely output field content
                if (isset($field['html'])) {
                    $html .= $field['html'];
                } elseif (isset($field['placeholder'])) {
                    $html .= htmlspecialchars($field['placeholder'], ENT_QUOTES);
                }
                
                $html .= '</div>';
            }
        }
        // second column;
        $html .= '</div></td>';


        $html .= '<td><div class="id-card" style="position:relative;width: 350px; height: 300px;">';
        
        // Add background image (as img tag instead of CSS background for better PDF compatibility)
        if (!empty($bg_url)) {
            $html .= '<img src="'.htmlspecialchars($bg_url, ENT_QUOTES).'" style="
                position: absolute;
                top: 0;
                left: 0;
                width: 350px;
                height: 300px;
                object-fit: contain;
                z-index: -1;
            ">';
        }
        
        // Add all fields
        if (isset($design['fields']) && is_array($design['fields'])) {
            foreach ($design['fields'] as $field) {
                if (!isset($field['type'])) continue;
                
                // Set default field properties
                $top = isset($field['top']) ? $field['top'] : 0;
                $left = isset($field['left']) ? $field['left'] : 0;
                $width = isset($field['width']) ? $field['width'] : 100;
                $height = isset($field['height']) ? $field['height'] : 50;
                
                $html .= '<div style="
                    position: absolute;
                    top: '.$top.'px;
                    left: '.$left.'px;
                    width: '.$width.'px;
                    height: '.$height.'px;';
                
                // Add specific styles based on field type

                switch ($field['type']) {
                    case 'image':
                        $html .= 'overflow: hidden;';
                        break;
                    case 'barcode':
                    case 'qr':
                        $html .= 'display: flex; align-items: center; justify-content: center;';
                        break;
                    default:
                        $html .= 'font-family: Arial, sans-serif;'; // Default font
                        break;
                }
                
                $html .= '">';
                
                // Safely output field content
                if (isset($field['html'])) {
                    $html .= $field['html'];
                } elseif (isset($field['placeholder'])) {
                    $html .= htmlspecialchars($field['placeholder'], ENT_QUOTES);
                }
                
                $html .= '</div>';
            }
        }
        
        $html .= '</div></td></tr>';
        
        $html .= '</table>';
        return $html;
    }


    public function upload_background() {
       
        $config['upload_path'] = FCPATH.'public/design_backgrounds/';
        $config['allowed_types'] = 'gif|jpg|jpeg|png';
        $config['max_size'] = 2048; // 2MB
        $config['encrypt_name'] = TRUE;
        $this->load->library('upload', $config);
        
        if (!$this->upload->do_upload('bg_image')) {
            $error = $this->upload->display_errors();
            echo json_encode(['success' => false, 'error' => $error]);
        } else {
            $data = $this->upload->data();
            $url = base_url('public/design_backgrounds/' . $data['file_name']);
            echo json_encode(['success' => true, 'url' => $url]);
        }
        exit;
    }
    public function deleteSchoolImg()
    {
        $post_data = $this->input->post();
        $message = "Somthing went wrong";
        $success = 0;
        if($post_data['school_id'] > 0){
            $school_data = $this->Form_model->getSchoolFormCollectionDetail($post_data['school_id']);
            $folderPath = "public/uploads/data_collection_img/" . $school_data['url'];
            if ($this->deleteFolder($folderPath)) {
                $success = 1;
                $message = "School images deleted successfully.";
            }
        }
        $ret_arr['messages'] = $message;
        $ret_arr['success'] = $success;
        echo json_encode($ret_arr);
        exit();

    }
    public function deleteFolder($folderPath = ""){
        if (!is_dir($folderPath)) return false;
        $files = array_diff(scandir($folderPath), ['.', '..']);

        foreach ($files as $file) {
            $filePath = $folderPath . DIRECTORY_SEPARATOR . $file;

            if (is_dir($filePath)) {
                $this->deleteFolder($filePath); // Recursively delete subfolder
            } else {
                unlink($filePath); // Delete file
            }
        }

        return rmdir($folderPath);
    }
  

}



