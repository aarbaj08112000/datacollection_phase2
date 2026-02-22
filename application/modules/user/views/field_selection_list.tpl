<div class="content-wrapper">
  <!-- Content -->
  <div class="container-xxl flex-grow-1 container-p-y">

    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Field Selection Configuration
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Field Selection">
            <i class="ti ti-chevrons-right"></i>
            <em>Group Field Configuration</em>
          </a>
        </h1>
        <br>
        <span>Listing</span>
      </div>
    </nav>

    <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
      <button class="btn btn-seconday" type="button" id="downloadEXCELBtn" title="Download Excel"><i class="ti ti-file-type-xls"></i></button>
    </div>

    <div class="w-100">
      <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-3 me-0" id="serarch-filter-input" fdprocessedid="bxkoib">
    </div>

    <!-- Main content -->
    <div class="card p-0 mt-4 w-100">
      <div class="">
        <div class="table-responsive text-nowrap">
          <table id="field_selection_table" class="table table-striped display nowrap w-100"></table>
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
  .btn-primary {
    background-color: var(--bs-theme-color) !important;
    border-color: var(--bs-theme-color) !important;
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

<script src="<%$base_url%>public/js/admin/field_selection.js"></script>
