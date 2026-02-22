<div class="content-wrapper">
  <!-- Content -->
  <div class="container-xxl flex-grow-1 container-p-y">

    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Configuration Management
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Configuration Listing">
            <i class="ti ti-chevrons-right"></i>
            <em>Configuration Settings</em>
          </a>
        </h1>
        <br>
        <span>Listing</span>
      </div>
    </nav>

    <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
      <%if checkGroupAccess("config_setting_list","add","No") %>
        <button type="button" class="btn btn-seconday" data-bs-toggle="modal" data-bs-target="#addConfigModal" title="Add Configuration">
          <i class="ti ti-plus"></i>
        </button>
      <%/if%>
      <button class="btn btn-seconday" type="button" id="downloadEXCELBtn" title="Download Excel"><i class="ti ti-file-type-xls"></i></button>
    </div>

    <div class="w-100">
      <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-3 me-0" id="serarch-filter-input" fdprocessedid="bxkoib">
    </div>

    <!-- Main content -->
    <div class="card p-0 mt-4 w-100">
      <div class="">
        <div class="table-responsive text-nowrap">
          <table id="config_setting_table" class="table table-striped display nowrap w-100"></table>
        </div>
      </div>
    </div>

    <!-- Add Configuration Modal -->
    <div class="modal fade" id="addConfigModal" tabindex="-1" role="dialog" aria-labelledby="addConfigModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addConfigModalLabel">Add Configuration Setting</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="javascript:void(0)" method="POST" enctype="multipart/form-data" id="addConfigForm">
            <div class="modal-body">
              <div class="form-group">
                <label for="add_name">Name<span class="text-danger">*</span></label>
                <input required type="text" name="name" placeholder="Enter Configuration Name" class="form-control" id="add_name">
              </div>
              <div class="form-group">
                <label for="add_title">Title<span class="text-danger">*</span></label>
                <input required type="text" name="title" placeholder="Enter Title" class="form-control" id="add_title">
              </div>
              <div class="form-group">
                <label for="add_type">Type<span class="text-danger">*</span></label>
                <select name="type" class="form-control select2" id="add_type" required>
                  <option value="input">Input</option>
                  <option value="check_box">Checkbox</option>
                  <option value="date">Date</option>
                  <option value="file">File</option>
                </select>
              </div>
              <div class="form-group" id="add_value_group">
                <label for="add_value">Value</label>
                <input type="text" name="value" placeholder="Enter Value" class="form-control" id="add_value">
              </div>
              <div class="form-group">
                <label for="add_description">Description</label>
                <textarea name="description" placeholder="Enter Description" class="form-control" id="add_description" rows="3"></textarea>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Save</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Edit Configuration Modal -->
    <div class="modal fade" id="editConfigModal" tabindex="-1" role="dialog" aria-labelledby="editConfigModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="editConfigModalLabel">Edit Configuration Setting</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="javascript:void(0)" method="POST" enctype="multipart/form-data" id="editConfigForm">
            <div class="modal-body">
              <input type="hidden" name="config_id" id="edit_config_id">
              <input type="hidden" name="type" id="edit_type">
              <div class="form-group">
                <label for="edit_name">Name</label>
                <input type="text" name="name" class="form-control" id="edit_name" readonly>
              </div>
              <div class="form-group">
                <label for="edit_title">Title<span class="text-danger">*</span></label>
                <input required type="text" name="title" placeholder="Enter Title" class="form-control" id="edit_title">
              </div>
              <div class="form-group" id="edit_value_group">
                <label for="edit_value">Value</label>
                <input type="text" name="value" placeholder="Enter Value" class="form-control" id="edit_value">
              </div>
              <div class="form-group">
                <label for="edit_description">Description</label>
                <textarea name="description" placeholder="Enter Description" class="form-control" id="edit_description" rows="3"></textarea>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Update</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <div class="content-backdrop fade"></div>
  </div>
</div>

<style>
  .badge {
    padding: 5px 10px;
    border-radius: 4px;
  }
  .bg-success {
    background-color: #28a745 !important;
    color: white;
  }
  .bg-secondary {
    background-color: #6c757d !important;
    color: white;
  }
  /* Ensure long values wrap and don't get truncated */
  #config_setting_table td {
    white-space: normal !important;
    word-wrap: break-word !important;
    word-break: break-word !important;
  }
  #config_setting_table th {
    white-space: nowrap !important;
  }
</style>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
  var column_details = <%$data|json_encode%>;
  var page_length_arr = <%$page_length_arr|json_encode%>;
  var is_searching_enable = <%$is_searching_enable|json_encode%>;
  var is_top_searching_enable = <%$is_top_searching_enable|json_encode%>;
  var is_paging_enable = <%$is_paging_enable|json_encode%>;
  var is_serverSide = <%$is_serverSide|json_encode%>;
  var no_data_message = <%$no_data_message|json_encode%>;
  var is_ordering = <%$is_ordering|json_encode%>;
  var sorting_column = <%$sorting_column%>;
</script>

<script src="<%$base_url%>public/js/admin/config_setting.js"></script>
