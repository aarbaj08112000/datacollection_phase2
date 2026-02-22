<div class="content-wrapper">
  <!-- Content -->
  <div class="container-xxl flex-grow-1 container-p-y">

    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Configure Fields
          <a hijacked="yes" href="<%base_url('field_selection_list')%>" class="backlisting-link" title="Back to Field Selection">
            <i class="ti ti-chevrons-right"></i>
            <em>Groups Configration Fields</em>
          </a>
        </h1>
        <br>
        <span><%$group['group_name']%></span>
      </div>
    </nav>

    <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
      <button type="button" class="btn btn-secondary" id="selectAllBtn">
        <i class="ti ti-check-all"></i> Select All
      </button>
      <button type="button" class="btn btn-secondary" id="deselectAllBtn">
        <i class="ti ti-x"></i> Deselect All
      </button>
      <button type="button" class="btn btn-primary" id="saveConfigBtn">
        <i class="ti ti-device-floppy"></i> Save Configuration
      </button>
      <a href="<%base_url('field_selection_list')%>" type="button" class="btn btn-secondary" id="selectAllBtn">
        <i class="ti ti-arrow-left"></i> 
      </a>
    </div>

    <!-- Main content -->
    <div class="card p-4 mt-4 w-100">
      <form id="fieldConfigForm">
        <input type="hidden" name="group_master_id" value="<%$group['group_master_id']%>">
        
        <div class="row">
          <%foreach from=$all_fields item=field%>
            <div class="col-md-4 col-sm-6 mb-3">
              <div class="form-check field-checkbox-item">
                <input 
                  class="form-check-input field-checkbox" 
                  type="checkbox" 
                  name="selected_fields[]" 
                  value="<%$field['id']%>" 
                  id="field_<%$field['id']%>"
                  <%if in_array($field['id'], $selected_field_ids)%>checked<%/if%>
                >
                <label class="form-check-label" for="field_<%$field['id']%>">
                  <strong><%$field['field_name']%></strong>
                  <%if $field['field_label']%>
                    <br><small class="text-muted"><%$field['field_label']%></small>
                  <%/if%>
                  <%if $field['form_type']%>
                    <br><span class="badge bg-info text-white"><%$field['form_type']%></span>
                  <%/if%>
                </label>
              </div>
            </div>
          <%/foreach%>
        </div>

        <%if empty($all_fields)%>
          <div class="alert alert-info">
            <i class="ti ti-info-circle"></i> No fields found in form_field_master table.
          </div>
        <%/if%>
      </form>
    </div>

    <div class="content-backdrop fade"></div>
  </div>
</div>

<style>
  .field-checkbox-item {
    padding: 12px;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    transition: all 0.2s;
    background-color: #f9f9f9;
  }
  
  .field-checkbox-item:hover {
    background-color: #f0f0f0;
    border-color: var(--bs-theme-color);
  }
  
  .field-checkbox-item input[type="checkbox"]:checked ~ label {
    color: var(--bs-theme-color);
    font-weight: 600;
  }
  
  .form-check-input {
    width: 20px;
    height: 20px;
    margin-top: 0.15em;
  }
  
  .form-check-label {
    margin-left: 8px;
    cursor: pointer;
  }
  
  .btn-primary {
    background-color: var(--bs-theme-color) !important;
    border-color: var(--bs-theme-color) !important;
  }
  
  .badge.bg-info {
    background-color: #17a2b8 !important;
    color: white !important;
    font-size: 0.7rem;
    padding: 3px 8px;
    margin-top: 4px;
    display: inline-block;
  }
</style>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
  var group_id = <%$group['group_master_id']%>;
</script>

<script src="<%$base_url%>public/js/admin/configure_group_fields.js"></script>
