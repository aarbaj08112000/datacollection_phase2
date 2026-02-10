$( document ).ready(function() {
    page.init();
});
var statusChange = new bootstrap.Modal(document.getElementById('addPromo'))
var importData = new bootstrap.Modal(document.getElementById('importData'))
var table = '';
var file_name = "item_par_list";
var pdf_title = "Item part List";
const page = {
    init: function(){
        this.dataTable();
        this.formInitiate();
        this.importData();
        $("#group_code").on("input",function(){
        	let value = $(this).val();
        	$(this).val((value.replace(/[^a-zA-Z_]/g, '')).toLowerCase());
        })
        $(".select2").select2();

        $('.copy-url').click(function() {
          var url = $(this).attr('data-url');
          var $tempInput = $('<input>');
          $('body').append($tempInput);  
          $tempInput.val(url).select();  
          document.execCommand('copy');  
          $tempInput.remove();  
          // alert('URL copied to clipboard!');
          toaster("success",'URL copied to clipboard!');
      });

      $(document).on('click','.recycle-school',function() {
          var data_id = $(this).attr("data-id");
          Swal.fire({
            title: "Are you sure you want to add in recycle bin?",
            text: "",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Yes"
          }).then((result) => {
            if (result.isConfirmed) {
              const selectedReason = result.value;
             
              $.ajax({
                  type: "POST",
                url: "user/form/recycle_school",
                data: {
                  school_id: data_id,
                  reason: selectedReason // Send reason to backend
                },
                  success: function (response) {
                    var responseObject = JSON.parse(response);
                    var msg = responseObject.messages;
                    var success = responseObject.success;
                    if (success == 1) {
                    toaster("success", msg);
                    $(".modal").modal("hide");
                    setTimeout(function () {
                        // window.location.reload();
                        $("#serarch-filter-input").trigger("keyup")
                    }, 2000);
                    } else {
                    toaster("error", msg);
                    }
                  },
                  error: function (error) {
                    console.error("Error:", error);
                }
                });
            }
          });
          
      });
      $(document).on('click','.delete-school',function() {
        var data_id = $(this).attr("data-id");
        Swal.fire({
          title: "Are you sure you want to delete?",
          text: "",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "Yes"
        }).then((result) => {
          if (result.isConfirmed) {
            const selectedReason = result.value;
        
            $.ajax({
              type: "POST",
              url: "user/form/delete_school",
              data: {
                school_id: data_id,
                reason: selectedReason // Send reason to backend
              },
              success: function (response) {
                var responseObject = JSON.parse(response);
                var msg = responseObject.messages;
                var success = responseObject.success;
                if (success == 1) {
                  toaster("success", msg);
                  $(".modal").modal("hide");
                  setTimeout(function () {
                    // window.location.reload();
                    $("#serarch-filter-input").trigger("keyup")
                  }, 2000);
                } else {
                  toaster("error", msg);
                }
              },
              error: function (error) {
                console.error("Error:", error);
              }
            });
          }
        });
        
      });
      $(document).on('click','.restore-school',function() {
        var data_id = $(this).attr("data-id");
        Swal.fire({
          title: "Are you sure you want to restore?",
          text: "",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "Yes"
        }).then((result) => {
          if (result.isConfirmed) {
            const selectedReason = result.value;
        
            $.ajax({
              type: "POST",
              url: "user/form/restore_school",
              data: {
                school_id: data_id,
                reason: selectedReason // Send reason to backend
              },
              success: function (response) {
                var responseObject = JSON.parse(response);
                var msg = responseObject.messages;
                var success = responseObject.success;
                if (success == 1) {
                  toaster("success", msg);
                  $(".modal").modal("hide");
                  setTimeout(function () {
                    // window.location.reload();
                    $("#serarch-filter-input").trigger("keyup")
                  }, 2000);
                } else {
                  toaster("error", msg);
                }
              },
              error: function (error) {
                console.error("Error:", error);
              }
            });
          }
        });
        
      });
      $(document).on("click",".copy-url", function() {
        // Static text to be copied
        var staticText = $(this).attr("data-url");

        // Create a temporary input element to hold the static value
        var tempInput = $("<input>");
        $("body").append(tempInput);
        tempInput.val(staticText).select();
        
        // Execute the copy command
        document.execCommand("copy");
        
        // Remove the temporary input after copying
        tempInput.remove();

        // Show "Copied" feedback
        var ele = $(this).parents(".copy-text");
        ele.addClass("active");

        // Remove the feedback after 2.5 seconds
        setTimeout(function() {
          ele.removeClass("active");
        }, 1000);
      });
      $(document).on("click",".status-school", function() {
        var status = $(this).attr("data-status");
        $("#s_status").val(status).trigger("change");
        var id = $(this).attr("data-id");
        $("#s_school_id").val(id);
        statusChange.show()
        
      });
    
    


    },
    dataTable: function(){
        var data = {
          "is_deleted" : is_deleted 
        };
        table = new DataTable("#school_listing", {
            dom: "Bfrtilp",
            autoWidth: false,
            buttons: [
              {     
                    extend: 'csv',
                      text: '<i class="ti ti-file-type-csv"></i>',
                      init: function(api, node, config) {
                      $(node).attr('title', 'Download CSV');
                      },
                      customize: function (csv) {
                            var lines = csv.split('\n');
                            var modifiedLines = lines.map(function(line) {
                                var values = line.split(',');
                                values.splice(0, 1);
                                
                                return values.join(',');
                            });
                            return modifiedLines.join('\n');
                        },
                        filename : file_name
                    },

                  {
                    extend: 'pdf',
                    text: '<i class="ti ti-file-type-pdf"></i>',
                    init: function(api, node, config) {
                        $(node).attr('title', 'Download Pdf');
                    },
                    filename: file_name,
                    customize: function (doc) {
                      doc.pageMargins = [15, 15, 15, 15];
                      doc.content[0].text = pdf_title;
                      doc.content[0].color = theme_color;
                        
                        doc.content[1].table.body[0].forEach(function(cell) {
                            cell.fillColor = theme_color;
                        });
                        doc.content[1].table.body.forEach(function(row, rowIndex) {
                            row.forEach(function(cell, cellIndex) {
                                var alignmentClass = $('#example1 tbody tr:eq(' + rowIndex + ') td:eq(' + cellIndex + ')').attr('class');
                                var alignment = '';
                                if (alignmentClass && alignmentClass.includes('dt-left')) {
                                    alignment = 'left';
                                } else if (alignmentClass && alignmentClass.includes('dt-center')) {
                                    alignment = 'center';
                                } else if (alignmentClass && alignmentClass.includes('dt-right')) {
                                    alignment = 'right';
                                } else {
                                    alignment = 'left';
                                }
                                cell.alignment = alignment;
                            });
                            row.splice(0, 1);
                        });
                    }
                },
                {
                  extend: 'excelHtml5',
                  text: '<i class="ti ti-file-type-xls"></i> Export Excel',
                  titleAttr: 'Download Excel',
                  filename: 'Exported_Data',
                  customize: function (xlsx) {
                      let sheet = xlsx.xl.worksheets['sheet1.xml'];
                      let $sheet = $(sheet);
  
                      // ✅ Set custom page margins
                      $sheet.find('pageMargins').attr({
                          'left': '0.5',
                          'right': '0.5',
                          'top': '0.75',
                          'bottom': '0.75',
                          'header': '0.3',
                          'footer': '0.3'
                      });
  
                      // ✅ Add a custom title at the top
                      let customTitle = 'My Excel Report';  // Replace with your title
                      let headerRow = `
                          <row r="1">
                              <c t="inlineStr" s="2"><is><t>${customTitle}</t></is></c>
                          </row>
                      `;
                      $sheet.find('sheetData').prepend(headerRow);
  
                      // ✅ Style the header row
                      $sheet.find('row:nth-child(2) c').attr('s', '42');  // Apply custom header style
  
                      // ✅ Align cells based on table classes
                      $sheet.find('row').each(function (rowIndex) {
                          $(this).find('c').each(function (cellIndex) {
                              let alignmentClass = $('#myTable tbody tr:eq(' + (rowIndex - 1) + ') td:eq(' + cellIndex + ')').attr('class');
  
                              if (alignmentClass) {
                                  if (alignmentClass.includes('dt-left')) {
                                      $(this).attr('s', '2');  // Left align
                                  } else if (alignmentClass.includes('dt-center')) {
                                      $(this).attr('s', '3');  // Center align
                                  } else if (alignmentClass.includes('dt-right')) {
                                      $(this).attr('s', '4');  // Right align
                                  }
                              }
                          });
                      });
  
                      // ✅ Remove the "A" column
                      $sheet.find('row').each(function () {
                          $(this).find('c[r^="A"]').remove();
                          $(this).find('c[r^="F"]').remove();   // Remove cells in column "A"
                      });
  
                      // ✅ Shift all rows to the left
                      $sheet.find('row').each(function () {
                          $(this).find('c').each(function () {
                              let ref = $(this).attr('r');  // Get the current cell reference (e.g., B1, C1)
  
                              if (ref) {
                                  let col = ref.match(/[A-Z]+/)[0];  // Extract column letter
                                  let row = ref.match(/\d+/)[0];     // Extract row number
  
                                  // Move cells to the left (B → A, C → B, etc.)
                                  if (col !== 'A') {
                                      let newCol = String.fromCharCode(col.charCodeAt(0) - 1);
                                      $(this).attr('r', `${newCol}${row}`);
                                  }
                                  
                              }
                          });
                      });
                  }
              }
            ],
            orderCellsTop: true,
            fixedHeader: true,
            lengthMenu: page_length_arr,
            // "sDom":is_top_searching_enable,
            columns: column_details,
            processing: false,
            serverSide: is_serverSide,
            sordering: true,
            searching: is_searching_enable,
            ordering: is_ordering,
            bSort: true,
            orderMulti: false,
            pagingType: "full_numbers",
            scrollCollapse: true,
            scrollX: true,
            scrollY: true,
            order: [],
            paging: is_paging_enable,
            fixedHeader: false,
            info: true,
            lengthChange: true,
            fixedColumns: {
                leftColumns: left_fix_column,
                // end: 1
            },
            // columnDefs: order_acceptance_enable == "Yes" ? [{ sortable: false, targets: 7 },{ sortable: false, targets: 8 },{ sortable: false, targets: 9 }] : [{ sortable: false, targets: 6 },{ sortable: false, targets: 7 },{ sortable: false, targets: 8 }],
            ajax: {
                data: {'data':data},    
                url: "form_listing_data",
                type: "POST",
            },
            "createdRow": function(row, data, dataIndex) {
                if (data.status === "Active") {
                    $(row).addClass('active-row'); // Add class for active rows
                }else{
                    $(row).addClass('inactive-row');
                } 
            },
        });
        $('.dataTables_length').find('label').contents().filter(function() {
            return this.nodeType === 3; // Filter out text nodes
        }).remove();
        $('#serarch-filter-input').on('keyup', function() {
            table.search(this.value).draw();
        });
        table.on('init.dt', function() {
            $(".dataTables_length select").select2({
                minimumResultsForSearch: Infinity
            });
        });
       
    },
    formInitiate: function(){

    	let that = this;
    	$(".change_status").submit(function(e){
	        e.preventDefault();
	        var href = $(this).attr("action");
	        var id = $(this).attr("id");
	        let flag = that.formValidate(id);
	        if(flag){
	          return;
	        }
	        var formData = new FormData($('.'+id)[0]);
	        $.ajax({
	          type: "POST",
	          url: href,
	          data: formData,
	          processData: false,
	          contentType: false,
	          success: function (response) {
	            var responseObject = JSON.parse(response);
	            var msg = responseObject.messages;
	            var success = responseObject.success;
	            if (success == 1) {
                toaster("success",msg);
	              $(".modal").modal("hide");
	              setTimeout(function(){
	                //window.location.reload();
                  $("#serarch-filter-input").trigger("keyup")
	              },1500);

	            } else {
                toaster("error",msg);
	            }
	          },
	          error: function (error) {
	            console.error("Error:", error);
	          },
	        });
	      });

    },
    formValidate: function(form_class = ''){
        let flag = false;
        $(".custom-form."+form_class+" .required-input").each(function( index ) {
          var value = $(this).val();
          var dataMax = parseFloat($(this).attr('data-max'));
          var dataMin = parseFloat($(this).attr('data-min'));
          if(value == ''){
            flag = true;
            var label = $(this).parents(".form-group").find("label").contents().filter(function() {
              return this.nodeType === 3; // Filter out non-text nodes (nodeType 3 is Text node)
            }).text().trim();
            var exit_ele = $(this).parents(".form-group").find("label.error");
            if(exit_ele.length == 0){
              var start ="Please enter ";
              if($(this).prop("localName") == "select"){
                var start ="Please select ";
              }
              label = ((label.toLowerCase()).replace("enter", "")).replace("select", "");
              var validation_message = start+(label.toLowerCase()).replace(/[^\w\s*]/gi, '');
              var label_html = "<label class='error'>"+validation_message+"</label>";
              $(this).parents(".form-group").append(label_html)
            }
          }
          else if(dataMin !== undefined && dataMin > value){
            flag = true;
            var label = $(this).parents(".form-group").find("label").contents().filter(function() {
              return this.nodeType === 3; // Filter out non-text nodes (nodeType 3 is Text node)
            }).text().trim();
            var exit_ele = $(this).parents(".form-group").find("label.error");
            if(exit_ele.length == 0){
              var end =" must be greater than or equal to "+dataMin;
              label = ((label.toLowerCase()).replace("enter", "")).replace("select", "");
              label = (label.toLowerCase()).replace(/[^\w\s*]/gi, '');
              label = label.charAt(0).toUpperCase() + label.slice(1);
              var validation_message =label +end;
              var label_html = "<label class='error'>"+validation_message+"</label>";
              $(this).parents(".form-group").append(label_html)
            }
            }else if(dataMax !== undefined && dataMax < value){
              flag = true;
              var label = $(this).parents(".form-group").find("label").contents().filter(function() {
                return this.nodeType === 3; // Filter out non-text nodes (nodeType 3 is Text node)
              }).text().trim();
              var exit_ele = $(this).parents(".form-group").find("label.error");
              if(exit_ele.length == 0){
                var end =" must be less than or equal to "+dataMax;
                label = ((label.toLowerCase()).replace("enter", "")).replace("select", "");
                label = (label.toLowerCase()).replace(/[^\w\s*]/gi, '');
                label = label.charAt(0).toUpperCase() + label.slice(1)
                var validation_message =label +end;
                var label_html = "<label class='error'>"+validation_message+"</label>";
                $(this).parents(".form-group").append(label_html)
              }
          }
        });
       
        return flag;
    },
    importData: function(){
      let that = this;
      $(document).on("click",".upload-school-data", function() {
        var id = $(this).attr("data-id");
        $("#importData .export-excl").attr("href",`export_form_data/${id}`);
        $("#i_school_id").val(id);
        importData.show()
        
      });
        $("#importExportData").validate({
            rules: {
                image: {
                    required: true
                }
            },
            messages: {
                image: {
                    required: "Please upload file"
                }
            },
            errorPlacement: function (error, element) {
                
                    error.insertAfter(element);
                
            },
            submitHandler: function (form, event) {
                event.preventDefault();
                var formdata = new FormData(form);
                var school_id = $("#i_school_id").val();
                formdata.append("school_id",school_id);
                    $.ajax({
                        url: "user/form/importFormData",
                        data: formdata,
                        processData: false,
                        contentType: false,
                        cache: false,
                        type: "post",
                        success: function (result) {
                            var data = JSON.parse(result);
                            if (data.success == 1) {
                               $('#importFile').val('');
                                toaster("success", data.messages);
                                importData.hide();
                                table.destroy();
                                that.dataTable();
                            } else {
                                toaster("error", data.messages);
                            }

                        }
                    });
            }
        });
    }
    
}


