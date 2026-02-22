var registrationCode = "";
var user_type_val = "channel partner";
$(document).ready(function($) {
  $(document).on("change","#user_type",function(){
    var user_type = $(this).val();
    var user_title = user_type == "ChannelPartner" ? "Channel Partner" : "School";
    user_type_val = user_type.toLowerCase();
    $(".title-school").html(user_title)
  })
  $(".select2").select2();
  var validator = $("#formAuthentication").validate({
    rules: {
     school_name: {
       required: true
     },
     school_logo: {
       required: true
     },
     school_address: {
       required: true
     },
     school_contact_no: {
       required: true,
       minlength: 10,
       maxlength: 10,
     },
     school_email: {
       required: true,
       email: true
     },
     contact_person_name: {
       required: true
     },
     contact_person_designation: {
       required: true
     },
     contact_person_mobile: {
       required: true,
       minlength: 10,
       maxlength: 10,
       // strongPassword: true
     },
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
     school_name: {
       required: `Please enter ${user_type_val} name`
     },
     school_logo: {
       required: `Please enter ${user_type_val} logo`
     },
     school_address: {
       required: `Please enter ${user_type_val} address`
     },
     school_contact_no: {
       required: `Please enter ${user_type_val} contact no`,
       minlength: `Please enter 10 digit ${user_type_val} contact no`,
       maxlength: `Please enter 10 digit ${user_type_val} contact no`,
     },
     school_email: {
       required: `Please enter ${user_type_val} email`,
       email: `Please enter a valid ${user_type_val} email`
     },
     contact_person_name: {
       required: "Please enter contact person name"
     },
     contact_person_designation: {
       required: "Please enter contact person designation"
     },
     contact_person_mobile: {
       required: "Please enter contact person mobile",
       minlength: "Please enter 10 digit contact person mobile",
       maxlength: "Please enter 10 digit contact person mobile",
     },
     email: {
       required: "Please enter your email",
       email: "Please enter a valid email"
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
        url: "user/Login/registration_submit",
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
                window.location.reload();
            }, 2500);
          }else{
            toaster("error",data.messages);
          }

        }
      });
    }

  });

  $("#loginStep1Btn").click(function () {
    // validate only step-1 inputs
    var valid = true;

    $(".step-first .validation-feild").each(function () {
      if (!validator.element(this)) {
        valid = false;
      }
    });

    if (valid) {
      $(".step-first").hide();
      $(".step-second").show();
      $("#loginBtn").show();
      $("#loginStep1Btn").hide();
    }
  });

  $("#back_to_first").click(function () {

      $(".step-first").show();
      $(".step-second").hide();
      $("#loginBtn").hide();
      $("#loginStep1Btn").show();
  });


  $("#loginStep2Btn").click(function () {
    // validate only step-1 inputs
    var valid = true;

    $(".step-second .validation-feild").each(function () {
      console.log(this)
      if (!validator.element(this)) {
        valid = false;
      }
    });

    if (valid) {
      sendOpt();
    }
  });

  $("#resendOtpBtn").on("click",function(){
    sendOpt();
    $("#resendOtpBtn").prop("disabled",true).addClass("disable-timer");
    let timeLeft = 30;
    let timer = setInterval(function () {

      $("#timer-count").html(`(${timeLeft})`);

      timeLeft--;

      if (timeLeft < 0) {
        $("#resendOtpBtn").prop("disabled",false).removeClass("disable-timer");
        clearInterval(timer);
        $("#timer-count").html("");
      }

    }, 1000);
    setTimeout(function () {
        
    }, 30000);
  })


  function sendOpt(){
    var contact_person_mobile = $("#contact_person_mobile").val();
    $.ajax({
      url: "user/Login/registration_otp",
      data: {contact_person_mobile:contact_person_mobile},
      type:"post",
      success: function(result){
        var data = JSON.parse(result);
        if (data.success == 1) {
          $(".main-loader-box").hide()
            registrationCode = data.code;
            toaster("success",data.messages);
            setTimeout(function () {
                $("#login_div").hide();
                $("#otp_div").show();
            }, 2000);
        }else{
          $(".main-loader-box").hide()
          toaster("error",data.messages);
        }

      }
    });
  }

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
               $("#formAuthentication").submit();
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
      formdata.append("code",registrationCode);
      $.ajax({
        url: "user/Login/registration_otp_submit",
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
                $("#formAuthentication").submit();
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
