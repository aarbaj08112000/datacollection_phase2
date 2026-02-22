
    <!-- Include jQuery UI for Autocomplete -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- Include Tokenfield JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-tokenfield/dist/bootstrap-tokenfield.min.js"></script>
    <style>
        .tokenfield {
            width: 100%;
        }

        .tokenfield .token {
            margin: 2px;
        }

        .tokenfield .token span {
            padding: 5px;
        }

        /* Customizing the Autocomplete Dropdown */
        .ui-menu {
            background-color: #ffffff;
            /*border: 1px solid #ddd;*/
            border-radius: 4px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-height: 200px;
            overflow-y: auto;
            z-index: 9999;
            font-size: 14px;
        }

        .ui-menu .ui-menu-item {
            padding: 10px;
            cursor: pointer;
        }
        .ui-menu-item-wrapper {
          border: none !important;
        }

        .ui-menu .ui-menu-item:hover {
            background-color: #007bff;
            color: white;
            border: none;
        }

        .ui-menu .ui-state-focus {
            background-color: #007bff;
            color: white;
        }

        /* Ensure proper spacing and style for selected tokens */
        .tokenfield .token .close {
            color: #e63946;
            font-weight: bold;
            cursor: pointer;
        }

        /* Adjust the input field when autocomplete is active */
        .ui-autocomplete-input {
            padding-right: 25px;
        }
        .ui-autocomplete-input {
          border: none;
        }
        .token 
        {
          float: left;
          border-color: #b9b9b9 !important;
          -webkit-box-sizing: border-box;
          -moz-box-sizing: border-box;
          box-sizing: border-box;
          -webkit-border-radius: 3px;
          -moz-border-radius: 3px;
          border-radius: 3px;
          display: inline-block;
          border: 1px solid #d9d9d9;
          background-color: #ededed;
          white-space: nowrap;
          margin: -1px 5px 5px 0;
          height: 22px;
          vertical-align: top;
          cursor: default;
          padding-right: 4px;
      }
    </style>
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
 

    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Data Management
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Issue Request Listing" >
            <i class="ti ti-chevrons-right" ></i>
            <em >College/School Master</em></a>
          </h1>
          <br>
          <span >Add Information</span>
        </div>
      </nav>
<div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
         <a href="<%base_url('form_listing')%>"  class="btn btn-seconday" title="Back To College/School Master Listing">
       <i class="ti ti-arrow-left"></i>
        </a>

       

      </div>
      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
        <%* <button class="btn btn-seconday" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv"></i></button>
        <button class="btn btn-seconday" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf"></i></button>
        <button class="btn btn-seconday filter-icon" type="button"><i class="ti ti-filter" ></i></i></button>
        <button class="btn btn-seconday" type="button"><i class="ti ti-refresh reset-filter"></i></button> *%>
        
       <!-- <button type="button" class="btn btn-seconday" data-bs-toggle="modal" data-bs-target="#addPromo" title="Add process">
       <i class="ti ti-plus"></i>
        </button> -->
       

      </div>
     

      <!-- Main content -->
      <div class="card p-0 mt-4 w-100">
        <div class="p-3">

        <form class="container mt-4" id="create_form">
        <div class="row">
          <div class="col-md-4 <%if $user_role eq 'School'%>hide<%/if%>">
            <label for="name" class="form-label fs-6">School/Collage/Office Name<span class="text-danger ms-1">*</span></label>
            <input type="text" class="form-control" id="school_name" placeholder="Enter your name" name="name" value="<%$school_data['school_name']%>">
          </div>
          <div class="col-md-4 <%if $user_role eq 'School'%>hide<%/if%>">
            <label for="image" class="form-label fs-6">Upload School/Collage/Office Logo<span class="text-danger ms-1">*</span></label>
            <input type="file" class="form-control" id="image" name="image">
          </div>
          <div class="col-md-4 hide">
            <label for="url" class="form-label fs-6">URL<span class="text-danger ms-1">*</span></label>
            <input type="text" class="form-control" id="url" placeholder="Enter your website" name="url" value="<%$url%>">
          </div>
          <div class="col-md-4 mt-3 <%if $user_role eq 'School'%>hide<%/if%>">
            <div class="radio-box">
            <label for="url" class="form-label fs-6">Type<span class="text-danger ms-1">*</span></label>
            <br>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="form_heder_type"  value="school"  <%if $user_role eq 'School'%>checked<%/if%>>
              <label class="form-check-label" for="inlineRadio2">School</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="form_heder_type"  value="collage">
              <label class="form-check-label" for="inlineRadio1">Collage</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="form_heder_type"  value="office" >
              <label class="form-check-label" for="inlineRadio1">Office</label>
            </div>
            </div>
          </div>
          <div class="col-md-4 mt-3 <%if $user_role eq 'School'%>hide<%/if%> ">
            <label for="url" class="form-label fs-6">Contact Person<span class="text-danger ms-1">*</span></label>
            <input type="text" class="form-control"  placeholder="Enter contact person" name="contact_person" value="<%$contact_person%>">
          </div>
          <div class="col-md-4 mt-3 <%if $user_role eq 'School'%>hide<%/if%>">
            <label for="url" class="form-label fs-6">Mobile Number<span class="text-danger ms-1">*</span></label>
            <input type="text" class="form-control onlyNumericInput"  placeholder="Enter mobile number" name="mobile_number" value="<%$mobile_number%>">
          </div>
          <div class="col-md-4 mt-3 <%if $user_role eq 'School'%>hide<%/if%>">
            <label for="url" class="form-label fs-6">Designation<span class="text-danger ms-1">*</span></label>
            <input type="text" class="form-control"  placeholder="Enter designation" name="designation" value="<%$school_data['contact_person_designation']%>">
          </div>
          <div class="col-md-4 mt-3 hide">
            <label for="url" class="form-label fs-6">Display Template<span class="text-danger ms-1">*</span></label>
            <input type="file" class="form-control"  placeholder="Enter designation" name="template">
          </div>
          <div class="col-md-4 mt-3 <%if $user_role eq 'School'%>hide<%/if%>">
            <div class="autocomplete-box">
              <label for="url" class="form-label fs-6">Address<span class="text-danger ms-1"></span></label>
              <textarea name="address" class="form-control textarea" id="the-textarea" maxlength="300" placeholder="Enter Address"autofocus><%$school_data['school_address']%></textarea>
              <div id="the-count" style="
              float: right;
              margin-top: 7px;
          ">
                <span id="current"><%strlen($school_data['school_address'])%></span>
                <span id="maximum">/ 300</span>
              </div>
            </div>
          </div>
          <div class="col-md-4 mt-3 ">
          <div class="autocomplete-box">
            <label for="url" class="form-label fs-6">Comment<span class="text-danger ms-1"></span></label>
            <textarea name="comment" class="form-control textarea1"  maxlength="1000" placeholder="Enter Address"autofocus><%$school_data['comment']%></textarea>
            <div id="the-count1" style="
            float: right;
            margin-top: 7px;
        ">
              <span id="current1"><%strlen($school_data['comment'])%></span>
              <span id="maximum1">/ 1000</span>
            </div>
          </div>
        </div>
          <div class="col-md-4 mt-3 course-row-box">
            <div class="autocomplete-box">
            <label for="url" class="form-label fs-6">Course<span class="text-danger ms-1">*</span></label>
            <input id="courseToken" type="text" class="form-control autocomplete" placeholder="Select course" name="course" />
            </div>
          </div>
          <div class="col-md-4 mt-3 section-box">
            <div class="autocomplete-box">
            <label for="url" class="form-label fs-6">Section<span class="text-danger ms-1">*</span></label>
            <input id="sectionToken" type="text" class="form-control autocomplete" placeholder="Select section" name="section" />
            </div>
          </div>
          <div class="col-md-4 mt-3 section-box">
            <div class="autocomplete-box">
            <label for="url" class="form-label fs-6">House<span class="text-danger ms-1"></span></label>
            <input id="houseToken" type="text" class="form-control autocomplete" placeholder="Select house" name="house" />
            </div>
          </div>
          <div class="col-md-4 mt-3 <%if $user_role eq 'ChannelPartner' || $user_role eq 'School'%>hide<%/if%>">
            <div class="autocomplete-box">
            <label for="url" class="form-label fs-6">Channel Patner<span class="text-danger ms-1"></span></label><br>
            <div>
            <select class=" select2 w-50"  name="channel_patner_id">
                <option value="">Select Channel Patner</option>
                <%foreach from=$channel_patner key=key item="values"%>
                  <option value="<%$values['id']%>" <%if $user_id eq $values['id']%>selected<%/if%>><%$values['user_name']%></option>
                <%/foreach%>
            </select>
            </div>
            </div>
          </div>
        </div>
      
        <div class="row mt-3">
        <div class="col-md-12">
          <label class="form-label fs-6">Select the form fields:<span class="text-danger ms-1">*</span></label>
          <div class="d-flex flex-wrap gap-3 " id="sortable">
            <%foreach from=$field_data key=key item='feild'%>
            <div class="form-check border ui-state-default position-relative" style="width: 24%;    cursor: move;">
              <div class="m-2">
                <input type="checkbox" class="form-check-input required-check" >
                <input type="checkbox" class="form-check-input added-check" id="<%$feild['form_field_master_id']%>" value="<%$feild['form_field_master_id']%>">
                <label class="form-check-label" for="<%$feild['form_field_master_id']%>"><%$feild['form_title']%></label><br>
              </div>
            </div>
            <%/foreach%>
          </div>
        </div>
      </div>
      
      
        <div class="mt-3">
          <button type="submit" class="btn btn-primary">Submit</button>
        </div>
      </form>
         
        </div>
        <!--/ Responsive Table -->
      </div>
      <!-- /.col -->
    
      <div class="modal fade" id="deleteImg" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog  modal-dialog-centered  modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title w-100" id="exampleModalLabel">
                Paymnet QR
              </h5>
            </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="form-group col-12">
                           <h5>For approval of the created link, please make the payment using the QR below. After completing the payment, please send the payment screenshot on WhatsApp to <%$whats_app_number%>.</h5> 
                        </div>
                        <div class="text-center">
                            <img src="<%$payment_qr%>"  style="width: 406px;"/>
                        </div>
                     </div>
                  </div>
                  <div class="modal-footer">
         <button type="button" class="btn btn-primary payment-conform">Done</button>
         </div>
            </div>
         </div>
      </div>
      <div class="content-backdrop fade"></div>
    </div>

    <style type="text/css">
      input.required-check:checked {
          border-color: #0d6efd !important;
          background-color: #fc0d0d !important;
      }
      .required-check{
          position: absolute;
          top: -13px;
          right: -7px;
          width: 22px;
          height: 22px;
      }
      .select2-container {
          width: 298px !important;
          margin: auto;
          margin-top: 0px !important;
      }
      .select2-container .selection{
         width: 298px !important;
         display: block;
      }
    </style>
    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>;
    $('.textarea').keyup(function() {
    
  var characterCount = $(this).val().length,
      current = $('#current'),
      maximum = $('#maximum'),
      theCount = $('#the-count');
    
  current.text(characterCount);
 
  
  /*This isn't entirely necessary, just playin around*/
  if (characterCount < 70) {
    current.css('color', '#666');
  }
  if (characterCount > 70 && characterCount < 90) {
    current.css('color', '#6d5555');
  }
  if (characterCount > 90 && characterCount < 100) {
    current.css('color', '#793535');
  }
  if (characterCount > 100 && characterCount < 120) {
    current.css('color', '#841c1c');
  }
  if (characterCount > 120 && characterCount < 139) {
    current.css('color', '#8f0001');
  }
  
  if (characterCount >= 140) {
    maximum.css('color', '#8f0001');
    current.css('color', '#8f0001');
    theCount.css('font-weight','bold');
  } else {
    maximum.css('color','#666');
    theCount.css('font-weight','normal');
  }
  
      
});
$('.textarea1').keyup(function() {
  var characterCount = $(this).val().length,
      current = $('#current1'),
      maximum = $('#current1'),
      theCount = $('#the-count1');
    
  current.text(characterCount);
 
  
  /*This isn't entirely necessary, just playin around*/
  if (characterCount < 70) {
    current.css('color', '#666');
  }
  if (characterCount > 70 && characterCount < 90) {
    current.css('color', '#6d5555');
  }
  if (characterCount > 90 && characterCount < 100) {
    current.css('color', '#793535');
  }
  if (characterCount > 100 && characterCount < 120) {
    current.css('color', '#841c1c');
  }
  if (characterCount > 120 && characterCount < 139) {
    current.css('color', '#8f0001');
  }
  
  if (characterCount >= 140) {
    maximum.css('color', '#8f0001');
    current.css('color', '#8f0001');
    theCount.css('font-weight','bold');
  } else {
    maximum.css('color','#666');
    theCount.css('font-weight','normal');
  }
  
      
});
    </script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="<%$base_url%>public/js/form_master/form_creation.js"></script>
