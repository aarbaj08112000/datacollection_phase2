$( document ).ready(function() {
    page.init();
});

const page = {
    init: function(){
        this.formInitiate();
        $(document).on("change input",".custom-form .required-input,.required-input-not",function(){
	        var value = $(this).val();
	        if (value !=''){
	          $(this).parents(".form-group").find("label.error").remove()
	        }
	    })
        $(".select2").select2();
      $('.onlyNumericInput').on('input', function(event) {
        var charCode = (event.which) ? event.which : event.keyCode;
        var value = $(this).val();
        if (value.includes('.')  && charCode == 46 ) {
            event.preventDefault();
        }
          // Allow only digits (0-9) and some specific control keys
        if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode !== 46) {
                event.preventDefault();
        }
        $(this).val(this.value.replace(/[^0-9.]/g, ''));
        
    });
    $('.onlySentenceCaseInput').on('input', function () {
        let value = $(this).val();

        // Capitalize the first letter of every sentence
        let formatted = value.replace(/(^\s*|[.!?]\s*)([a-z])/g, (match, prefix, letter) => {
            return prefix + letter.toUpperCase();
        });
    
        // Update the input with the formatted text
        $(this).val(formatted);
    });
    $('.onlyUpperCase').on('input', function(event) {
      var charCode = (event.which) ? event.which : event.keyCode;

      var value =  ($(this).val());
      value = (value.replace(/[^a-zA-Z\s]/g, '')).toUpperCase();
      $(this).val(value);
        
    });
    $('.onlyAlphaNumeric').on('input', function(event) {
      var charCode = (event.which) ? event.which : event.keyCode;
      var value =  ($(this).val());
      value = (value.replace(/[^a-zA-Z0-9]/g, '')).toUpperCase();
      $(this).val(value);
        
    });
    $('.onlyTitleCase').on('input', function(event) {
      let text = $(this).val();
      let titleCased = text.replace(/\w\S*/g, function(word) {
        return word.charAt(0).toUpperCase() + word.substr(1).toLowerCase();
      });
      $(this).val(titleCased);
        
    });
    },
    formInitiate: function(){
    	let that = this;
    	$(".submit_form").submit(function(e){
	        e.preventDefault();
	        var href = $(this).attr("action");
	        var id = $(this).attr("id");
	        let flag = that.formValidate(id);
	        if(flag){
	          return;
	        }
	        var formData = new FormData($('.'+id)[0]);
          $(".main-loader-box").show();
          $("body").addClass("loader-show");
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
                toastr.success(msg);
	              setTimeout(function(){
	                window.location.reload();
                  $(".main-loader-box").hide();
                  $("body").removeClass("loader-show");
	              },1500);

	            } else {
                toastr.error(msg);
                $(".main-loader-box").hide();
                  $("body").removeClass("loader-show");
	            }
              
	          },
	          error: function (error) {
	            console.error("Error:", error);
              $(".main-loader-box").hide();
                  $("body").removeClass("loader-show");
	          },
	        });
	      });
    },
    formValidate: function(form_class = ''){
        let flag = false;
        $(".custom-form."+form_class+" .required-input").each(function( index ) {
          var value = $(this).val();
          var dataLength = parseFloat($(this).attr('data-length'));
          var dataMax = parseFloat($(this).attr('data-max'));
          console.log(dataMax,value.length)
          if($(this).attr("type") == "radio"){
              var name = $(this).attr("name");
              var radio_button_value = $(`input[name='${name}']:checked`).val();
              if(radio_button_value == undefined){
                flag = true;
                  var label = $(this).parents(".form-group").find("label.form-label").contents().filter(function() {
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
                    var label_html = "<label class='error mt-3'>"+validation_message+"</label>";
                    $(this).parents(".form-group").append(label_html)
                  }
              }
          }else if(value == ''){
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
          else if(dataLength > 0 && dataLength != value.length){
            var type = $(this).hasClass("onlyNumericInput") ? "digit" : "character";
            flag = true;
            var label = $(this).parents(".form-group").find("label").contents().filter(function() {
              return this.nodeType === 3; // Filter out non-text nodes (nodeType 3 is Text node)
            }).text().trim();
            var exit_ele = $(this).parents(".form-group").find("label.error");
            if(exit_ele.length == 0){
              var end =" must be equal to "+dataLength+" "+type;
              label = ((label.toLowerCase()).replace("enter", "")).replace("select", "");
              label = (label.toLowerCase()).replace(/[^\w\s*]/gi, '');
              label = label.charAt(0).toUpperCase() + label.slice(1);
              var validation_message =label +end;
              var label_html = "<label class='error'>"+validation_message+"</label>";
              $(this).parents(".form-group").append(label_html)
            }
          }else if(dataMax < value.length){
            var type = $(this).hasClass("onlyNumericInput") ? "digit" : "character";
            flag = true;
            var label = $(this).parents(".form-group").find("label").contents().filter(function() {
              return this.nodeType === 3; // Filter out non-text nodes (nodeType 3 is Text node)
            }).text().trim();
            var exit_ele = $(this).parents(".form-group").find("label.error");
            if(exit_ele.length == 0){
              var end =" must be less than or equal to "+dataMax+" "+type;
              label = ((label.toLowerCase()).replace("enter", "")).replace("select", "");
              label = (label.toLowerCase()).replace(/[^\w\s*]/gi, '');
              label = label.charAt(0).toUpperCase() + label.slice(1);
              var validation_message =label +end;
              var label_html = "<label class='error'>"+validation_message+"</label>";
              $(this).parents(".form-group").append(label_html)
            }
          }
        });

        $(".custom-form."+form_class+" .required-input-not").each(function( index ) {
          var value = $(this).val();
          var dataLength = parseFloat($(this).attr('data-length'));
          if(value != "" ){
            if(dataLength > 0 && dataLength != value.length){
              console.log(dataLength)
              var type = $(this).hasClass("onlyNumericInput") ? "digit" : "character";
              flag = true;
              var label = $(this).parents(".form-group").find("label").contents().filter(function() {
                return this.nodeType === 3; // Filter out non-text nodes (nodeType 3 is Text node)
              }).text().trim();
              var exit_ele = $(this).parents(".form-group").find("label.error");
              if(exit_ele.length == 0){
                var end =" must be equal to "+dataLength+" "+type;
                label = ((label.toLowerCase()).replace("enter", "")).replace("select", "");
                label = (label.toLowerCase()).replace(/[^\w\s*]/gi, '');
                label = label.charAt(0).toUpperCase() + label.slice(1);
                var validation_message =label +end;
                var label_html = "<label class='error'>"+validation_message+"</label>";
                $(this).parents(".form-group").append(label_html)
              }
            }
          }
          
        });
        return flag;
    }
    
}


