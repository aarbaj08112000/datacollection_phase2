$(document).ready(function($) {
  $("#formAuthentication").validate({
    rules: {
     email: {
       required: true,
       email: true
     },
     password: {
       required: true,
       // minlength: 8,
       // strongPassword: true
     }
   },
   messages: {
     email: {
       required: "Please enter your username",
       email: "Please enter a valid username"
     },
     password: {
       required: "Please enter your password",
       // minlength: "Your password must be 8 characters",
       // strongPassword: "Your password must be strong (include at least one uppercase letter, one lowercase letter, one digit, and one special character)"
     }
   },
    errorElement: "div",
    errorPlacement: function(error, element)
    {
      var element_id = element[0]['id'] ;
      error.appendTo(`#${element_id}Err`)
      // if(element[0].localName == "select"){
      //   $(element).parents("div").find(".select2-container").append(error);
      // }else{
      //   error.insertAfter( element );
      // }
    },
    submitHandler: function(form) {
      var formdata = new FormData(form);
      $.ajax({
        url: "user/Login/signin",
        data:formdata,
        processData:false,
        contentType:false,
        cache:false,
        type:"post",
        success: function(result){
          var data = JSON.parse(result);
          if (data.success == 1) {
            $("#user_id").val(data.user_id);
              toaster("success",data.messages);
              setTimeout(function () {
                // window.location.href = base_url+data.redirect_url;
                $("#login_div").css("display", "none");
                $("#otp_div").show();
            }, 2000);
          }else{
            toaster("error",data.messages);
          }

        }
      });
    }

  });

  $.validator.addMethod("strongPassword", function(value, element) {
   return this.optional(element) || /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/.test(value);
 }, "Your password must include at least one uppercase letter, one lowercase letter, one digit, and one special character");
 $("#clientId").select2({
  minimumResultsForSearch: Infinity
 })

 $(document).on("click","#pwd_show_hide i",function(){
   var status =  $(this).attr("data-status");
   console.log(status)
   if(status == "show"){
    $("#password").attr("type","text");
    $(this).removeClass("ti-lock").addClass("ti-lock-open").attr("data-status","hide");
   }else{
    $("#password").attr("type","password");
    $(this).removeClass("ti-lock-open").addClass("ti-lock").attr("data-status","show");
   }
 })

 $(document).on("click","#show_forgot_pwd",function(){
    $("#login_div").hide();
    $("#forgot_div").show();
    $(".error-msg").html("");
 })
 $(document).on("click","#back_to_login",function(){
    $("#login_div").show();
    $("#forgot_div").hide();
    $(".error-msg").html("");
 })

 $("#formRestePassword").validate({
    rules: {
     username: {
       required: true,
       email: true
     },
     // password: {
     //   required: true,
     //   // minlength: 8,
     //   // strongPassword: true
     // }
   },
   messages: {
     username: {
       required: "Please enter your username",
       email: "Please enter a valid username"
     },
     // password: {
     //   required: "Please enter your password",
     //   // minlength: "Your password must be 8 characters",
     //   // strongPassword: "Your password must be strong (include at least one uppercase letter, one lowercase letter, one digit, and one special character)"
     // }
   },
    errorElement: "div",
    errorPlacement: function(error, element)
    {
      var element_id = element[0]['id'] ;
      error.appendTo(`#${element_id}Err`)
      // if(element[0].localName == "select"){
      //   $(element).parents("div").find(".select2-container").append(error);
      // }else{
      //   error.insertAfter( element );
      // }
    },
    submitHandler: function(form) {
      var formdata = new FormData(form);
      $.ajax({
        url: "user/Login/reset_password",
        data:formdata,
        processData:false,
        contentType:false,
        cache:false,
        type:"post",
        success: function(result){
          var data = JSON.parse(result);
          if (data.success == 1) {
              toaster("success",data.messages);
              setTimeout(function () {
               $("#back_to_login").trigger("click");
            }, 2000);
          }else{
            toaster("error",data.messages);
          }

        }
      });
    }

  });

  $("#formotp").validate({
    rules: {
        otp: {
            required: true,  // OTP field is required
            minlength: 6,    // Minimum OTP length, change as needed
            maxlength: 6     // Maximum OTP length, change as needed
        }
    },
    messages: {
        otp: {
            required: "Please enter the OTP", // Custom error message for required OTP
            minlength: "OTP must be 6 digits", // Custom error for min length
            maxlength: "OTP must be 6 digits"  // Custom error for max length
        }
    },
    errorElement: "div", // Display errors in a div
    errorClass: "error-msg", // Add this class to the error message
    highlight: function(element) {
        $(element).addClass("error");
    },
    unhighlight: function(element) {
        $(element).removeClass("error");
    },
    submitHandler: function(form) {
      var formdata = new FormData(form);
      $.ajax({
        url: "user/Login/opt_submit",
        data:formdata,
        processData:false,
        contentType:false,
        cache:false,
        type:"post",
        success: function(result){
          var data = JSON.parse(result);
          if (data.success == 1) {
              toaster("success",data.messages);
              setTimeout(function () {
                window.location.href = base_url+data.redirect_url;
            }, 2000);
          }else{
            toaster("error",data.messages);
          }

        }
      });
    }
});

$('#resendOtpBtn').click(function() {
  var user_id = $("#user_id").val();
  
  $.ajax({
      url: 'user/Login/resent_otp',
      method: 'POST',
      data: { user_id: user_id },
      dataType: 'json',  
      success: function(data) {
          if (data.success == 1) {
              toaster("success", data.messages);
          } else {
              toaster("error", data.messages);
          }
      },
      error: function(xhr, status, error) {
          toaster("error", "Something went wrong. Please try again.");
          console.error("AJAX Error:", status, error);
      }
  });
});
$(document).ajaxStart(function() {
  if($("body").hasClass("modal-open")){
     setTimeout(function(){
       $(".main-loader-box").show();
       $("body").addClass("loader-show");
      },100)
  }else{
    $(".main-loader-box").show();
       $("body").addClass("loader-show");
  }
});
$(document).ajaxStop(function() {
  if($("body").hasClass("modal-open")){
    setTimeout(function(){
      $(".main-loader-box").hide();
      $("body").removeClass("loader-show");
    },1500)
  }else{
    $(".main-loader-box").hide();
      $("body").removeClass("loader-show");
  }
   
});


});
