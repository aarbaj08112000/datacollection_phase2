$( document ).ready(function() {
    page.init();
});
var previewIdCard = new bootstrap.Modal(document.getElementById('addPromo'))
var editData = new bootstrap.Modal(document.getElementById('dataEdit'));
var editImageData = new bootstrap.Modal(document.getElementById('dataImageEdit'));
var imagePrevie = new bootstrap.Modal(document.getElementById('imagePrevie'))
var table = '';
var file_name = url;
var pdf_title = "Form Data";
var $scrollTable = "";
const page = {
    init: function(){
        let that = this;
        this.dataTable();
        this.formInitiate();
        $("#group_code").on("input",function(){
        	let value = $(this).val();
        	$(this).val((value.replace(/[^a-zA-Z_]/g, '')).toLowerCase());
        })
        $(".select2").select2();
        $('.filter-icon').on("click",function() {
         
          $("tr.filters").toggle("slow")
        });
      $(document).on("click",'.preview-id',function() {
          var data = $(this).data("href");
          $(".preview-id-card-pdf").attr("src",data);
          previewIdCard.show();
      });
      $(document).on("click",'.closePreview',function() {
        $(".preview-id-card-pdf").attr("src","");
      });

    //   $(document).on("click",'.image-preview',function() {
    //     var image = $(this).data("src");
    //     $("#imagePrevie img").attr("src",image);
    //     imagePrevie.show();
    //   });
      
    //   $(document).on("click", '.image-preview', function () {
    //     var image = $(this).data("src");
    //     var placeholder = 'https://www.wavonline.com/a/img/no_image_available.jpeg';
    
    //     var img = new Image();
    //     img.onload = function () {
    //         // If image exists, show it
    //         $("#imagePrevie img").attr("src", image);
    //     };
    //     img.onerror = function () {
    //         // If image doesn't exist, show placeholder
    //         $("#imagePrevie img").attr("src", placeholder);
    //     };
    //     img.src = image;
    
    //   imagePrevie.show();
    // });
    
    $(document).on("click", '.image-preview', function () {
        $("#imagePrevie img.no-image-date").show();
        var image = $(this).data("src"); // e.g., deepak_public_school_50.jpg
        var altImage = ''; // fallback with changed extension
        var placeholder = 'https://www.wavonline.com/a/img/no_image_available.jpeg';
         $("#imagePrevie img.original-image").attr("src", image).hide();
        // Swap extension to uppercase/lowercase
        if (image.toLowerCase().endsWith('.jpg')) {
            altImage = image.replace(/\.jpg$/i, '.JPG');
        } else if (image.toLowerCase().endsWith('.jpeg')) {
            altImage = image.replace(/\.jpeg$/i, '.JPEG');
        }

        var img = new Image();

        img.onload = function () {
            $("#imagePrevie img.no-image-date").hide();
            $("#imagePrevie img.original-image").attr("src", image).show();
        };

        img.onerror = function () {
            // Try alternate version (e.g., .JPG)
            if (altImage) {
                var imgAlt = new Image();
                imgAlt.onload = function () {
                    $("#imagePrevie img.no-image-date").hide();
                    $("#imagePrevie img.original-image").attr("src", altImage).show();
                };
                imgAlt.onerror = function () {
                    $("#imagePrevie img.no-image-date").hide()
                    $("#imagePrevie img.original-image").attr("src", placeholder).show();
                };
                imgAlt.src = altImage;
            } else {
                $("#imagePrevie img.no-image-date").hide();
                $("#imagePrevie img.original-image").attr("src", placeholder).show();
            }
        };

        img.src = image;
        imagePrevie.show();
    });


      $(document).on("click",'.export-images',function() {
        let selected_records = [];
        $(".data-collected-row").each(function( index ) {
          if($(this).find(".form-check-input").is(":checked")){
            selected_records.push($(this).find(".form-check-input").val());
          }
        });
        if(selected_records.length > 0){
          const selected_record = btoa(selected_records.join(","));
          window.location.href = image_download_url+"?selected_ids="+selected_record;
        }else{
            window.location.href = image_download_url;
        }
         
      });
      $(document).on("click",'.export-ids',function() {
        let selected_records = [];
        $(".data-collected-row").each(function( index ) {
          if($(this).find(".form-check-input").is(":checked")){
            selected_records.push($(this).find(".form-check-input").val());
          }
        });
        if(selected_records.length > 0){
          const selected_record = btoa(selected_records.join(","));
          window.location.href = id_download_url+"?selected_ids="+selected_record;
        }else{
            window.location.href = id_download_url;
        }
         
      });
      $(document).on("click",'.check-all-input',function() {
          var data = $(this).data("href");
          if($(this).is(":checked")){
            $('.form-check-input').prop('checked', true);
          }else{
            $('.form-check-input').prop('checked', false);
          }
          
      });
      $(document).on("click",'.edit-from-data',function() {
        var collection_id = $(this).data("collection-id");
        $.ajax({
          type: "POST",
          url: "form_data_edit",
          data: {collection_id:collection_id},
          success: function (response) {
            var responseObject = JSON.parse(response);
            $(".main_data_form").html(responseObject.html_content);
            $(".main_data_form .select2").select2();
            editData.show()
          },
          error: function (error) {
            console.error("Error:", error);
          },
        });
    });
      $(document).on("click",'.edit-image-data',function() {
        var collection_id = $(this).data("collection-id");
        var base_url_val = $("#base_url").val();
        $.ajax({
          type: "POST",
          url: base_url_val+"form_image_data_edit",
          data: {collection_id:collection_id},
          success: function (response) {
            var responseObject = JSON.parse(response);
            $(".main_image_data_form").html(responseObject.html_content);
            editImageData.show()
          },
          error: function (error) {
            console.error("Error:", error);
          },
        }); 
      });
    $(document).on("click", '.refresh-filter', function () {
      $scrollTable.find('thead tr.filters th input').each(function () {
          $(this).val('');
      });
       table.columns().search('').draw();
    });
    $(document).on("click",'.card-generated-row',function() {
      let selected_records = [];
      $(".data-collected-row").each(function( index ) {
        if($(this).find(".form-check-input").is(":checked")){
          selected_records.push($(this).find(".form-check-input").val());
        }
      });
      if(selected_records.length > 0){
  Swal.fire({
    title: "Card generated?",
    text: "",
    icon: "warning",
    input: 'select',
    inputOptions: {
      Yes: 'Yes',
      No: 'No',
      Pending: 'Pending',
      TC: 'TC'
    },
    inputPlaceholder: 'Select card generated',
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Save",
    inputValidator: (value) => {
      return new Promise((resolve) => {
        if (value) {
          resolve();
        } else {
          resolve('Please select card generated!');
        }
      });
    }
  }).then((result) => {
    if (result.isConfirmed) {
      const selectedReason = result.value;
      let selected_records = [];
      $(".data-collected-row").each(function( index ) {
        if($(this).find(".form-check-input").is(":checked")){
          selected_records.push($(this).find(".form-check-input").val());
        }
      });
      if(selected_records.length > 0){
        $.ajax({
          type: "POST",
          url: "user/form/change_card_generated",
          data: {selected_records:selected_records,selectedReason:selectedReason},
          success: function (response) {
            var responseObject = JSON.parse(response);
            if(responseObject.success ==1){
              toaster("success",responseObject.messages);
            //   table.destroy();
            //   that.dataTable();
                $("#serarch-filter-input").trigger("keyup")
            }else{
              toaster("error",responseObject.messages);
            }
            
          },
          error: function (error) {
            console.error("Error:", error);
          },
        }); 
      }else{
        toaster("warning","Please select row.");
      }
    }
  });
  $("#swal2-select").select2()
}else{
  toaster("warning","Please select row.");
}
 

});


      $(".delete-imgs").on("click",function(){
      $("#deleteImg").modal("show")
    })

    $(".delete-all-img-conform").on("click",function(){
      var school_id = $(this).attr("data-school-id");
      $.ajax({
              type: "POST",
              url: "user/form/deleteSchoolImg",
              data: {school_id:school_id},
              success: function (response) {
                var responseObject = JSON.parse(response);
                if(responseObject.success ==1){
                  toaster("success",responseObject.messages);
                  $("#deleteImg").modal("hide")
                }else{
                  toaster("error",responseObject.messages);
                }
                
              },
              error: function (error) {
                console.error("Error:", error);
              },
            });
    })
    
    

    
    

    },
    dataTable: function(){
        var data = {school_id:school_id,column_details:column_details,page_name:page_name};
        table = new DataTable("#form_data_listing", {
            dom: "Bfrtilp",
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
                                if(order_acceptance_enable == "Yes"){
                                    values.splice(8, 4);
                                }else{
                                    values.splice(6, 4);
                                }
                                
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
                        
                        if(order_acceptance_enable == "Yes"){
                                    doc.content[1].table.widths = ['15%', '13%','10%', '10%', '15%','10%', '10%', '13%'];
                                }else{
                                    doc.content[1].table.widths = ['15%', '15%', '15%', '15%','15%', '15%'];
                                }
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
                            if(order_acceptance_enable == "Yes"){
                                    row.splice(8, 4);
                                }else{
                                    row.splice(6, 4);
                                }
                        });
                    }
                },
                {
                  extend: 'excelHtml5',
                  text: '',
                  titleAttr: 'Download Excel',
                  filename: file_name,
                   customizeData: function (data) {
                    $('#form_data_listing tbody tr').each(function (rowIndex) {
                      $(this).find('td').each(function (colIndex) {
                        let $info = $(this).find(".image-info");
                        if ($info.length > 0) {
                            let imageUrl = $info.attr('data-image') || 'No Image';
                            let imageName = imageUrl.split('/').pop(); // In case it's a full URL or path
                            data.body[rowIndex][colIndex] = imageName.replace(".jpg", "");
                        }
                    });
                    
                  });
                },
                //   customizeData: function (data) {
                //     // ✅ Loop through each row
                //     $('#form_data_listing tbody tr').each(function (rowIndex) {
                //         $(this).find('td').each(function (colIndex) {
                //           console.log($(this).find("img"))
                //           if($(this).find("img").length > 0){
                //             let cell = $(this).html();
    
                //             // ✅ Check for image tag
                //             if ($(cell).is('img')) {
                //                 let imgUrl = $(cell).attr('data-image') || 'No Image URL';
    
                //                 // ✅ Replace image with URL in exported Excel data
                //                 data.body[rowIndex][colIndex] = imgUrl;
                //             }
                //           }
                //         });
                //     });
                // },
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
              
              
                      
              
                      // ✅ Remove specific columns (A, B, F)
                      // const removeCols = ['A'];  // Columns to remove
              
                      // $sheet.find('row').each(function () {
                      //     $(this).find('c').each(function () {
                      //         let ref = $(this).attr('r');
                      //         if (ref) {
                      //             let col = ref.match(/[A-Z]+/)[0];  // Extract column letter
                      //             if (removeCols.includes(col)) {
                      //                 $(this).remove();
                      //             }
                      //         }
                      //     });
                      // });
              
                      // ✅ Shift remaining cells to the left
                    //   $sheet.find('row').each(function () {
                    //       let currentCol = 0;  // Track current column position
                    //       $(this).find('c').each(function () {
                    //           let ref = $(this).attr('r');
                    //           if (ref) {
                    //               let rowNum = ref.match(/\d+/)[0];      // Extract row number
                    //               let newCol = String.fromCharCode(65 + currentCol);  // Shift columns (A=65)
                    //               $(this).attr('r', `${newCol}${rowNum}`);
                    //               currentCol++;
                    //           }
                    //       });
                    //   });
                      // ✅ Set all column widths to approximately 20px
        let colCount = $sheet.find('row:first c').length;  // Get the total number of columns
        let colsXml = '<cols>';
        
        for (let i = 1; i <= colCount; i++) {
            colsXml += `<col min="${i}" max="${i}" width="2.14" customWidth="1"/>`;
        }
        
        colsXml += '</cols>';

        // Insert column width settings before the sheet data
        $sheet.find('sheetData').before(colsXml);
                  }
              }
              
            ],
            orderCellsTop: true,
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
            // order: sorting_column,
            paging: is_paging_enable,
            fixedHeader: false,
            info: true,
            autoWidth: true,
            lengthChange: true,

            // columnDefs: order_acceptance_enable == "Yes" ? [{ sortable: false, targets: 7 },{ sortable: false, targets: 8 },{ sortable: false, targets: 9 }] : [{ sortable: false, targets: 6 },{ sortable: false, targets: 7 },{ sortable: false, targets: 8 }],
            ajax: {
                data: {'data':data},    
                url: "user/form/form_data_listing",
                type: "POST",
            },
            "createdRow": function(row, data, dataIndex) {
                // if (data.status === "Active") {
                //     $(row).addClass('active-row'); // Add class for active rows
                // }else{
                //     $(row).addClass('inactive-row');
                // } 
                $(row).addClass('data-collected-row');
            },
            initComplete: function () {
              const api = this.api();
        
              // Add filters row to the scrollable header table
              const $tableWrapper = $('#form_data_listing').closest('.dataTables_wrapper');
              $scrollTable = $tableWrapper.find('.dataTables_scrollHeadInner table');
        
              if ($scrollTable.find('thead tr.filters').length === 0) {
                  const $filterRow = $scrollTable.find('thead tr').first().clone(true).addClass('filters');
                  $filterRow.find('th').each(function () {
                    console.log($(this).html())
                    if($(this).hasClass("search")){
                      $(this).html('<input type="text" placeholder="Search '+$(this).html()+'" style="width: 100%;" class="form-control" />');
                    }else{
                      $(this).html('');
                    }
                      
                  });
        
                  $scrollTable.find('thead').append($filterRow);
              }
        
              // Bind filtering logic
              $scrollTable.find('thead tr.filters th input').each(function (colIndex) {
                  $(this).on('keyup change', function () {
                    console.log(this,colIndex)
                      const value = this.value;
                      api.column(colIndex+1).search(value).draw(); // triggers server-side search
                  });
              });
          }
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
	              $(".modal").modal("hide")
	              setTimeout(function(){
	               // window.location.reload();
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
    }
    
}



