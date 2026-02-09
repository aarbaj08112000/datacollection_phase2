<?php
defined('BASEPATH') or exit('No direct script access allowed');

#------------ Login -----------------------------
$route['default_controller'] = 'LogonDashboard/login';
$route['404_override'] = 'user/user/page_not_found';
$route['page_not_found'] = 'user/user/page_not_found_view';
// $route['login'] = 'LogonDashboard/login';
/* login & forgot password */
$route['login'] = 'user/login/index';
$route['forgot_password/(:any)/(:any)'] = 'user/login/forgot_password/$1/$2';
$route['logout'] = 'user/login/logout';

/* admin */
$route['sitemap'] = 'user/login/site_map';
$route['dashboard'] = 'user/login/dashboard';
$route['user_list'] = 'user/user/user_list';
$route['group_master'] = 'user/user/groupMaster';
$route['group_menu'] = 'user/user/groupMenu';


$route['form_listing'] = 'user/form/formListing';
$route['trash_form_listing'] = 'user/form/formListing';
$route['form_listing_data'] = 'user/form/formListingData';
$route['form_field_listing'] = 'user/form/formFieldListing';
$route['form_field_listing_data'] = 'user/form/formFieldListingData';
$route['form_creation'] = 'user/form/form_creation';
$route['form_creation_edit/(:any)'] = 'user/form/form_creation_edit';
$route['data_collection_list/(:any)'] = 'user/form/dataCollectionList';
$route['data_collection_image_list/(:any)'] = 'user/form/dataCollectionList';
$route['download_images/(:any)'] = 'user/form/download_images';
$route['download_all_images/(:any)'] = 'user/form/download_all_images';
$route['download_all_ids/(:any)'] = 'user/form/download_all_ids';
$route['download_all_ids/(:any)/(:any)'] = 'user/form/download_all_ids';
$route['preview_id_card/(:any)/(:any)'] = 'user/form/preview_id_card';
$route['url'] = 'user/form/url';
$route['url/(:any)'] = 'user/form/url/$1';


$route['form/(:any)'] = 'user/form/form';
$route['form_data_edit'] = 'user/form/form_data_edit';
$route['form_image_data_edit'] = 'user/form/form_image_data_edit';
$route['submit_form'] = 'user/form/submit_form';
$route['submit_edit_form'] = 'user/form/submit_edit_form';
$route['submit_edit_image_form'] = 'user/form/submit_edit_image_form';
$route['pdf'] = 'user/form/generatePdf';


$route['export_form_data/(:any)'] = 'user/form/export_form_data';
$route['idcard/designer/(:num)'] = 'user/form/designer/$1';
$route['idcard/save'] = 'user/form/save';



