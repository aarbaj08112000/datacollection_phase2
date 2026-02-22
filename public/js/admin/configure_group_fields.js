$(document).ready(function () {
    page.init();
});

const page = {
    init: function () {
        this.handleSelectAll();
        this.handleDeselectAll();
        this.handleSaveConfig();
    },

    handleSelectAll: function () {
        $('#selectAllBtn').on('click', function () {
            $('.field-checkbox').prop('checked', true);
            toaster("info", "All fields selected");
        });
    },

    handleDeselectAll: function () {
        $('#deselectAllBtn').on('click', function () {
            $('.field-checkbox').prop('checked', false);
            toaster("info", "All fields deselected");
        });
    },

    handleSaveConfig: function () {
        $('#saveConfigBtn').on('click', function () {
            var formData = $('#fieldConfigForm').serializeArray();

            // Check if at least one field is selected
            var selectedCount = $('.field-checkbox:checked').length;

            if (selectedCount === 0) {
                Swal.fire({
                    title: "No Fields Selected",
                    text: "Please select at least one field to configure.",
                    icon: "warning",
                    confirmButtonColor: "#3085d6",
                    confirmButtonText: "OK"
                });
                return;
            }

            // Confirm save
            Swal.fire({
                title: "Save Configuration?",
                text: "You have selected " + selectedCount + " field(s). Do you want to save this configuration?",
                icon: "question",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes, Save it!"
            }).then((result) => {
                if (result.isConfirmed) {
                    // Save configuration
                    $.ajax({
                        type: "POST",
                        url: base_url + "save_group_field_config",
                        data: formData,
                        success: function (response) {
                            var responseObject = JSON.parse(response);
                            var msg = responseObject.messages;
                            var success = responseObject.success;

                            if (success == 1) {
                                toaster("success", msg);
                                setTimeout(function () {
                                    window.location.href = base_url + "field_selection_list";
                                }, 1500);
                            } else {
                                toaster("error", msg);
                            }
                        },
                        error: function (error) {
                            console.error("Error:", error);
                            toaster("error", "An error occurred while saving configuration");
                        }
                    });
                }
            });
        });
    }
}
