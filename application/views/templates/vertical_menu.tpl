<%if $config['menu_type'] eq 'vertical'%>
<div class="collapse navbar-collapse <%$class%>" <%if $type eq 'mobile'%>style="display:none !important;"<%/if%> id="navbarNavDropdown">
   <ul class="navbar-nav">
      <!-- <li class="nav-item">
         <a class="nav-link active" aria-current="page" href="http://localhost/extra_work/erp_converted/dashboard">Dashboard</a>
      </li> -->
      <%if checkGroupAccess("dashboard","list","No") %>
      <li class="nav-item">
         <a class="nav-link" href="<%$base_url%>dashboard">Dashboard</a>
         </li> 
      <%/if%>
      <%if checkGroupAccess("group_master","list","No") || checkGroupAccess("user_list","list","No") %>
      <li class="nav-item dropdown">
         <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkPurchase" role="button" data-bs-toggle="dropdown" aria-expanded="false">
         User Management
         </a>
         <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkPurchaseSubmenu">
            <%if checkGroupAccess("user_list","list","No") %>
            <li>
               <a href="<%$base_url%>user_list" class="dropdown-item">User</a>
            </li>
            <%/if%>
            <%if checkGroupAccess("group_master","list","No") %>
            <li>
               <a href="<%$base_url%>group_master" class="dropdown-item">Group Master</a>
            </li>
            <%/if%>
            <%if checkGroupAccess("config_setting_list","list","No") %>
            <li>
               <a href="<%$base_url%>config_setting_list" class="dropdown-item">Configuration Settings</a>
            </li>
            <%/if%>
            <%if checkGroupAccess("field_selection_list","list","No") %>
            <li>
               <a href="<%$base_url%>field_selection_list" class="dropdown-item">Group Field Configuration</a>
            </li>
            <%/if%>
            
         </ul>
      </li>
      <%/if%>
      <%if checkGroupAccess("form_listing","list","No") || checkGroupAccess("form_field_listing","list","No") %>
      <li class="nav-item dropdown">
         <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkPurchase" role="button" data-bs-toggle="dropdown" aria-expanded="false">
         Data Management
         </a>
         <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkPurchaseSubmenu">
            <%if checkGroupAccess("form_listing","list","No") %>
            <li>
               <a href="<%$base_url%>form_listing" class="dropdown-item"> College/School Master</a>
            </li>
            <%/if%>
            <!-- <li>
               <a href="<%$base_url%>form_listing" class="dropdown-item">Form Listing</a>
            </li> -->
            <%if checkGroupAccess("form_field_listing","list","No") %>
            <li>
               <a href="<%$base_url%>form_field_listing" class="dropdown-item">Form Field Master</a>
            </li>
            <%/if%>
            
         </ul>
      </li>
   <%/if%>
      <%if checkGroupAccess("trash_form_listing","list","No") %>
      <li class="nav-item">
         <a class="nav-link" href="<%$base_url%>trash_form_listing">Recycle Bin</a>
         </li> 
      <%/if%>
      <!-- <li class="nav-item">
         <a href="http://localhost/extra_work/erp_converted/logout" class="nav-link">Logout</a>
         </li> -->
   </ul>
</div>
<%/if%>