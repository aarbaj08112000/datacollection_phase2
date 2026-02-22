<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once FCPATH.'/vendor/autoload.php';
use Dompdf\Dompdf;

class Configration extends MY_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('Configration_model');
        require_once(APPPATH.'libraries/tcpdf/tcpdf.php');
    }

    /**
     * Configuration Settings Listing
     */
    public function configSettingList() {
        $current_route = $this->uri->segment(1);
        checkGroupAccess($current_route, "list", "Yes");
        
        $column = [];
        $column[] = [
            "data" => "name",
            "title" => "Name",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "title",
            "title" => "Title",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "value",
            "title" => "Value",
            "width" => "30%",
            "className" => "dt-left",
            "render" => null  // Prevent DataTables from truncating
        ];
        $column[] = [
            "data" => "description",
            "title" => "Description",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "type",
            "title" => "Type",
            "width" => "10%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "action",
            "title" => "Action",
            "width" => "10%",
            "className" => "dt-center",
        ];

        $data["data"] = $column;
        $data["is_searching_enable"] = true;
        $data["is_paging_enable"] = true;
        $data["is_serverSide"] = true;
        $data["is_ordering"] = true;
        $data["is_heading_color"] = "#a18f72";
        $data["no_data_message"] = '<div class="p-3 no-data-found-block"><img class="p-2" src="' . base_url() . 'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Configuration data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'asc']]);
        $data["page_length_arr"] = [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        
        $this->smarty->loadView('config_setting_list.tpl', $data, 'Yes', 'Yes');
    }

    /**
     * Get Configuration Settings Data for DataTable
     */
    public function configSettingListData() {
        $post_data = $this->input->post();
        $column_index = array_column($post_data["columns"], "data");
        
        $order_by = "";
        foreach ($post_data["order"] as $key => $val) {
            if ($key == 0) {
                $order_by .= $column_index[$val["column"]] . " " . $val["dir"];
            } else {
                $order_by .= "," . $column_index[$val["column"]] . " " . $val["dir"];
            }
        }
        
        $condition_arr["order_by"] = $order_by;
        $condition_arr["start"] = $post_data["start"];
        $condition_arr["length"] = $post_data["length"];
        
        $data = $this->Configration_model->getConfigSettings($condition_arr, $post_data["search"]);
        
        foreach ($data as $key => $val) {
            // Format value based on type
            if ($val['type'] == 'file' && $val['value'] != '') {
                $data[$key]['value'] = '<a href="' . base_url($val['value']) . '" target="_blank"><i class="ti ti-file"></i> View File</a>';
            } elseif ($val['type'] == 'check_box') {
                $data[$key]['value'] = $val['value'] == '1' ? '<span class="badge bg-success">Enabled</span>' : '<span class="badge bg-secondary">Disabled</span>';
            } elseif ($val['type'] == 'date' && $val['value'] != '') {
                $data[$key]['value'] = date('d-m-Y', strtotime($val['value']));
            } else {
                // For input type, display raw value without escaping (DataTables will handle it)
                $data[$key]['value'] = $val['value'] != '' ? $val['value'] : '-';
            }
            
            $data[$key]['description'] = display_no_character($val['description']);
            
            // Action buttons
            $data[$key]['action'] = '';
            if (checkGroupAccess("config_setting_list", "update", "No")) {
                $data[$key]['action'] .= '<span class="edit-config" title="Edit" data-id="' . $val['id'] . '">
                    <i class="ti ti-edit"></i>
                </span>';
            }
        }
        
        $total_record = $this->Configration_model->getConfigSettingsCount([], $post_data["search"]);
        $data["data"] = $data;
        $data["recordsTotal"] = $total_record['total_record'];
        $data["recordsFiltered"] = $total_record['total_record'];
        
        echo json_encode($data);
        exit();
    }

    /**
     * Get Configuration Setting Details for Edit
     */
    public function getConfigSetting() {
        $post_data = $this->input->post();
        $config_id = $post_data['config_id'];
        
        $config_data = $this->Configration_model->getConfigSettingById($config_id);
        
        if ($config_data) {
            $ret_arr['success'] = 1;
            $ret_arr['data'] = $config_data;
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['messages'] = "Configuration not found.";
        }
        
        echo json_encode($ret_arr);
        exit();
    }

    /**
     * Update Configuration Setting
     */
    public function updateConfigSetting() {
        $post_data = $this->input->post();
        $config_id = $post_data['config_id'];
        $type = $post_data['type'];
        
        $update_data = [
            'title' => $post_data['title'],
            'description' => $post_data['description']
        ];
        
        // Handle different field types
        switch ($type) {
            case 'check_box':
                $update_data['value'] = isset($post_data['value']) ? '1' : '0';
                break;
                
            case 'date':
                if (!empty($post_data['value'])) {
                    $update_data['value'] = date('Y-m-d', strtotime($post_data['value']));
                } else {
                    $update_data['value'] = '';
                }
                break;
                
            case 'file':
                // Handle file upload
                if (!empty($_FILES['value']['name'])) {
                    $config = [
                        'upload_path' => './public/uploads/config_files/',
                        'allowed_types' => 'gif|jpg|jpeg|png|pdf|doc|docx',
                        'max_size' => 5120, // 5MB
                        'encrypt_name' => TRUE
                    ];
                    
                    // Create directory if not exists
                    if (!is_dir($config['upload_path'])) {
                        mkdir($config['upload_path'], 0755, TRUE);
                    }
                    
                    $this->load->library('upload', $config);
                    
                    if ($this->upload->do_upload('value')) {
                        $upload_data = $this->upload->data();
                        $update_data['value'] = 'public/uploads/config_files/' . $upload_data['file_name'];
                        
                        // Delete old file if exists
                        $old_data = $this->Configration_model->getConfigSettingById($config_id);
                        if ($old_data && !empty($old_data['value']) && file_exists($old_data['value'])) {
                            unlink($old_data['value']);
                        }
                    } else {
                        $ret_arr['success'] = 0;
                        $ret_arr['messages'] = $this->upload->display_errors();
                        echo json_encode($ret_arr);
                        exit();
                    }
                }
                // If no file uploaded, don't update value field
                else {
                    unset($update_data['value']);
                }
                break;
                
            case 'input':
            default:
                $update_data['value'] = $post_data['value'];
                break;
        }
        
        $result = $this->Configration_model->updateConfigSetting($update_data, $config_id);
        
        if ($result) {
            $ret_arr['success'] = 1;
            $ret_arr['messages'] = "Configuration updated successfully.";
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['messages'] = "Error updating configuration.";
        }
        
        echo json_encode($ret_arr);
        exit();
    }

    /**
     * Add New Configuration Setting
     */
    public function addConfigSetting() {
        $post_data = $this->input->post();
        $type = $post_data['type'];
        
        // Get company_id from session or default to 1
        $company_id = $this->session->userdata('company_id') ? $this->session->userdata('company_id') : 1;
        
        $insert_data = [
            'name' => $post_data['name'],
            'title' => $post_data['title'],
            'description' => $post_data['description'],
            'type' => $type,
            'company_id' => $company_id
        ];
        
        // Handle different field types
        switch ($type) {
            case 'check_box':
                $insert_data['value'] = isset($post_data['value']) ? '1' : '0';
                break;
                
            case 'date':
                if (!empty($post_data['value'])) {
                    $insert_data['value'] = date('Y-m-d', strtotime($post_data['value']));
                } else {
                    $insert_data['value'] = '';
                }
                break;
                
            case 'file':
                // Handle file upload
                if (!empty($_FILES['value']['name'])) {
                    $config = [
                        'upload_path' => './public/uploads/config_files/',
                        'allowed_types' => 'gif|jpg|jpeg|png|pdf|doc|docx',
                        'max_size' => 5120, // 5MB
                        'encrypt_name' => TRUE
                    ];
                    
                    // Create directory if not exists
                    if (!is_dir($config['upload_path'])) {
                        mkdir($config['upload_path'], 0755, TRUE);
                    }
                    
                    $this->load->library('upload', $config);
                    
                    if ($this->upload->do_upload('value')) {
                        $upload_data = $this->upload->data();
                        $insert_data['value'] = 'public/uploads/config_files/' . $upload_data['file_name'];
                    } else {
                        $ret_arr['success'] = 0;
                        $ret_arr['messages'] = $this->upload->display_errors();
                        echo json_encode($ret_arr);
                        exit();
                    }
                } else {
                    $insert_data['value'] = '';
                }
                break;
                
            case 'input':
            default:
                $insert_data['value'] = $post_data['value'];
                break;
        }
        
        $insert_id = $this->Configration_model->insertConfigSetting($insert_data);
        
        if ($insert_id) {
            $ret_arr['success'] = 1;
            $ret_arr['messages'] = "Configuration added successfully.";
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['messages'] = "Error adding configuration.";
        }
        
        echo json_encode($ret_arr);
        exit();
    }

    /**
     * ========================================
     * FIELD SELECTION MODULE
     * ========================================
     */

    /**
     * Field Selection List - Show all groups
     */
    public function fieldSelectionList() {
        $current_route = $this->uri->segment(1);
        checkGroupAccess($current_route, "list", "Yes");
        
        $column = [];
        $column[] = [
            "data" => "group_name",
            "title" => "Group Name",
            "width" => "30%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "group_code",
            "title" => "Group Code",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "status",
            "title" => "Status",
            "width" => "15%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "configured_fields",
            "title" => "Configured Fields",
            "width" => "20%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "action",
            "title" => "Action",
            "width" => "15%",
            "className" => "dt-center",
        ];

        $data["data"] = $column;
        $data["is_searching_enable"] = true;
        $data["is_paging_enable"] = true;
        $data["is_serverSide"] = true;
        $data["is_ordering"] = true;
        $data["is_heading_color"] = "#a18f72";
        $data["no_data_message"] = '<div class="p-3 no-data-found-block"><img class="p-2" src="' . base_url() . 'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Groups found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'asc']]);
        $data["page_length_arr"] = [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        
        $this->smarty->loadView('field_selection_list.tpl', $data, 'Yes', 'Yes');
    }

    /**
     * Get Field Selection List Data for DataTable
     */
    public function fieldSelectionListData() {
        $post_data = $this->input->post();
        $column_index = array_column($post_data["columns"], "data");
        
        $order_by = "";
        foreach ($post_data["order"] as $key => $val) {
            if ($key == 0) {
                $order_by .= $column_index[$val["column"]] . " " . $val["dir"];
            } else {
                $order_by .= "," . $column_index[$val["column"]] . " " . $val["dir"];
            }
        }
        
        $condition_arr["order_by"] = $order_by;
        $condition_arr["start"] = $post_data["start"];
        $condition_arr["length"] = $post_data["length"];
        
        $data = $this->Configration_model->getAllGroups($condition_arr, $post_data["search"]);
        
        foreach ($data as $key => $val) {
            // Get configured fields count
            $field_config = $this->Configration_model->getGroupFieldConfig($val['group_master_id']);
            $configured_count = 0;
            
            if ($field_config && !empty($field_config['selected_fields'])) {
                $selected_fields = json_decode($field_config['selected_fields'], true);
                $configured_count = is_array($selected_fields) ? count($selected_fields) : 0;
            }
            
            $data[$key]['configured_fields'] = $configured_count > 0 ? 
                '<span class="badge bg-success">' . $configured_count . ' Fields</span>' : 
                '<span class="badge bg-secondary">Not Configured</span>';
            
            $data[$key]['status'] = $val['status'] == 'Active' ? 
                '<span class="badge bg-success">Active</span>' : 
                '<span class="badge bg-secondary">Inactive</span>';
            
            // Action buttons
            $data[$key]['action'] = '';
            if (checkGroupAccess("field_selection_list", "update", "No")) {
                $data[$key]['action'] .= '<a href="' . base_url('configure_group_fields/' . $val['group_master_id']) . '" class="btn btn-sm btn-primary" title="Configure Fields">
                    <i class="ti ti-settings me-1" style="color: #fdfeff !important;"></i> Configure
                </a>';
            }
        }
        
        $total_record = $this->Configration_model->getAllGroupsCount([], $post_data["search"]);
        $data["data"] = $data;
        $data["recordsTotal"] = $total_record['total_record'];
        $data["recordsFiltered"] = $total_record['total_record'];
        
        echo json_encode($data);
        exit();
    }

    /**
     * Configure Group Fields Page
     */
    public function configureGroupFields() {
        $group_id = $this->uri->segment(2);
        
        if (!$group_id) {
            redirect('field_selection_list');
        }
        
        checkGroupAccess("field_selection_list", "update", "Yes");
        
        // Get group details
        $group_data = $this->Configration_model->getGroupById($group_id);
        if (!$group_data) {
            redirect('field_selection_list');
        }
        
        // Get all form fields
        $all_fields = $this->Configration_model->getAllFormFields();
        
        // Get current configuration
        $field_config = $this->Configration_model->getGroupFieldConfig($group_id);
        $selected_field_ids = [];
        
        if ($field_config && !empty($field_config['selected_fields'])) {
            $selected_field_ids = json_decode($field_config['selected_fields'], true);
            if (!is_array($selected_field_ids)) {
                $selected_field_ids = [];
            }
        }
        
        $data['group'] = $group_data;
        $data['all_fields'] = $all_fields;
        $data['selected_field_ids'] = $selected_field_ids;
        $data['base_url'] = base_url();
        
        $this->smarty->loadView('configure_group_fields.tpl', $data, 'Yes', 'Yes');
    }

    /**
     * Save Group Field Configuration
     */
    public function saveGroupFieldConfig() {
        $post_data = $this->input->post();
        $group_id = $post_data['group_master_id'];
        $selected_fields = isset($post_data['selected_fields']) ? $post_data['selected_fields'] : [];
        
        // Convert to JSON
        $selected_fields_json = json_encode($selected_fields);
        
        $save_data = [
            'group_master_id' => $group_id,
            'selected_fields' => $selected_fields_json
        ];
        
        try {
            $result = $this->Configration_model->saveGroupFieldConfig($save_data);
            
            if ($result) {
                $ret_arr['success'] = 1;
                $ret_arr['messages'] = "Field configuration saved successfully.";
            } else {
                // Get database error
                $db_error = $this->db->error();
                $ret_arr['success'] = 0;
                $ret_arr['messages'] = "Error saving field configuration.";
                $ret_arr['db_error'] = $db_error; // For debugging
                
                // Log the error
                log_message('error', 'Field config save failed: ' . print_r($db_error, true));
            }
        } catch (Exception $e) {
            $ret_arr['success'] = 0;
            $ret_arr['messages'] = "Exception: " . $e->getMessage();
            log_message('error', 'Field config exception: ' . $e->getMessage());
        }
        
        echo json_encode($ret_arr);
        exit();
    }

    /**
     * Get Group Field Configuration
     */
    public function getGroupFieldConfig() {
        $post_data = $this->input->post();
        $group_id = $post_data['group_id'];
        
        $field_config = $this->Configration_model->getGroupFieldConfig($group_id);
        
        if ($field_config) {
            $ret_arr['success'] = 1;
            $ret_arr['data'] = $field_config;
            $ret_arr['selected_fields'] = json_decode($field_config['selected_fields'], true);
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['messages'] = "No configuration found.";
            $ret_arr['selected_fields'] = [];
        }
        
        echo json_encode($ret_arr);
        exit();
    }
}