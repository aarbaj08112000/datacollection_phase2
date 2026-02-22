<style>
 tr.filters {
  display: none;
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
            <em ><%if $page_name eq 'data_collection_list'%>Form Data<%else%>Form Image Data<%/if%></em></a>
          </h1>
          <br>
          <span ><%$school_name%></span>
        </div>
      </nav>
      <%assign var=roles value=["ChannelPartner","Employee","School"]%>
      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
          <%if $images_available == "Yes" && !in_array($session_data['role'],$roles)%>
         <a class="btn btn-danger delete-imgs" type="button" title="Delete All Images"  href="javascript:void(0)">Delete All Images</a>
         <%/if%>
         <%if $page_name eq 'data_collection_list'%>
           <%if !in_array($session_data['role'],$roles) %>
         <a class="btn btn-seconday card-generated-row" type="button" title="Card Generated" href="javascript:void(0)">Card Generated</a>
         <%/if%>
        <a class="btn btn-seconday export-ids" type="button" title="Download All Id Cards" href="javascript:void(0)"><i class="ti ti-id-badge-2"></i></a>
         <%if $file_column_exist && $session_data['role'] neq 'Employee' && $images_available == "Yes"%> 
          <a class="btn btn-seconday export-images" type="button" title="Download All images" href="javascript:void(0)"><i class="ti ti-photo-down"></i></a> 
         <%/if%>
        <%if checkGroupAccess("data_collection_list","export","No") %>
         <!-- <button class="btn btn-seconday" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv"></i></button> -->
         <button class="btn btn-seconday" type="button" id="downloadEXCELBtn" title="Download Excel"><i class="ti ti-file-type-xls"></i></button>
          <button class="btn btn-seconday" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf"></i></button>
          <%/if%>
         <%/if%>
          <button type="button" class="btn btn-seconday refresh-filter"  title="Refresh">
            <i class="ti ti-refresh"></i>
         </button> 
          <button class="btn btn-seconday filter-icon" title="Filter" type="button"><i class="ti ti-filter" ></i></i></button>
        <a class="btn btn-seconday" type="button" title="Back To College/School Master Listing" href="<%base_url('form_listing')%>"><i class="ti ti-arrow-left"></i></a>
       
       

      </div>
      <div class="w-100">
            <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-3 me-0" id="serarch-filter-input" fdprocessedid="bxkoib">
        </div>

      <!-- Main content -->
      <div class="card p-0 mt-4 w-100">
        <div class="">

          <div class="table-responsive text-nowrap">
            <table id="form_data_listing" class="table display table-striped w-100">
         
            </table>
          </div>
        </div>
        <!--/ Responsive Table -->
      </div>
      <!-- /.col -->
      <div class="modal fade" id="deleteImg" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog  modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title w-100" id="exampleModalLabel">
                Import Customer Part Issue
              </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                  aria-label="Close" style="    margin-top: -4.25rem;">
                </button>
            </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="form-group col-12">
                           Are you sure want to delete all img?
                        </div>
                     </div>
                  </div>
                  <div class="modal-footer">
         <button type="button" class="btn btn-secondary"
            data-bs-dismiss="modal">Cancel</button>
         <button type="button" data-school-id="<%$school_id%>" class="btn btn-primary delete-all-img-conform">Delete</button>
         </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="addPromo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header h-0 border-0 p-0" style="height: 0px">
                  <button type="button" class="btn-close closePreview" data-bs-dismiss="modal" aria-label="Close">
                  </button>
               </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="form-group col-12">
                           <iframe src="" class="preview-id-card-pdf" style="
    width: 101%;
    height: 600px;
">
                             
                           </iframe>
                        </div>
                     </div>
                  </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="dataEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header h-0 border-0 p-0" style="height: 0px">
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                  </button>
               </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="col-12 main_data_form">
                          
                             
                           </iframe>
                        </div>
                     </div>
                  </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="dataImageEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog  modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header h-0 border-0 p-0" style="height: 0px">
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                  </button>
               </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="col-12 main_image_data_form">
                          
                             
                           </iframe>
                        </div>
                     </div>
                  </div>
            </div>
         </div>
      </div>

      <div class="modal fade" id="imagePrevie" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog  modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header h-0 border-0 p-0" style="height: 0px">
                  <button type="button" class="btn-close closePreview" data-bs-dismiss="modal" aria-label="Close">
                  </button>
               </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="form-group col-12 text-center">
                           <img src="" class="mt-5 original-image" style="
                           margin: auto;
                           width: 88%;
                           height: 90%;
                           max-width: 90%;
                           max-height: 95%;
                       ">
                       <img src="<%base_url('public/assets/images/user.png')%>" class="mt-5 no-image-date" style="
                           margin: auto;
                           width: 88%;
                           height: 90%;
                           max-width: 90%;
                           max-height: 95%;
                       ">
                        </div>
                     </div>
                  </div>
            </div>
         </div>
      </div>

      <input type="hidden" id="base_url" value="<%$base_url%>" />
      <div class="content-backdrop fade"></div>
    </div>

    <style type="text/css">
      html:not([dir=rtl]) .modal .btn-close {
    transform: translate(9px, 3px) !important;
}
/* .select2-container{
   width: 252px !important;
    margin: auto;
    margin-top: 15px;

} */
 .filters .hide_search input{
   display: none !important;
}

    </style>

    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>;
    var column_details =  <%$data|json_encode%>;
    var page_length_arr = <%$page_length_arr|json_encode%>;
    var is_searching_enable = <%$is_searching_enable|json_encode%>;
    var is_top_searching_enable =  <%$is_top_searching_enable|json_encode%>;
    var is_paging_enable =  <%$is_paging_enable|json_encode%>;
    var is_serverSide =  <%$is_serverSide|json_encode%>;
    var no_data_message =  <%$no_data_message|json_encode%>;
    var is_ordering =  <%$is_ordering|json_encode%>;
    var sorting_column = <%$sorting_column%>;
    var api_name =  <%$api_name|json_encode%>;
    var base_url = <%$base_url|json_encode%>;
    var order_acceptance_enable = <%$order_acceptance_enable|json_encode%>;
    var left_fix_column = <%$left_fix_column|json_encode%>;
    var school_id = <%$school_id|json_encode%>;
    var image_download_url = '<%base_url('download_all_images/')%><%$school_id%>';
    var id_download_url = '<%base_url('download_all_ids/')%><%$school_id%>';
    var url= '<%$url%>';
    var page_name = <%$page_name|@json_encode%>;
</script>

    
    <script src="<%$base_url%>public/js/form_master/data_collection_list.js"></script>
