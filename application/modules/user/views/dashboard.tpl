
<div class="container mt-4">
<style>
.school-title{
    font-family: "gilroysemibold" !important;
}
</style>
<div class="row">
<div class="col-md-12 mt-3">
<h4 style="float:left;width:85%;">Welcome to <%$config['company_name']%> </h4><input class="form-control search-school" style="width: 15%;float:left;" placeholder="Search here"><br>
</div>
<%assign var="borderColors" value=["red", "blue", "green", "orange"] %>
<%foreach from=$colleges item=college name=loop %>
    <%assign var="borderColor" value=$borderColors[$smarty.foreach.loop.index % count($borderColors)] %>
    <div class="col-md-3 mt-3 school-box">
    <a href="<%$base_url %>data_collection_list/<%$college.school_id %>">
        <div class="card p-3 pb-2" style="border-bottom: 3px solid <%$borderColor %>; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
            <div class="d-flex align-items-center">
                <!-- College Logo (Left Side) -->
                <img src="<%$base_url %><%$college.image %>" alt="Logo" style="width: 40px; height: 40px; margin-right: 10px;">

                <!-- College Name (Right Side) -->
                <div class="mt-3">
                <h5 class="mb-0 school-title" style="flex-grow: 1;"><%$college.name %></h5>
                <h6 class="mb-0 channel-title"><%$college.channel_patner_name %></h6>
                </div>
            </div>
            <p style="display: flex; justify-content: space-between; margin-top: 15px;margin-bottom: 0px;">
                <span>Total Reponse:</span> 
                <span style="font-weight: bold; font-size: 20px; color: <%$borderColor %>;"><%$college.total_record %></span>
            </p>
        </div>
        </a>
    </div>
    
<%/foreach %>
</div>

</div>
<script>
    $(".search-school").on("keyup",function(){
        var value = $(this).val();
        $(".school-box ").each(function( index ) {
            var school = $(this).find(".school-title").html();
            var channel = $(this).find(".channel-title").html();
            if(!((school.toLowerCase()).indexOf(value.toLowerCase()) != -1) && !((channel.toLowerCase()).indexOf(value.toLowerCase()) != -1)){
                $(this).hide();
            }else{
                $(this).show();
            }
        });
    })
    setInterval(() => {
        window.location.reload();
    }, 300000);
</script>