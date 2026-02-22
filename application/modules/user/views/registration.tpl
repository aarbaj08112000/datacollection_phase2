<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <meta charset="utf-8" />
      <base href="<%$base_url%>" />
      <title><%$config['company_name']%></title>
      <!-- Favicon -->
      <link rel="icon" type="image/x-icon" href="<%base_url()%><%$config['company_fav_icon']%>" />
      <!-- Fonts -->
      <link rel="shortcut icon" href="https://cdnjs.cloudflare.com/ajax/libs/line-awesome/1.3.0/line-awesome/css/line-awesome.min.css" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
      <meta http-equiv="content-type" content="text/html; charset=utf-8" />
      <meta http-equiv="cache-control" content="no-cache" />
      <meta http-equiv="pragma" content="no-cache" />
      <link rel="stylesheet" href="<%$base_url%>public/css/gilroy-fonts.css" />
      <link rel="stylesheet" href="<%$base_url%>public/css/tabler_css/tabler_icons.css">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
      <link rel="stylesheet" href="<%$base_url%>public/css/login/login_page.css">
      <!-- toaster -->
       <link rel="stylesheet" href="public/css/toaster/custom_toaster.css" />
        <link rel="stylesheet" href="public/css/fontawesome/font_awesome.css">
     <!-- toaster -->
   </head>
   <body data-new-gr-c-s-check-loaded="14.1208.0" data-gr-ext-installed="">
      <div class="main-wrap main-wrap--white main-loader-box" style="display: none;">
         <div class="loader-div"></div>
      </div>
      <div class="login-main-page custom-login-bg outer-div-box">
         <div class="errorbox-position" id="var_msg_cnt" style="display: none;">
            <div class="closebtn-errorbox" id="closebtn_errorbox">
               <a href="javascript://" onclick="Project.closeMessage();"><button class="close" type="button">×</button></a>
            </div>
            <div class="content-errorbox alert" id="err_msg_cnt"></div>
         </div>
         <div class="content-login" id="content_login">
            <div class="login_page">
               <style>
                  .top-bg {
                  display: none !important;
                  }
                  .error-msg{
                     color: red;
                  }
               </style>
               <div class="login_lt_panel">
                  <div class="d-flex h-100">
                     <div class="row justify-content-center align-self-center m-0 w-100">
                        <div class="loginContainer login-form">
                           <div class="loginbox-border">
                              <div>
                                 <div id="login_div">
                                    <div class="logo_login">
                                       <a href="<%$base_url%>" class="brand">
                                       <img
                                          alt="<%$config['company_name']%>"
                                          class="admin-logo-top"
                                          src="<%base_url()%><%$config['company_logo']%>"
                                          title="<%$config['company_name']%>"
                                          />
                                       </a>
                                    </div>
                                    <div class="login-headbg">
                                       <h2>Register in to <%$config['company_name']%></h2>
                                    </div>
                                    <form
                                       id="formAuthentication" class="mb-3" action="javascript:void(0)" method="POST"
                                       >
                                       <div class="step-first">
                                       <label for="mobile_number">User Type </label>
                                       <div width="28%" class="bmatter relative">
                                          <select name="user_role" class="form-control select2" id="user_type">
                                          <option value="ChannelPartner">Channel Partner</option>
                                          <option value="School">School</option>
                                          </select>
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="mobile_numberErr"></div>
                                       
                                       <label for="school_name"><span class="title-school">Channel Partner</span> Name </label>
                                       <div width="28%" class="bmatter relative">
                                          
                                          <input
                                             type="text"
                                             title="School Name"
                                             name="school_name"
                                             id="school_name"
                                             class="text login-user validation-feild"
                                             value=""
                                             placeholder="School Name"
                                             />
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="school_nameErr"></div>

                                       <label for="school_logo"><span class="title-school">Channel Partner</span> Logo </label>
                                       <div width="28%" class="bmatter relative">
                                          <input accept=".jpg,.jpeg,.png" type="file" class="form-control validation-feild" id="school_logo" name="school_logo">
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="school_logoErr"></div>

                                       <label for="school_address"><span class="title-school">Channel Partner</span> Address </label>
                                       <div width="28%" class="bmatter relative">
                                          <textarea type="text"
                                             title="School Address"
                                             name="school_address"
                                             id="school_address"
                                             class="text login-user validation-feild form-control" 
                                             value=""
                                             placeholder="School Address"></textarea>
                                          
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="school_addressErr"></div>

                                       <label for="school_contact_no"><span class="title-school">Channel Partner</span> Contact No. </label>
                                       <div width="28%" class="bmatter relative">
                                          
                                          <input
                                             type="text"
                                             title="School Contact No."
                                             name="school_contact_no"
                                             id="school_contact_no"
                                             class="text login-user validation-feild"
                                             value=""
                                             placeholder="School Contact No."
                                             />
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="school_contact_noErr"></div>


                                       <label for="school_email"><span class="title-school">Channel Partner</span> Mail ID </label>
                                       <div width="28%" class="bmatter relative">
                                          
                                          <input
                                             type="text"
                                             title="School Mail ID"
                                             name="school_email"
                                             id="school_email"
                                             class="text login-user validation-feild"
                                             value=""
                                             placeholder="School Mail ID"
                                             />
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="school_emailErr"></div>

                                       </div>
                                       <div class="step-second " style="display: none;">
                                       <label for="contact_person_name">Contact Person Name </label>
                                       <div width="28%" class="bmatter relative">
                                          
                                          <input
                                             type="text"
                                             title="Contact Person Name"
                                             name="contact_person_name"
                                             id="contact_person_name"
                                             class="text login-user validation-feild"
                                             value=""
                                             placeholder="Contact Person Name"
                                             />
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="contact_person_nameErr"></div>

                                       <label for="contact_person_designation">Contact Person Designation </label>
                                       <div width="28%" class="bmatter relative">
                                         
                                          <input
                                             type="text"
                                             title="Contact Person Designation"
                                             name="contact_person_designation"
                                             id="contact_person_designation"
                                             class="text login-user validation-feild"
                                             value=""
                                             placeholder="Contact Person Designation"
                                             />
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="contact_person_designationErr"></div>

                                       <label for="contact_person_mobile">Contact Person Mobile </label>
                                       <div width="28%" class="bmatter relative">
                                          
                                          <input
                                             type="text"
                                             title="Contact Person Mobile"
                                             name="contact_person_mobile"
                                             id="contact_person_mobile"
                                             class="text login-user validation-feild"
                                             value=""
                                             placeholder="Contact Person Mobile"
                                             />
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="contact_person_mobileErr"></div>

                                       <label for="login_name">Email </label>
                                       <div width="28%" class="bmatter relative">
                                          
                                          <input
                                             type="text"
                                             title="Email"
                                             name="email"
                                             id="email"
                                             class="text login-user validation-feild"
                                             value=""
                                             placeholder="Email"
                                             />
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="emailErr"></div>
                                       <label for="passwd">Password </label>
                                       <div class="bmatter relative">
                                          
                                          <input
                                             type="password"
                                             title="Password"
                                             name="password"
                                             id="password"
                                             size="25"
                                             value=""
                                             class="validation-feild"
                                             placeholder="Password"
                                             />
                                       </div>
                                       <div class="clear"></div>
                                       <div class="error-msg login-error-msg" id="passwordErr"></div>
                                       
                                       </div>
                                       <div class="normal-login-type">
                                          <button type="button" class="btn btn-info login-btn step-first-submit" id="loginStep1Btn" >Next<span class="icon16 icomoon-icon-enter white right"></span></button>
                                          <div id="loginBtn" style="display: none;">
                                             <button type="button" class="btn btn-info login-btn step-second-submit float-start me-3" style="width: 48%;"  id="back_to_first">Back<span class="icon16 icomoon-icon-enter white right" ></span></button>
                                             <button type="button" class="btn btn-info login-btn step-second-submit float-start " id="loginStep2Btn" style="width: 48%;"   >Submit<span class="icon16 icomoon-icon-enter white right" ></span></button>
                                          </div>
                                          
                                       </div>
                                       <div class="login-actions " >
                                          <div class="login-remember-me left hide">
                                             <input
                                                class="remember-me-check regular-checkbox"
                                                type="checkbox"
                                                value="Yes"
                                                name="remember_me"
                                                id="remember_me"
                                                />
                                             <!-- <label for="remember_me">&nbsp;</label> -->
                                             <label class="remember-me-label ps-0" for="remember_me">Remember me</label>
                                          </div>
                                          <div class="show-forgot-pwd right">
                                             <a href="login" >Back To Login?</a>
                                          </div>
                                       </div>
                                       
                                    </form>
                                 </div>
                                

                                <div id="otp_div" class="forgot-pwd" style="display: none;">
                                    <div class="logo_login">
                                        <a href="<%$base_url%>" class="brand">
                                            <img alt="<%$config['company_name']%>" class="admin-logo-top" src="<%base_url()%><%$config['company_logo']%>" title="<%$config['company_name']%>">
                                        </a>
                                    </div>
                                    <div class="login-headbg">
                                        <h2>OTP
                                            <span>Please enter the OTP to registration in your account.</span>
                                        </h2>
                                    </div>
                                    <div width="28%" class="relative">
                                        <form
                                       id="formotp" class="mb-3" action="javascript:void(0)" method="POST"
                                       >
                                          <label for="username">OTP</label>
                                          <div class="bmatter relative">
                                              
                                              <input type="text" placeholder="Enter Otp" name="otp" id="otp" class="text login-forgot forgot-valid" value="" size="25" >
                                              <input type="hidden"  name="user_id" id="user_id"  >
                                              <div class="error-msg login-error-msg mt-3" id="usernameErr"></div>
                                          </div>
                                          <div class="forgot-pwd-btns normal-login-type">
                                               <button type="submit" class="btn btn-info login-btn" id="loginBtn" >Submit<span class="icon16 icomoon-icon-enter white right"></span></button>
                                              <span id="loader_img" class="forgot-loader-img right" style="display: none;"><i class="fa fa-refresh fa-spin-light fa-2x fa-fw"></i></span>
                                          </div>
                                        </form>
                                        <div class="forgot-backlink">
                                        <button id="resendOtpBtn" style="color: #206dff; background-color:transparent">Resend Otp <span id="timer-count"></span></button>
                                         
                                                                                    </div>
                                    </div>
                                </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="login_rt_panel">
                  <div class="lt_panel_img"><img src="<%$base_url%>public/assets/images/login_page_img2.png" /></div>
               </div>
            </div>
         </div>
      </div>
      <div class="login-bottom-page">
         <div>
            <div class="copyright" id="bot_copyright">
               <i class="las la-plus bottom-icons hide-icons" id="additional_btn"></i>
               Copyright 2024 © Audit System. All Rights Reserved
            </div>
         </div>
      </div>
   </body>
   <style>
   .loginContainer {
      top: 42px !important;
   }
   .login_page .login-form input[type="text"], .login_page .login-form input[type="password"] {
      background: #F3F3F3;
      height: 37px !important;
      border-radius: 6px !important;
      border: 0 !important;
      line-height: 50px !important;
   }
   .error-msg.login-error-msg div.error{
      margin-bottom: 6px !important;
   }
   .login-form #school_logo {
      box-shadow: none;
      height: auto;
      padding: 5px 3px 5px 5px;
         width: 100% !important;
      font-size: 15px;
      font-family: "gilroymedium" !important;
   }
   .login-headbg h2 span {
      padding-right: 0px !important;
      font-family: "gilroymedium" !important;
   }
   .disable-timer {
      color: #aeb7c7 !important;
   }
   </style>
   <!-- Core JS -->
  <!-- build:js assets/vendor/js/core.js -->
  <script src="<%$base_url%>public/js/admin/plugin/jquery.min.js"></script>
  <script src="<%$base_url%>public/assets/vendor/libs/popper/popper.js"></script>
  <script src="<%$base_url%>public/assets/vendor/js/bootstrap.js"></script>
  <script src="<%$base_url%>public/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

  <!-- endbuild -->

  <!-- Vendors JS -->

  <!-- Main JS -->
<link rel="stylesheet" href="<%$base_url%>public/plugin/select2/select2.min.css">
  <script  src="<%$base_url%>public/plugin/select2/select2.min.js"></script>
  <link rel="stylesheet" href="<%$base_url%>plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js" integrity="sha512-WMEKGZ7L5LWgaPeJtw9MBM4i5w5OSBlSjTjCtSnvFJGSVD26gE5+Td12qN5pvWXhuWaWcVwF++F7aqu9cvqP0A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
 <script src="public/js/toaster/custom_toaster.js"></script>
<script src="<%$base_url%>public/js/registration.js"></script>
</html>