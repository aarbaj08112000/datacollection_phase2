<!DOCTYPE html>
<html>
<head>
    <style>
    @page {
    margin: 18px;
    }
    body {
        margin: 0;
        padding: 0;
    }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        td {
            /* padding: 10px; */
            vertical-align: top;
        }
        .id-card {
            position: relative;
            /* width: 350px; */
            /* height: 300px; */
            /* margin: 10px; */
        }
        .id-card-bg {
            position: absolute;
            top: -0px;
            left: -0px;
            /* width: 350px; */
            /* height: 300px; */
            object-fit: contain;
            z-index: -1;
        }
        .field-container {
            position: absolute;
            font-family: Arial, sans-serif;
        }
        .field-value{
            font-size: 12px;
        }
    </style>
</head>
<body>
    <table>
    
        <%foreach $students as $row%>
        <tr>
            <%foreach $row as $student%>
            <td>
                <div class="id-card" style="width: <%$width%>px;height:<%$height%>px">
                    <img src="<%$backgroundImage%>"  class="id-card-bg" style="width: <%$width%>px;height:<%$height%>px"/>
                    
                    <%foreach $fieldsConfig as $field%>
                    <%assign var="rawHtml" value=$field.html%>
                    
                    <%foreach $fieldMapping as $placeholder => $dataKey%>
                    
                        <%if isset($student[$dataKey])%>
                            <%assign var="rawHtml" value=$rawHtml|replace:$placeholder:$student[$dataKey]%>
                        <%else%>
                            <%assign var="rawHtml" value=$rawHtml|replace:$placeholder:''%>
                        <%/if%>
                    
                    <%/foreach%>
                    <div class="field-container" style="top: <%$field.top%>px; left: <%$field.left%>px; width: <%$field.width%>px; height: <%$field.height%>px;overflow:hidden;">
                        <%$rawHtml nofilter%>
                    </div>
                    <%/foreach%>
                </div>
            </td>
            <%/foreach%>
            <%if count($row) < 2%>
                <td></td>
            <%/if%>
        </tr>
        <%/foreach%>
    </table>
</body>
</html>