    <!DOCTYPE html>
    <html>
    <head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>


        <title>ID Card Designer</title>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <style>
            #design-container {
                display: inline-block;
                padding: 10px;
                background: #f0f0f0;
                border-radius: 5px;
                width: 100%;
                box-sizing: border-box;
            }
            
            #design-area {
                width: 350px;
                height: 300px;
                border: 2px dashed #ccc;
                position: relative;
                background: white;
                overflow: hidden;
                margin-bottom: 20px;
                left: 15px;
            }
            
            .design-field {
                position: absolute;
                /* border: 1px dashed #aaa; */
                padding: 0px;
                /* background: rgba(255,255,255,0.8); */
                min-width: 10px;
                min-height: 10px;
                box-sizing: border-box;
                    background: #ddd;
                cursor: pointer;
            }
            
            .toolbox {
                    padding: 20px !important;
                width: 253px;
                float: left;
                margin-right: 20px;
                padding: 10px;
                background: #e9e9e9;
                border-radius: 5px;
            }
            
            #design-area::after {
                content: "";
                position: absolute;
                right: 2px;
                bottom: 2px;
                width: 12px;
                height: 12px;
                background: url('data:image/svg+xml;utf8,<svg fill="%23000" height="12" width="12" xmlns="http://www.w3.org/2000/svg"><path d="M0,12 L12,0 M4,12 L12,4 M8,12 L12,8" stroke="gray" stroke-width="1"/></svg>') no-repeat center center;
                cursor: se-resize;
                z-index: 10;
            }
            
            .toolbox-item {
                padding: 8px;
                margin: 5px 0;
                background: #fff;
                cursor: move;
                border-radius: 3px;
            }
            
            .field-actions {
                position: absolute;
                top: -10px;
                right: -10px;
            }
            
            .remove-field {
                background: red;
                color: white;
                border-radius: 50%;
                /* width: 13px;
                height: 13px; */
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-size: 12px;
                z-index: 1000;
                position: relative;
            }
            
            .ui-resizable-handle {
                background: #0066cc;
                width: 10px;
                height: 10px;
                z-index: 100;
            }
           
            .design-field .ui-resizable-handle{
                width: 4px;
                height: 4px;
            }

            .design-field .ui-resizable-handle{
                width: 4px;
                height: 4px;
            }
            .design-field .ui-resizable-handle.ui-resizable-n,.design-field .ui-resizable-handle.ui-resizable-e,.design-field .ui-resizable-handle.ui-resizable-w,.design-field .ui-resizable-handle.ui-resizable-s{
                display: none !important;
            }
            
            .ui-resizable-se {
                right: -5px;
                bottom: -5px;
            }
            
            .design-actions {
                margin-top: 20px;
                clear: both;
            }
            
            #design-preview {
                margin-top: 20px;
                border: 1px solid #ddd;
                padding: 10px;
            }
            .field-value{
                /* display: none; */
            }
            
            .clearfix {
                clear: both;
            }
        
        
        .bg-image-controls {
            margin-top: 15px;
            padding: 10px;
            background: #e9e9e9;
            border-radius: 5px;
        }
        #design-area {
            position: relative;
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
        }
        .bg-controls {
            margin: 15px 0;
            padding: 10px;
            background: #f5f5f5;
            border-radius: 5px;
        }
        #bg-image-preview img {
            max-width: 150px;
            max-height: 100px;
            margin-top: 10px;
            border: 1px solid #ddd;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
            }

            .switch input {
            opacity: 0;
            width: 0;
            height: 0;
            }

            .slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0;
            right: 0; bottom: 0;
            background-color: #ccc;
            transition: 0.3s;
            border-radius: 24px;
            }

            .slider:before {
            position: absolute;
            content: "";
            height: 18px; width: 18px;
            left: 3px; bottom: 3px;
            background-color: white;
            transition: 0.3s;
            border-radius: 50%;
            }
            input:checked + .slider {
            background-color: #4CAF50;
            }

            input:checked + .slider:before {
            transform: translateX(26px);
            }
            .font-btn{
                height: 38px;
                margin-top: 1px;
                    background: var(--bs-theme-color) !important;
    color: #ffffff !important;
    transform: translateY(-1px) !important;
            }
            .trash-col {
                padding: 8px;
                margin: 5px 0;
                background: red;
                /* cursor: move; */
                border-radius: 3px;
            }
            .selected-drag {
    color: red;
}
        </style>
    </head>
    <body>
    <div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
 
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
        Data Management
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Issue Request Listing" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Id Card Editor</em></a>
          </h1>
          <br>
          <span ><%$school_data['name']%></span>
        </div>
      </nav>
      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
      <a class="btn btn-seconday" type="button" title="Back To College/School Master Listing" href="<%base_url('form_listing')%>"><i class="ti ti-arrow-left"></i></a>
      </div>
        <div id="design-container">
            <div class="toolbox field-data">
                <h3>Toolbox</h3>
                <%foreach from=$form_tittle item=item key=key%>
                <div class="row">
                <div class="col-10 pe-0">
                <div class="toolbox-item " data-type="<%$key%>" style=""><%$item%></div>
                </div>
                <div class="col-2 trash-col remove-field" data-type="<%$key%>">
                <i class="ti ti-trash m-auto " style="margin-left: -6px;font-size:24px;"  ></i>
                </div>
                </div>
                <%/foreach%>
            </div>
            <div class="row mb-4">
                <div class="col-2 mb-3">
                    <label class="mb-2">Background Image : </label><br>
                    <input type="file" id="bg-image-input" accept="image/*">
                </div>
                <div class="col-2 mb-3">
                     <label class="mb-2">Remove Background Image : </label><br>
                    <button id="remove-bg-btn" class="btn btn-sm btn-danger">Remove Background</button>
                </div>
                <div class="col-1 mb-3">
                    <label>Resize fields</label>
                    <br>
                    <label class="switch"> 
                    <input type="checkbox" id="myToggleSwitch" checked>
                    <span class="slider"></span>
                    </label>
                </div>
                <div class="col-3 mb-3">
                <label>Font Size</label><br>
                <input type="text" class="font-size form-control w-50 float-start">
                <button class="btn btn-sm btn-seconday font-button float-start font-btn">Change Font</button>
                </div>
                 <div class="col-2 mb-3">
                <label>Column Per Row</label>
                <input type="text" class="col-per-row form-control" name="col-per-row" placeholder="Please Enter Column Per Row">

            </div>
        <%*  <div id="bg-image-preview"></div> *%>
        </div>
            <div id="sizeLabel" class="ms-4" style="    margin-left: 289px !important;">Size: 0 mm × 0 mm</div>
            <div id="design-area" style="background-image:url('<%$image_url%>');" class="ms-5">
                <!-- Fields will be added here -->
                <input type="hidden" name="old_url" id="old_url" value="<%$image_url%>">
            </div>

            
            <div class="clearfix"></div>
            
            <div class="design-actions">
                <input type="text" name="name" id="design-name" placeholder="Design Name" value="<%$design.name|default:''%>" class="form-control float-start me-3" style="width: 200px;">
                <button id="save-design" class="btn btn-sm btn-danger me-2" style="height:38px;font-size:15px">Save Design</button>
                <button id="reset-design" class="btn btn-sm btn-seconday me-2" style="height:38px;font-size:15px">Reset</button>
                <button id="preview-design" class="btn btn-sm btn-danger me-2" style="height:38px;font-size:15px">Preview</button>
                <input type="hidden" id="entity-id" value="<%$design_id%>">
            </div>
            
            <div id="design-preview" style="display:none;">
                <h3>Preview</h3>
                <div id="preview-content"></div>
                <a id="download-pdf" href="#" style="display:none;">Download PDF</a>
            </div>
        </div>
        <div id="idCardContainer" style="display:none;"></div>

    </div>
    </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
        
        <script>
            // Pass data from Smarty to JavaScript
            var designDataFromTemplate = <%json_encode($design)%>;
            var saveUrlFromTemplate = '<%$save_url%>';
            var baseUrlFromTemplate = '<%$base_url%>';
            var placeholder_data = <%json_encode($placeholder_data)%>;
            var field_type = <%json_encode($field_types)%>
        </script>
        
        <script src="<%$base_url%>public/js/idcard_designe.js"></script>
        
    </body>
    </html>