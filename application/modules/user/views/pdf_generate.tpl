<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .label-table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #000;
        }
        .label-table td {
            font-size: 12px;
        }
        .photo-box {
            width: 20mm;
            height: 50px;
            border: 1px solid #000;
        }
        .page-break {
            page-break-before: always; /* Force page break */
        }

    </style>
</head>
<body>

<table cellspacing="10">
    <%assign var='key_val' value=1%>
    <%assign var='width' value=50%>
    <%if $type eq 'Preview'%>
    <%assign var='width' value=100%>
    <%/if%>
    <%foreach from=$id_card_data item='row_data'%>
    <tr>
        <%foreach from=$row_data item='id_card'%>
        <td width="<%$width%>%" style="height: 173px;">
            <table class="label-table" cellspacing="2" cellpadding="0" style="border: 1px solid black;">
                <tr>
                    <td width="30%">
                        <table cellspacing="0">
                            <tr style="line-height: 1;">
                                <td style="text-align: center;">
                                    <br><br> Sr.No. : <%$id_card['sr_no']%>
                                </td>
                            </tr>
                            <tr style="line-height: .6;">
                                <td>&nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                            <%if $id_card['image'] != ""%>
                                <td>
                                    <img src="<%$id_card['image']%>" style="width: 200px; height: 250px;">
                                </td>
                            <%/if%>
                            </tr>
                        </table>
                    </td>
                    <td width="70%">
                        <table cellspacing="2">
                            <%foreach from=$id_card['other_data'] item='values'%>
                            <tr>
                                <td width="40%"><%$values['key']%></td>
                                <td width="65%" style="font-size: 11px;line-height: 1.3;"><%$values['value']%></td>
                            </tr>
                            <%/foreach%>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <%/foreach%>
    </tr>

    

    <%assign var='key_val' value=$key_val+1%>
    <%/foreach%>
</table>

</body>
</html>
