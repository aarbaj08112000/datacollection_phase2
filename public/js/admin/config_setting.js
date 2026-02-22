$(document).ready(function () {
    page.init();
});

var addConfigModal = new bootstrap.Modal(document.getElementById('addConfigModal'));
var editConfigModal = new bootstrap.Modal(document.getElementById('editConfigModal'));
var table = '';
var file_name = "config_settings_list";
var pdf_title = "Configuration Settings List";

const page = {
    init: function () {
        this.dataTable();
        this.formInitiate();
        this.handleTypeChange();
        $(".select2").select2();
    },

    dataTable: function () {
        table = new DataTable("#config_setting_table", {
            dom: "Bfrtilp",
            autoWidth: false,
            buttons: [
                {
                    extend: 'excelHtml5',
                    text: '<i class="ti ti-file-type-xls"></i> Export Excel',
                    titleAttr: 'Download Excel',
                    filename: file_name,
                    customize: function (xlsx) {
                        let sheet = xlsx.xl.worksheets['sheet1.xml'];
                        let $sheet = $(sheet);

                        $sheet.find('pageMargins').attr({
                            'left': '0.5',
                            'right': '0.5',
                            'top': '0.75',
                            'bottom': '0.75',
                            'header': '0.3',
                            'footer': '0.3'
                        });
                    }
                }
            ],
            orderCellsTop: true,
            fixedHeader: true,
            lengthMenu: page_length_arr,
            columns: column_details,
            processing: false,
            serverSide: is_serverSide,
            searching: is_searching_enable,
            ordering: is_ordering,
            bSort: true,
            orderMulti: false,
            pagingType: "full_numbers",
            scrollCollapse: true,
            scrollX: true,
            scrollY: true,
            order: sorting_column,
            paging: is_paging_enable,
            fixedHeader: false,
            info: true,
            lengthChange: true,
            ajax: {
                url: "config_setting_list_data",
                type: "POST",
            },
        });

        $('.dataTables_length').find('label').contents().filter(function () {
            return this.nodeType === 3;
        }).remove();

        $('#serarch-filter-input').on('keyup', function () {
            table.search(this.value).draw();
        });

        table.on('init.dt', function () {
            $(".dataTables_length select").select2({
                minimumResultsForSearch: Infinity
            });
        });

        // Edit configuration click handler
        $(document).on('click', '.edit-config', function () {
            var config_id = $(this).attr('data-id');
            page.loadConfigData(config_id);
        });
    },

    loadConfigData: function (config_id) {
        $.ajax({
            type: "POST",
            url: "get_config_setting",
            data: { config_id: config_id },
            success: function (response) {
                var responseObject = JSON.parse(response);
                if (responseObject.success == 1) {
                    var data = responseObject.data;

                    $('#edit_config_id').val(data.id);
                    $('#edit_name').val(data.name);
                    $('#edit_title').val(data.title);
                    $('#edit_type').val(data.type);
                    $('#edit_description').val(data.description);

                    // Handle value field based on type
                    page.updateEditValueField(data.type, data.value);

                    editConfigModal.show();
                } else {
                    toaster("error", responseObject.messages);
                }
            },
            error: function (error) {
                console.error("Error:", error);
                toaster("error", "Failed to load configuration data");
            }
        });
    },

    updateEditValueField: function (type, value) {
        var valueGroup = $('#edit_value_group');
        valueGroup.empty();

        var label = '<label for="edit_value">Value</label>';
        var input = '';

        // Helper function to escape HTML entities
        var escapeHtml = function (text) {
            var map = {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#039;'
            };
            return text.replace(/[&<>"']/g, function (m) { return map[m]; });
        };

        switch (type) {
            case 'check_box':
                var checked = value == '1' ? 'checked' : '';
                input = '<div class="form-check"><input type="checkbox" name="value" class="form-check-input" id="edit_value" ' + checked + '><label class="form-check-label" for="edit_value">Enable</label></div>';
                valueGroup.html(input);
                break;

            case 'date':
                input = '<input type="date" name="value" class="form-control" id="edit_value" value="' + escapeHtml(value) + '">';
                valueGroup.html(label + input);
                break;

            case 'file':
                var fileDisplay = value ? '<p class="text-muted">Current file: ' + escapeHtml(value) + '</p>' : '';
                input = fileDisplay + '<input type="file" name="value" class="form-control" id="edit_value">';
                valueGroup.html(label + input);
                break;

            case 'input':
            default:
                input = '<input type="text" name="value" placeholder="Enter Value" class="form-control" id="edit_value" value="' + escapeHtml(value) + '">';
                valueGroup.html(label + input);
                break;
        }
    },

    updateAddValueField: function (type) {
        var valueGroup = $('#add_value_group');
        valueGroup.empty();

        var label = '<label for="add_value">Value</label>';
        var input = '';

        switch (type) {
            case 'check_box':
                input = '<div class="form-check"><input type="checkbox" name="value" class="form-check-input" id="add_value"><label class="form-check-label" for="add_value">Enable</label></div>';
                valueGroup.html(input);
                break;

            case 'date':
                input = '<input type="date" name="value" class="form-control" id="add_value">';
                valueGroup.html(label + input);
                break;

            case 'file':
                input = '<input type="file" name="value" class="form-control" id="add_value">';
                valueGroup.html(label + input);
                break;

            case 'input':
            default:
                input = '<input type="text" name="value" placeholder="Enter Value" class="form-control" id="add_value">';
                valueGroup.html(label + input);
                break;
        }
    },

    handleTypeChange: function () {
        // Handle type change in add form
        $('#add_type').on('change', function () {
            var type = $(this).val();
            page.updateAddValueField(type);
        });

        // Initialize add form with default type
        page.updateAddValueField('input');
    },

    formInitiate: function () {
        let that = this;

        // Add configuration form submit
        $("#addConfigForm").submit(function (e) {
            e.preventDefault();
            var formData = new FormData(this);

            $.ajax({
                type: "POST",
                url: "add_config_setting",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    var responseObject = JSON.parse(response);
                    var msg = responseObject.messages;
                    var success = responseObject.success;

                    if (success == 1) {
                        toaster("success", msg);
                        addConfigModal.hide();
                        $("#addConfigForm")[0].reset();
                        page.updateAddValueField('input');
                        $('#add_type').val('input').trigger('change');
                        table.ajax.reload();
                    } else {
                        toaster("error", msg);
                    }
                },
                error: function (error) {
                    console.error("Error:", error);
                    toaster("error", "An error occurred while adding configuration");
                }
            });
        });

        // Edit configuration form submit
        $("#editConfigForm").submit(function (e) {
            e.preventDefault();
            var formData = new FormData(this);

            $.ajax({
                type: "POST",
                url: "update_config_setting",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    var responseObject = JSON.parse(response);
                    var msg = responseObject.messages;
                    var success = responseObject.success;

                    if (success == 1) {
                        toaster("success", msg);
                        editConfigModal.hide();
                        $("#editConfigForm")[0].reset();
                        table.ajax.reload();
                    } else {
                        toaster("error", msg);
                    }
                },
                error: function (error) {
                    console.error("Error:", error);
                    toaster("error", "An error occurred while updating configuration");
                }
            });
        });
    }
}
