// public/js/idcard-designer.js
class IDCardDesigner {
    constructor(options) {
        // DOM Elements
        
        this.designArea = $(options.designArea);
        this.toolboxItems = $(options.toolboxItems);
        this.saveButton = $(options.saveButton);
        this.resetButton = $(options.resetButton);
        this.previewButton = $(options.previewButton);
        this.previewContent = $(options.previewContent);
        this.designName = $(options.designName);
        this.designId = $(options.designId);
        this.downloadPdf = $(options.downloadPdf);
        this.backgroundImage = options.designData?.backgroundImage || null;
        // Configuration
        this.saveUrl = options.saveUrl;
        this.fieldTypes = field_type;
        // State
        // this.designData = options.designData || {
        //     width: 350,
        //     height: 500,
        //     fields: []
        // };

        if(options.designData == null || options.designData == 'null'){
            this.designData = {
                width: 350,
                height: 500,
                fields: []
            }
        }else{
            this.designData = options.designData;
        }
        // Initialize
        this.initDesignArea();
        this.initToolbox();
        this.initEventHandlers();
        this.loadSavedDesign();
        this.initBackgroundImage();
    }
    

    initBackgroundImage() {
        // Set up background image upload
        $('#bg-image-input').change((e) => {
            $('#old_url').remove();
            const file = e.target.files[0];
            // if (file && file.type.match('image.*')) {
            //     const reader = new FileReader();
            //     reader.onload = (event) => {
            //         this.setBackgroundImage(event.target.result);
            //         this.backgroundImage = event.target.result;
            //     };
            //     reader.readAsDataURL(file);
            // }
            if (file && file.type.match('image.*')) {
            const formData = new FormData();
            formData.append('bg_image', file);
            $(".main-loader-box").show();
             $("body").addClass("loader-show");
            $.ajax({
                url: baseUrlFromTemplate + 'user/form/upload_background',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: (response) => {
                    const res = JSON.parse(response);
                    if (res.success) {
                        this.setBackgroundImage(res.url);
                        this.backgroundImage = res.url;
                    } else {
                        alert(res.error || 'Error uploading image');
                    }
                    $(".main-loader-box").hide();
                        $("body").removeClass("loader-show");
                },
                error: (xhr) => {
                    alert('Error: ' + xhr.responseText);
            }
        });
        }
        });

        

        // Remove background image
        $('#remove-bg-btn').click(() => {
            this.designArea.css('background-image', 'none');
            this.backgroundImage = null;
            $('#bg-image-preview').empty();
        });



        // Load saved background if exists
        if (this.backgroundImage) {
            this.setBackgroundImage(this.backgroundImage);
        }
    }

    setBackgroundImage(imageUrl) {
        this.designArea.css('background-image', `url('${imageUrl}')`);
        $('#bg-image-preview').html(`<img src="${imageUrl}" alt="Background Preview">`);
    }
    /* Initialization Methods */
    // initDesignArea() {
    //     console.log(this.designArea);
    //     this.designArea.resizable({
    //         handles: "se, sw, ne, nw",
    //         // minWidth: 200,
    //         // minHeight: 200,  
    //         resize: (e, ui) => {
    //             this.designData.width = ui.size.width;
    //             this.designData.height = ui.size.height;
    //         }
    //     }).css('overflow', 'hidden');
    // }
 
    initDesignArea() {
        const MM_PER_PX = 25.4 / 96; // ≈ 0.2646 mm per pixel at 96dpi
    
        this.designArea.resizable({
            handles: "se, sw, ne, nw",
            resize: (e, ui) => {
                this.designData.width = ui.size.width;
                this.designData.height = ui.size.height;
    
                // Convert to mm
                const widthMM = (ui.size.width * MM_PER_PX).toFixed(2);
                const heightMM = (ui.size.height * MM_PER_PX).toFixed(2);
    
                // Update label
                document.getElementById('sizeLabel').innerText = `Size: ${widthMM} mm × ${heightMM} mm`;
            }
        }).css('overflow', 'hidden');
    
        // Set initial size
        const widthMM = (this.designData.width * MM_PER_PX).toFixed(2);
        const heightMM = (this.designData.height * MM_PER_PX).toFixed(2);
        document.getElementById('sizeLabel').innerText = `Size: ${widthMM} mm × ${heightMM} mm`;
    }
    
    
    initToolbox() {
        this.toolboxItems.draggable({
            helper: 'clone',
            cursor: 'move',
            revert: 'invalid',
            zIndex: 1000,
            start: () => {
                this.designArea.css('outline', '2px dashed #0066cc');
            },
            stop: () => {
                this.designArea.css('outline', 'none');
            }
        });
        
        this.designArea.droppable({
            accept: '.toolbox-item',
            drop: (e, ui) => {
                const offset = this.designArea.offset();
                const x = ui.offset.left - offset.left;
                const y = ui.offset.top - offset.top;
                const type = ui.draggable.data('type');
                this.addField(type, x, y);
            }
        });
    }
    
    initEventHandlers() {
        this.saveButton.click(() => this.saveDesign());
        this.resetButton.click(() => this.resetDesign());
        this.previewButton.click(() => this.previewDesign());
    }
    
    /* Core Functionality */
    addField(type, x, y, existingData = null) {
        if (!this.fieldTypes.includes(type)) {
            console.error(`Invalid field type: ${type}`);
            return;
        }
        
        const fieldId = existingData?.id || this.generateFieldId(type);
        
        const fieldContent = this.getFieldContent(type, existingData);
        const { width, height } = this.getFieldDimensions(type, existingData);
        
        const field = $(`<div class="design-field" id="${fieldId}" data-type="${type}">
            ${fieldContent}
            <div class="field-actions" style="display:none;">
                <span class="remove-field">×</span>
            </div>
        </div>`).css({
            left: x + 'px',
            top: y + 'px',
            width: width+ 'px',
            height: height + 'px'
        });
        this.designArea.append(field);
        this.makeFieldInteractive(field);
        
        // Add to design data if new field
        if (!existingData) {
            this.designData.fields.push({
                id: fieldId,
                type,
                left: x,
                top: y,
                width,
                height,
                placeholder: this.getDefaultPlaceholder(type)
            });
        }
    }
    
    makeFieldInteractive(field) {
        let type = field.attr('data-type');

        field.draggable({
            containment: "#design-area",
            cursor: 'move',
            zIndex: 100,
            start: () => field.css('z-index', 1000),
            stop: (e, ui) => {
                field.css('z-index', 100);
                this.updateFieldPosition(field.attr('id'), ui.position);
            }
    });
       
        field.resizable({
            handles: 'n, e, s, w, ne, se, sw, nw',
            minWidth: 2,
            minHeight: 2,
            containment: "#design-area",

            resize: function(event, ui) {
                const height = ui.size.height;
                const fontSize = Math.max(10, height * 0.7);
                $(this).find('.field-value').css('font-size', fontSize + 'px');
            },

            stop: (e, ui) => {
                this.updateFieldDimensions(field.attr('id'), {
                    width: ui.size.width,
                    height: ui.size.height
                });
            }
        });

        field.find('.remove-field').click((e) => {
        e.stopPropagation();
        this.removeField(field.attr('id'));
        field.remove();
    });

    let that = this;
    $(".remove-field").on("click", function(e) {
        e.stopPropagation();
        var data_type = $(this).attr("data-type");
        that.removeFieldByType(data_type);
        $(".design-field[data-type='" + data_type + "']").remove();
    });

    $(document).on("click", ".design-field", function(e) {
        e.stopPropagation();
        $(".design-field").removeClass("selected-drag"); // ensure single select
        $(this).addClass("selected-drag");
    });

    // Add keydown listener ONCE to the document
    if (!this.keydownListenerAdded) {
        $(document).on('keydown', (e) => {
            const selected = $('.design-field.selected-drag');
            if (selected.length === 0) return;

            const step = 1;
            const pos = selected.position();
            let moved = false;

            switch (e.key) {
                case "ArrowLeft":
                    selected.css('left', pos.left - step + 'px');
                    moved = true;
                    break;
                case "ArrowRight":
                    selected.css('left', pos.left + step + 'px');
                    moved = true;
                    break;
                case "ArrowUp":
                    selected.css('top', pos.top - step + 'px');
                    moved = true;
                    break;
                case "ArrowDown":
                    selected.css('top', pos.top + step + 'px');
                    moved = true;
                    break;
            }

            if (moved) {
                e.preventDefault(); // prevent page scroll
                selected.each((_, el) => {
                    const $el = $(el);
                    const id = $el.attr('id');
                    const newPos = $el.position();
                    if (id) {
                        this.updateFieldPosition(id, newPos);
    }
                });
            }
        });

        this.keydownListenerAdded = true;
    }
}

   
    
    /* Data Management */
    updateFieldPosition(fieldId, position) {
        const field = this.designData.fields.find(f => f.id === fieldId);
        if (field) {
            field.left = position.left;
            field.top = position.top;
        }
    }
    
    updateFieldDimensions(fieldId, dimensions) {
        const field = this.designData.fields.find(f => f.id === fieldId);
        if (field) {
            field.width = dimensions.width;
            field.height = dimensions.height;
        }
    }
    
    removeField(fieldId) {
        this.designData.fields = this.designData.fields.filter(f => f.id !== fieldId);
    }
    removeFieldByType(type) {
        this.designData.fields = this.designData.fields.filter(f => f.type !== type);
    }
    
    downloadPDF(html) {
        // Create a temporary container
        const container = document.createElement("div");
        container.style.position = 'absolute';
        container.style.left = '-9999px';
        container.innerHTML = html;
        document.body.appendChild(container);
        // Replace background images with img elements
        const elementsWithBg = container.querySelectorAll('[style*="background-image"]');
        elementsWithBg.forEach(el => {
            const bgImage = el.style.backgroundImage;
            const urlMatch = bgImage.match(/url\(['"]?(.*?)['"]?\)/);
            if (urlMatch && urlMatch[1]) {
                
                const img = document.createElement('img');
                img.src = urlMatch[1];
                img.style.width = '100%';
                img.style.height = '100%';
                img.style.objectFit = 'cover';
                img.style.position = 'absolute';
                img.style.top = '0';
                img.style.left = '0';
                img.style.zIndex = '-1';
                
                // Preserve other styles
                el.style.backgroundImage = 'none';
                el.appendChild(img);
                
                
            }
        });
        
        // Generate PDF
        const opt = {
            margin: 0,
            filename: 'id-card.pdf',
            image: { type: 'jpeg', quality: 1 },
            html2canvas: { 
                scale: 2,
                useCORS: true,
                logging: true,
                allowTaint: true
            },
            jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
        };
        
        html2pdf().from(container).set(opt).save().then(() => {
            document.body.removeChild(container);
        });
    
    }
    /* Design Operations */
    htmlDecode(input) {
        const e = document.createElement('textarea');
        e.innerHTML = input;
        return e.value;
    }
    saveDesign() {
        const designName = this.designName.val() || 'Unnamed Design';
        const designId = this.designId.val();
        const updatedFields = [];

        $('.field-value').removeClass('hide');
        this.designData.fields.forEach(field => {
            // let main_ele = $(`#${field.id}`).clone();
            // const fieldElement = main_ele;
            const fieldElement = $(`#${field.id}`);
          
            // Remove resizable behavior if present
            if (fieldElement.is(':data(ui-resizable)')) {
              fieldElement.resizable('destroy');
            }
          
            // Clone the element and remove any .field-actions
            const clonedElement = fieldElement.clone();
            clonedElement.find('.field-actions').remove();
            
            // Get the cleaned-up HTML
            const cleanedHtml = this.htmlDecode(clonedElement.html());
            // Push updated field into the array
            updatedFields.push({
              ...field,
              html: cleanedHtml
            });
            
          });
          
        const saveData = {
            name: designName,
            col_per_row:$('.col-per-row').val(),
            width: this.designArea.outerWidth(),
            height: this.designArea.outerHeight(),
            backgroundImage: this.backgroundImage,
            old_url:$('#old_url').val() ?? '',
            fields:updatedFields
        };
        
        this.saveButton.text('Saving...').prop('disabled', true);
        $(".main-loader-box").show();
       $("body").addClass("loader-show");
        $.post(this.saveUrl, {
            design: saveData,
            design_id: designId
        }, (response) => {
            
            
            this.saveButton.text('Save Design').prop('disabled', false);
                $(".main-loader-box").hide();
      $("body").removeClass("loader-show");
      
        });
        // window.location.reload();
    }
    
    resetDesign() {
        if (confirm('Are you sure you want to reset the design?')) {
            this.designArea.children('.design-field').remove();
            this.designArea.css({
                width: '350px',
                height: '500px'
            });
            this.designData = {
                width: 350,
                height: 500,
                fields: []
            };
        }
    }
    
    previewDesign() {
        this.previewContent.empty();
        
        const previewCard = $('<div>').css({
            width: this.designArea.width() + 'px',
            height: this.designArea.height() + 'px',
            position: 'relative',
            border: '1px solid #000',
            margin: '10px',
            backgroundColor: 'white',
            backgroundImage: this.designArea.css('background-image'), // $
            backgroundSize: 'contain',
            backgroundRepeat: 'no-repeat',
            backgroundPosition: 'center'
            });
        
        this.designArea.children('.design-field').each((_, el) => {
            const $field = $(el);
            const cloned = $field.clone();
            
            cloned.find('.field-actions').remove();
            cloned.find('.ui-resizable-handle').remove();
            
            cloned.css({
                position: 'absolute',
                left: $field.position().left + 'px',
                top: $field.position().top + 'px',
                width: $field.width() + 'px',
                height: $field.height() + 'px'
            });
            
            previewCard.append(cloned);
        });
        
        this.previewContent.append(previewCard);
        this.previewContent.parent().show();
    }
    
    loadSavedDesign() {
       if(this.designData == 'null' || this.designData == null) return [];
        if (this.designData.fields?.length) {
            this.designArea.css({
                width: this.designData.width + 'px',
                height: this.designData.height + 'px'
            });
            this.designData.fields.forEach(field => {
                this.addField(field.type, field.left, field.top, {
                    id: field.id,
                    width: field.width,
                    height: field.height,
                    placeholder: field.placeholder,
                    html: field.html
                });
            });
        }
    }
    
    /* Helper Methods */
    getFieldContent(type, existingData = null) {
        if (existingData?.html) return existingData.html;
    
        const placeholders = placeholder_data;
        
        // const placeholder = existingData?.placeholder || placeholders[type] || type;
     
        const placeholder = placeholders[type];
        const templates = {
            image: `<div class="photo-placeholder" style="width:100%;height:100%;background:#eee;display:flex;align-items:center;justify-content:center;">
                <span>${placeholder}</span>
            </div>`,
            name: `<div class="field-value">${placeholder}</div>`,
            class: `<div class="field-value">${placeholder}</div>`,
            section: `<div class="field-value" >${placeholder}</div>`,
            rollno: ` <div class="field-value ">${placeholder}</div>`,
            school: `<div class="field-value ">${placeholder}</div>`,
            barcode: `<div style="width:100%;height:100%;background:#eee;display:flex;align-items:center;justify-content:center;">
                <span>Barcode: ${placeholder}</span>
            </div>`,
            qr: `<div style="width:100%;height:100%;background:#eee;display:flex;align-items:center;justify-content:center;">
                <span>QR Code: ${placeholder}</span>
            </div>`
        };
        
        return templates[type] || `<div class="field-value">${placeholder}</div>`;
    }
    
    getFieldDimensions(type, existingData = null) {
        if(existingData == null ){
            return {
                width:  50,
                height:  20 
            }
        }
        if (existingData) {
            return {
                width: existingData.width || 100,
                height: existingData.height || 100
            };
        }
        
    }
    
    getDefaultPlaceholder(type) {
        // const placeholders = {
        //     photo: '<%$img%>',
        //     name: '<%$name%>',
        //     class: '<%$class%>',
        //     section: '<%$section%>',
        //     rollno: '<%$roll_no%>',
        //     school: '<%$school_name%>',
        //     barcode: '<%barcode%>',
        //     qr: 'QR12345'
        // };
        const placeholders = placeholder_data;
        return placeholders[type] || type;
    }
    
    generateFieldId(type) {
        return `field-${type}-${Date.now()}-${Math.floor(Math.random() * 1000)}`;
    }
}

// Initialize when document is ready
$(function() {
    // Get data passed from Smarty template
    const designData = typeof designDataFromTemplate !== 'undefined' ? designDataFromTemplate : {};
    const saveUrl = typeof saveUrlFromTemplate !== 'undefined' ? saveUrlFromTemplate : '';
    
    new IDCardDesigner({
        designArea: '#design-area',
        toolboxItems: '.toolbox-item',
        saveButton: '#save-design',
        resetButton: '#reset-design',
        previewButton: '#preview-design',
        previewContent: '#preview-content',
        designName: '#design-name',
        designId: '#entity-id',
        downloadPdf: '#download-pdf',
        designData: designData,
        saveUrl: saveUrl
    });

    document.getElementById('myToggleSwitch').addEventListener('change', function() {
        if (this.checked) {
             $('.design-field').resizable({
    handles: 'n, e, s, w, ne, se, sw, nw',
    minWidth: 2,
    minHeight: 2,
    containment: '#design-area',

    // Adjust font-size live based on height
    resize: function(event, ui) {
        const height = ui.size.height;
        const fontSize = Math.max(10, height * 0.7); // Adjust scaling as needed

        $(this).find('.field-value').css({
            'font-size': fontSize + 'px',
            'line-height': fontSize + 'px' // optional for better alignment
        });
    },

    // Save updated dimensions on stop
    stop: function(event, ui) {
        const fieldId = $(this).attr('id');

        // Call your dimension-saving logic (adjust if not in `this`)
        if (typeof window.updateFieldDimensions === 'function') {
            window.updateFieldDimensions(fieldId, {
                width: ui.size.width,
                height: ui.size.height
            });
        }
    }
});;

          // Your ON logic here
        } else {
            $('.design-field').resizable('destroy');

          // Your OFF logic here
        }
      });
      $('.font-button').on('click', function() {
        let font_val = $('.font-size').val() + 'px';
        $('.field-value').css('font-size',font_val);
    });
    $(".remove-field").on("click",function(){
        var data_type = $(this).attr("data-type");
       $(".design-field[data-type='" + data_type + "']").remove();
    })
      
});