$(document).ready(function () {
    page.init();
});

var table = '';
var file_name = "field_selection_list";

const page = {
    init: function () {
        this.dataTable();
        $(".select2").select2();
    },

    dataTable: function () {
        table = new DataTable("#field_selection_table", {
            dom: "Bfrtilp",
            autoWidth: false,
            buttons: [
                {
                    extend: 'excelHtml5',
                    text: '<i class="ti ti-file-type-xls"></i> Export Excel',
                    titleAttr: 'Download Excel',
                    filename: file_name
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
                url: "field_selection_list_data",
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
    }
}
