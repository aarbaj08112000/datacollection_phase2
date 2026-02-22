<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

<script src="dist/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<link rel="stylesheet" href="dist/css/dashboard/style.min.css">
<!-- highchart js -->

<!-- highchart css -->
<link rel="stylesheet" type="text/css" href="dist/css/dashboard/highchart/highchart.css">
<link rel="stylesheet" type="text/css" href="dist/css/dashboard/loader.css">


<div class="wrapper">
<!-- Navbar -->
<!-- /.navbar -->
<!-- Main Sidebar Container -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper" style="min-height: 1002.5px;">
<!-- Main content -->
<section class="content dashboard-block">
   <div class="nav-bar-header">
      <div class="header-contain-div scrollable-block">
         <div class="d-flex dashboard-header">
            <div class="w-50 main-title-block">
               <h2 class="main-title">
                  Dashboard
               </h2>
            </div>
            <div class="w-50 drop-down-block ">
               <div class="year-drop-down float-right">
                  <select class="select-box"  id="year-filer">
                     <%foreach from=$year  key=key item=$value %>
                     <option value="<%$value['id'] %>"><%$value['val'] %></option>
                     <%/foreach%> 
                  </select>
               </div>
               <div class="year-drop-down unit-drop-down float-right margin-right-2 <%if $isMultipleClientUnits != "true" %>hide<%/if %>">
                  <select class="select-box"  id="company-unit-filer">
                     <option value="All">All</option>
                     <%foreach from=$unit_data  key=key item=$value %>
                     <option value="<%$value['id'] %>" <%if ($selected_unit == $value['id']) %>selected <%/if%>><%$value['val'] %></option>
                     <%/foreach%>                    
                  </select>
               </div>
               <div class="refresh-btn-box float-right margin-right-2">
                  <button class="progress-button action-btn mr-3" data-style="fill" data-horizontal="" id="refresh-btn">
                     <span class="content">Refresh</span>
                     <div class="progress-bar-wrapper">
                        <div class="progress-bar"></div>
                     </div>
                  </button>
               </div>
            </div>
         </div>
         <ul class="nav nav-tabs dashboard-nav-tab" id="myTab" role="tablist">
            <%if checkGroupAccess("overall_detail_tab","list",false)%>
            <li class="nav-item" role="presentation">
               <a class="nav-link <%if $selected_menu eq 'overall_detail_tab'%>active<%/if%>" id="overview-details-tab" data-bs-toggle="tab" data-tab="OverViewDetails" data-bs-target="#overview-details" type="button" role="tab" aria-controls="overview-details" aria-selected="true">Overall Detail</a>
            </li>
            <%/if%>
            <%if checkGroupAccess("channel_patner_tab","list",false)%>
            <li class="nav-item  " role="presentation">
               <a class="nav-link <%if $selected_menu eq 'channel_patner_tab'%>active<%/if%>" id="channel-patner-tab" data-bs-toggle="tab" data-tab="ChannelPatnerDetails" data-bs-target="#channel-patner" type="button" role="tab" aria-controls="channel-patner" aria-selected="true">Channel Patner</a>
            </li>
            <%/if%>
            <%if checkGroupAccess("school_tab","list",false)%>
            <li class="nav-item  " role="presentation">
               <a class="nav-link <%if $selected_menu eq 'school_tab'%>active<%/if%>" id="school-tab" data-bs-toggle="tab" data-tab="SchoolDetails" data-bs-target="#school" type="button" role="tab" aria-controls="school" aria-selected="true">School</a>
            </li>
            <%/if%>
         </ul>
      </div>
   </div>
   <div class="container-fluid">
      <div class="flex-grow-1 container-p-y container-fluid">
         <main class="main users chart-page" id="skip-target">
            <div class="container main-container-block">
               <div class="tab-content" id="myTabContent">
                  <%if checkGroupAccess("overall_detail_tab","list",false)%>
                  <div class="tab-pane fade  <%if $selected_menu eq 'overall_detail_tab'%>show active<%/if%>show active" id="overview-details" role="tabpanel" aria-labelledby="overview-details-tab" data-tab="OverViewDetails">
                     <div class="row stat-cards">
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="TODAY_USER_BLOCK" data-widget="TODAY_USER">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/user_list")%>" class="redirect-dashboard">
                                 <div class="stat-cards-icon primary">
                                    <i class="las la-user"></i>
                                 </div>
                                 <div class="stat-cards-info" >
                                    <p class="stat-cards-info__title" >Total User</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="TOTAL_EMPLOYEE_BLOCK" data-widget="TOTAL_EMPLOYEE">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/user_list?type=employee") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon warning">
                                    <i class="las la-user-tie"></i>
                                 </div>
                                 <div class="stat-cards-info">
                                    <p class="stat-cards-info__title" >Total Employee</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="TOTAL_CHANNEL_PATNER_BLOCK" data-widget="TOTAL_CHANNEL_PATNER">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/user_list?type=channel_patner") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon warning">
                                    <i class="las la-handshake"></i>
                                 </div>
                                 <div class="stat-cards-info">
                                    <p class="stat-cards-info__title" >Total Channel Patner</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="TOTAL_SCHOOL_BLOCK" data-widget="TOTAL_SCHOOL">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/user_list?type=school") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon success">
                                    <i class="las la-school"></i>
                                 </div>
                                 <div class="stat-cards-info" >
                                    <p class="stat-cards-info__title" >Total School</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                     </div>
                     <div class="row stat-cards">
                        <div class="col-md-6 col-xl-3  ">
                           <article class="stat-cards-item widget-box" id="TODAY_GENERATED_LINK_BLOCK" data-widget="TODAY_GENERATED_LINK">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon success">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info">
                                    <p class="stat-cards-info__title">Today’s Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="YESTERDAY_GENERATED_LINK_BLOCK" data-widget="YESTERDAY_GENERATED_LINK">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box hide">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon warning">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info">
                                    <p class="stat-cards-info__title">Yesterday’s Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number " data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="CURRENT_MONTH_GENERATED_LINK_BLOCK" data-widget="CURRENT_MONTH_GENERATED_LINK">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box hide">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon primary">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info" >
                                    <p class="stat-cards-info__title" >Current Month Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="CURRENT_YEAR_GENERATED_LINK_BLOCK" data-widget="CURRENT_YEAR_GENERATED_LINK">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box hide">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon primary">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info" >
                                    <p class="stat-cards-info__title" >Current Year Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        

                     </div>

                     <div class="row mt-2">
                        <div class="col-md-12 mt-3">
                           <div class="row header-contain-div pe-0 pt-0" >
                              <div class="col-md-8 mt-3">
                              </div>
                              <div class="col-md-2 mt-3 dashboard-header">
                                 <div class="refresh-btn-box float-right mt-1">
                                    <a href="<%base_url('form_creation')%>" style="top: -2px;height: 37px; gap:7px;    padding: 0px 14px !important;   display: flex;" class="progress-button action-btn mr-3 flex" data-style="fill" data-horizontal="" id="refresh-btn">
                                       <i class="ti ti-square-plus" style="font-size: 24px;margin-top: 7px;"></i><span class="content" style="font-size: 16px;line-height: 2.2;"> Generate Link</span>
                                    </a>
                                 </div>
                              </div>
                              <div class="col-md-2 mt-3">
                                 <input class="form-control overall-school" style="width: 100%;float:left;" placeholder="Search here">
                              </div>
                           </div>
                           
                        </div>
                        <%assign var="borderColors" value=["red", "blue", "green", "orange"] %>
                        <%foreach from=$colleges item=college name=loop %>
                           <%assign var="borderColor" value=$borderColors[$smarty.foreach.loop.index % count($borderColors)] %>
                           <div class="col-md-3 mt-3 overall-box">
                           <a href="<%$base_url %>data_collection_list/<%$college.school_id %>">
                              <div class="card p-3 pb-2" style="border-bottom: 3px solid <%$borderColor %>; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
                                    <div class="d-flex align-items-center">
                                       <!-- College Logo (Left Side) -->
                                       <img src="<%$base_url %><%$college.image %>" alt="Logo" style="width: 40px; height: 40px; margin-right: 10px;">

                                       <!-- College Name (Right Side) -->
                                       <div class="mt-3">
                                       <h5 class="mb-0 school-title" style="flex-grow: 1;"><%$college.name %></h5>
                                       <h6 class="mb-0 channel-title"><%$college.channel_patner_name %></h6>
                                       </div>
                                    </div>
                                    <p style="display: flex; justify-content: space-between; margin-top: 15px;margin-bottom: 0px;">
                                       <span>Total Reponse:</span> 
                                       <span style="font-weight: bold; font-size: 20px; color: <%$borderColor %>;"><%$college.total_record %></span>
                                    </p>
                                    <p style="display: flex; justify-content: space-between; margin-top: 0px;margin-bottom: 0px;">
                                       <span>Today Reponse:</span> 
                                       <span style="font-weight: bold; font-size: 20px; color: <%$borderColor %>;"><%$college.today_response %></span>
                                    </p>
                              </div>
                              </a>
                           </div>
                           
                        <%/foreach %>
                     </div>
                  </div>
                  <%/if%>
                  <%if checkGroupAccess("channel_patner_tab","list",false)%>
                  <div class="tab-pane fade <%if $selected_menu eq 'channel_patner_tab'%>show active<%/if%>" id="channel-patner" role="tabpanel" aria-labelledby="channel-patner-tab" data-tab="ChannelPatnerDetails">
                     <div class="row stat-cards">
                        <div class="col-md-6 col-xl-3  ">
                           <article class="stat-cards-item widget-box" id="TODAY_GENERATED_LINK_CHANNEL_BLOCK" data-widget="TODAY_GENERATED_CHANNEL_LINK">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon success">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info">
                                    <p class="stat-cards-info__title">Today’s Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="YESTERDAY_GENERATED_LINK_CHANNEL_BLOCK" data-widget="YESTERDAY_GENERATED_LINK_CHANNEL">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box hide">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon warning">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info">
                                    <p class="stat-cards-info__title">Yesterday’s Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number " data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="CURRENT_MONTH_GENERATED_LINK_CHANNEL_BLOCK" data-widget="CURRENT_MONTH_GENERATED_LINK_CHANNEL">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box hide">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon primary">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info" >
                                    <p class="stat-cards-info__title" >Current Month Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="CURRENT_YEAR_GENERATED_LINK_CHANNEL_BLOCK" data-widget="CURRENT_YEAR_GENERATED_LINK_CHANNEL">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box hide">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon primary">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info" >
                                    <p class="stat-cards-info__title" >Current Year Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                     </div>
                     <div class="row mt-2">
                        <div class="col-md-12 mt-3">
                           <div class="row header-contain-div pe-0 pt-0" >
                              <div class="col-md-8 mt-3">
                              </div>
                              <div class="col-md-2 mt-3 dashboard-header">
                                 <div class="refresh-btn-box float-right mt-1">
                                    <a href="<%base_url('form_creation')%>" style="top: -2px;height: 37px; gap:7px;    padding: 0px 14px !important;   display: flex;" class="progress-button action-btn mr-3 flex" data-style="fill" data-horizontal="" id="refresh-btn">
                                       <i class="ti ti-square-plus" style="font-size: 24px;margin-top: 7px;"></i><span class="content" style="font-size: 16px;line-height: 2.2;"> Generate Link</span>
                                    </a>
                                 </div>
                              </div>
                              <div class="col-md-2 mt-3">
                                 <input class="form-control channel-patner-school" style="width: 100%;float:left;" placeholder="Search here">
                              </div>
                           </div>
                           
                        </div>
                        <%assign var="borderColors" value=["red", "blue", "green", "orange"] %>
                        <%foreach from=$channelPatnerData item=college name=loop %>
                           <%assign var="borderColor" value=$borderColors[$smarty.foreach.loop.index % count($borderColors)] %>
                           <div class="col-md-3 mt-3 channel-patner-box">
                           <a href="<%$base_url %>data_collection_list/<%$college.school_id %>">
                              <div class="card p-3 pb-2" style="border-bottom: 3px solid <%$borderColor %>; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
                                    <div class="d-flex align-items-center">
                                       <!-- College Logo (Left Side) -->
                                       <img src="<%$base_url %><%$college.image %>" alt="Logo" style="width: 40px; height: 40px; margin-right: 10px;">

                                       <!-- College Name (Right Side) -->
                                       <div class="mt-3">
                                       <h5 class="mb-0 school-title" style="flex-grow: 1;"><%$college.name %></h5>
                                       <h6 class="mb-0 channel-title"><%$college.channel_patner_name %></h6>
                                       </div>
                                    </div>
                                    <p style="display: flex; justify-content: space-between; margin-top: 15px;margin-bottom: 0px;">
                                       <span>Total Reponse:</span> 
                                       <span style="font-weight: bold; font-size: 20px; color: <%$borderColor %>;"><%$college.total_record %></span>
                                    </p>
                                    <p style="display: flex; justify-content: space-between; margin-top: 0px;margin-bottom: 0px;">
                                       <span>Today Reponse:</span> 
                                       <span style="font-weight: bold; font-size: 20px; color: <%$borderColor %>;"><%$college.today_response %></span>
                                    </p>
                              </div>
                              </a>
                           </div>
                           
                        <%/foreach %>
                     </div>
                  </div>
                  <%/if%>
                  <%if checkGroupAccess("school_tab","list",false)%>
                  <div class="tab-pane fade <%if $selected_menu eq 'school_tab'%>show active<%/if%>" id="school" role="tabpanel" aria-labelledby="school-tab" data-tab="SchoolDetails">
                     <div class="row stat-cards">
                        <div class="col-md-6 col-xl-3  ">
                           <article class="stat-cards-item widget-box" id="TODAY_GENERATED_LINK_SCHOOL_BLOCK" data-widget="TODAY_GENERATED_SCHOOL_LINK">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon success">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info">
                                    <p class="stat-cards-info__title">Today’s Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="YESTERDAY_GENERATED_LINK_SCHOOL_BLOCK" data-widget="YESTERDAY_GENERATED_LINK_SCHOOL">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box hide">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon warning">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info">
                                    <p class="stat-cards-info__title">Yesterday’s Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number " data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="CURRENT_MONTH_GENERATED_LINK_SCHOOL_BLOCK" data-widget="CURRENT_MONTH_GENERATED_LINK_SCHOOL">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box hide">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon primary">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info" >
                                    <p class="stat-cards-info__title" >Current Month Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                        <div class="col-md-6 col-xl-3">
                           <article class="stat-cards-item widget-box" id="CURRENT_YEAR_GENERATED_LINK_SCHOOL_BLOCK" data-widget="CURRENT_YEAR_GENERATED_LINK_SCHOOL">
                              <div class="refresh-btn-block ">
                                 <i class="las la-sync cursor" title="Refresh"></i>
                              </div>
                              <div class="loader-box hide">
                                 <div class="dot-elastic"></div>
                              </div>
                              <a href="<%base_url("/form_listing") %>" class="redirect-dashboard">
                                 <div class="stat-cards-icon primary">
                                    <i class="las la-history"></i>
                                 </div>
                                 <div class="stat-cards-info" >
                                    <p class="stat-cards-info__title" >Current Year Generated Link</p>
                                    <p class="stat-cards-info__num timer count-title count-number" data-to="" data-speed="1500"></p>
                                 </div>
                              </a>
                           </article>
                        </div>
                     </div>
                     <div class="row mt-2">
                        <div class="col-md-12 mt-3">
                           <div class="row header-contain-div pe-0 pt-0" >
                              <div class="col-md-8 mt-3">
                              </div>
                              <div class="col-md-2 mt-3 dashboard-header">
                                 <div class="refresh-btn-box float-right mt-1">
                                    <a href="<%base_url('form_creation')%>" style="top: -2px;height: 37px; gap:7px;    padding: 0px 14px !important;   display: flex;" class="progress-button action-btn mr-3 flex" data-style="fill" data-horizontal="" id="refresh-btn">
                                       <i class="ti ti-square-plus" style="font-size: 24px;margin-top: 7px;"></i><span class="content" style="font-size: 16px;line-height: 2.2;"> Generate Link</span>
                                    </a>
                                 </div>
                              </div>
                              <div class="col-md-2 mt-3">
                                 <input class="form-control search-school" style="width: 100%;float:left;" placeholder="Search here">
                              </div>
                           </div>
                           
                        </div>
                        <%assign var="borderColors" value=["red", "blue", "green", "orange"] %>
                        <%foreach from=$schoolData item=college name=loop %>
                           <%assign var="borderColor" value=$borderColors[$smarty.foreach.loop.index % count($borderColors)] %>
                           <div class="col-md-3 mt-3 school-box">
                           <a href="<%$base_url %>data_collection_list/<%$college.school_id %>">
                              <div class="card p-3 pb-2" style="border-bottom: 3px solid <%$borderColor %>; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
                                    <div class="d-flex align-items-center">
                                       <!-- College Logo (Left Side) -->
                                       <img src="<%$base_url %><%$college.image %>" alt="Logo" style="width: 40px; height: 40px; margin-right: 10px;">

                                       <!-- College Name (Right Side) -->
                                       <div class="mt-3">
                                       <h5 class="mb-0 school-title" style="flex-grow: 1;"><%$college.name %></h5>
                                       
                                       </div>
                                    </div>
                                    <p style="display: flex; justify-content: space-between; margin-top: 15px;margin-bottom: 0px;">
                                       <span>Total Reponse:</span> 
                                       <span style="font-weight: bold; font-size: 20px; color: <%$borderColor %>;"><%$college.total_record %></span>
                                    </p>
                                    <p style="display: flex; justify-content: space-between; margin-top: 0px;margin-bottom: 0px;">
                                       <span>Today Reponse:</span> 
                                       <span style="font-weight: bold; font-size: 20px; color: <%$borderColor %>;"><%$college.today_response %></span>
                                    </p>
                              </div>
                              </a>
                           </div>
                           
                        <%/foreach %>
                     </div>
                  </div>
                  <%/if%>
                  </div>
               </div>
         </main>
         </div>       
      </div>
      <!-- /.container-fluid -->
</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<!-- / Footer -->

<div class="content-backdrop fade"></div>
<style>
   .acm-tab .loader-box,.acm-tab  .refresh-btn-block {
      display: none !important;
   }
</style>

<script>
$(document).on("click", ".refresh-btn-block", function () {
    var widget = $(this).closest(".widget-box");   // get the parent widget box
    widget.find(".stat-cards-info__num").removeClass("hide");  // remove hide class
});

</script>
<script src="./dist/js/plugin/couter-animation/couter_animation.js"></script>
<script src="dist/js/dashboard/script.js"></script>