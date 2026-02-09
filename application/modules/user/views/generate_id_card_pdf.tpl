<table style="width: 100%; border-collapse: collapse;">
    <tr>
        
        <?php foreach ($data as $student): 
        $student['form_data'] = json_decode($student['form_data'], true);
        ?><td style="width: 50%; padding: 10px;">
                <div style="border: 1px solid #ddd; border-radius: 8px; padding: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); display: flex; align-items: center;">
                    <div style="flex: 1;">
                    
                        <table style="width: 100%; border-collapse: collapse; color: #666;">
                            <tr>
                                <!-- Image Row -->
                                <td rowspan="6" style="width: 120px; padding: 10px; vertical-align: middle;">
                                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSaZeXucMQRfR2II9TKGtyOwe6WILcgBiLx0yZ2-K5tQnPZHuZbpxfOxsjx6D_eRLJf_c&usqp=CAU" alt="Image" style="border-radius: 50%; width: 100px; height: 100px;">
                                </td>
                                <td style="padding: 5px;">Sr No:  <span style="font-weight: bold;"><?php echo $student['sr_no']; ?></span></td>
                            </tr>

                            <tr>
                                <td style="padding: 5px; ">Name: <span style="font-weight: bold;"><?php echo $student['form_data']['student_name']; ?></span></td>
                            </tr>
                            <tr>
                                <td style="padding: 5px; ">Mobile No: <span style="font-weight: bold;"><?php echo $student['form_data']['mobile_no_1']; ?></span></td>
                            </tr>
                            <tr>
                                <td style="padding: 5px; ">Father's Name: <span style="font-weight: bold;"><?php echo $student['form_data']['father_name']; ?></span></td>
                            </tr>
                            <tr>
                                <td style="padding: 5px; ">Mother's Name: <span style="font-weight: bold;"><?php echo $student['form_data']['mother_name']; ?></span></td>
                            </tr>
                            <tr>
                                <td style="padding: 5px; ">Blood Group: <span style="font-weight: bold;"><?php echo $student['form_data']['blood_group']; ?></span></td>
                            </tr>
                        </table>
                        
                    </div>
                </div>
                </td>
                <?php endforeach; ?>
        
    </tr>
</table>
<br>