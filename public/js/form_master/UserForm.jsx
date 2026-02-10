"use client";

import { useForm } from "react-hook-form";
import * as z from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { Input } from "ui/components/Common/input";
import { Button } from "ui/components/Common/button";
import { Switch } from "ui/components/Common/switch";
import { Card, CardContent, CardFooter, CardHeader } from "ui/components/Common/card";
import { toast } from "react-hot-toast";
import { useRouter } from "next/navigation";
import { Form, FormField, FormItem, FormLabel, FormControl, FormMessage } from "ui/components/Common/form";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "ui/components/Common/select";
import Cookies from "js-cookie";
import { callAPI, removeBasePathIfExist } from "lib/general"
import PhoneInput from "react-phone-input-2";
import "react-phone-input-2/lib/style.css";
import LinkAndScroll from "utils/LinkAndScroll";

const userSchema = z.object({
  name: z.string().min(1, "Please enter name."),
  email: z.string().min(1, { message: "Please enter email." }).email({ message: "Please enter valid email." }),
  username: z.string().min(1, "Please enter username."),
  password: z.string().min(6,"Please enter password of length more than 6."),
  emailVerified: z.boolean(),
  phone_number: z.string().optional(), 
  status: z.string().min(1, { message: "Please select status." }), 
  group_id: z.string().min(1, { message: "Please select group." }),
});

export default function UserForm({ initialData, userId, groupData }) {
  const back_link = `${process.env.NEXT_PUBLIC_BASE_URL}${process.env.NEXT_PUBLIC_BASE_PATH}/list`;
  initialData.phone_number = initialData.phone_number != null ? initialData.phone_number: "";
  const router = useRouter();
  const form = useForm({
    resolver: zodResolver(userSchema),
    defaultValues: initialData
      ? {
          ...initialData,
          group_id: String(initialData.group_id), 
          emailVerified: initialData.email_verified == "Yes" ? true : false
        }
      : {
          name: "",
          email: "",
          username: "",
          password: "",
          group_id: "",
          phone_number: "",
          emailVerified: false,
          status: "Active",
        },
  });
  

  const onSubmit = async (form_params) => {
    try {
      const adminToken = Cookies.get("access-token");
      if (userId) {
        var inputParams = {
          "username":form_params.username,
          "email":form_params.email,
          "name": form_params.name,
          "emailVerified": form_params.emailVerified,
          "phone_number": form_params.phone_number != "" && form_params.phone_number != null ? form_params?.phone_number : "",
          "status":form_params.status,
          "group_id":parseInt(form_params.group_id),
          "adminToken":adminToken
        };
        const response_update = await callAPI(`/api/user/admin-update/${userId}`,"PUT",true, inputParams);
        if (response_update.data.settings.success) {
          toast.success(response_update.data.settings.message);
          setTimeout(() => {
            router.refresh();
            router.push(removeBasePathIfExist(`/list`));
            router.refresh();
          }, 500);
        } else {
          toast.error(response_update.data.settings.message);
        }
        
      } else {
        var inputParamsAdd = {
          "username":form_params.username,
          "email":form_params.email,
          "name": form_params.name,
          "emailVerified": form_params.emailVerified,
          "password":form_params.password,
          "phone_number": form_params.phone_number != "" && form_params.phone_number != null ? form_params?.phone_number : "",
          "status":form_params.status,
          "group_id":parseInt(form_params.group_id),
          "adminToken":adminToken
        };
        const response_add = await callAPI("/api/user/admin-add","POST",true, inputParamsAdd)
        if (response_add.data.settings.success) {
          toast.success(response_add.data.settings.message);
          setTimeout(() => {
            router.refresh();
            router.push(removeBasePathIfExist(`/list`));
            router.refresh();
          }, 500);
        } else {
          toast.error(response_add.data.settings.message);
        }
      }
    } catch (error) {
      toast.error("Something went wrong!");
    }
  };

  return (
    <div className="flex items-top justify-center h-4/5 p-10 pb-3 pt-3">
      <Card className="w-full mx-auto rounded-xl p-0 bg-white border-0">
        <CardHeader className="text-xl font-medium text-left">{userId ? "Update User" : "Add User"}</CardHeader>
        <CardContent>
          <Form {...form}>
            <form onSubmit={form.handleSubmit(onSubmit)} className="form-colum">
              <div className="grid grid-cols-2 gap-4">
              <FormField control={form.control} name="name" render={({ field }) => (
                <FormItem>
                  <FormLabel>Name</FormLabel>
                  <FormControl><Input {...field} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />

              <FormField control={form.control} name="email" render={({ field }) => (
                <FormItem>
                  <FormLabel>Email</FormLabel>
                  <FormControl><Input {...field} type="email" disabled={userId} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />

              <FormField control={form.control} name="username" render={({ field }) => (
                <FormItem>
                  <FormLabel>Username</FormLabel>
                  <FormControl><Input {...field} disabled={userId} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
              <FormField 
                name="phone_number" 
                control={form.control} 
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Phone Number</FormLabel>
                    <FormControl>
                      <PhoneInput
                        country={"us"} // Default country
                        value={field.value}
                        onChange={field.onChange}
                        inputClass="!w-full !h-10 !pl-14 !text-xs !border !border-gray-300 !rounded-md !p-2 focus:!border-blue-500"
                        containerClass="!w-full"
                        buttonClass="!border-r !border-gray-300 !bg-transparent !hover:border-gray-300"
                        dropdownClass="!text-gray-700"
                        inputStyle={{
                          height: "40px",   // Bigger height
                          paddingLeft: "60px", // Ensures flag & code alignment
                          fontSize: "12px", // Set smaller font size
                          width: "100%",    // Makes input full-width
                          border: "1px solid #D1D5DB", // Keeps border even when hovering
                        }}
                        buttonStyle={{
                          width: "60px",   // Increased width for flag
                          paddingLeft: "10px",
                          alignItems: "center",
                          justifyContent: "center",
                        }}
                        enableSearch
                        countryCodeEditable={false} // Prevents manual editing of country code
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="group_id" // Make sure this matches the schema
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Group</FormLabel>
                    <Select 
                      onValueChange={(value) => field.onChange(value)} 
                      value={field.value} // Ensures selected value is displayed
                    > 
                      <SelectTrigger>
                        <SelectValue placeholder="Select Group" />
                      </SelectTrigger>
                      <SelectContent>
                        {groupData.map((data_val) => (
                          <SelectItem key={data_val.mgm_id} value={String(data_val.mgm_id)}>
                            {data_val.group_name}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />


              {!userId && (
                <FormField control={form.control} name="password" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Password</FormLabel>
                    <FormControl><Input {...field} type="password" /></FormControl>
                    <FormMessage />
                  </FormItem>
                )} />
              )}

              <FormField control={form.control} name="status" render={({ field }) => (
                <FormItem>
                  <FormLabel>Status</FormLabel>
                  <Select onValueChange={field.onChange} defaultValue={field.value}>
                    <SelectTrigger><SelectValue placeholder="Select status" /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="Active">Active</SelectItem>
                      <SelectItem value="Inactive">Inactive</SelectItem>
                    </SelectContent>
                  </Select>
                  <FormMessage />
                </FormItem>
              )} />

              <FormField control={form.control} name="emailVerified" render={({ field }) => (
                <FormItem className="flex items-center gap-2">
                  <FormLabel>Email Verified</FormLabel>
                  <FormControl><Switch checked={field.value} onCheckedChange={field.onChange} /></FormControl>
                  <FormMessage />
                </FormItem>
              )} />
          </div>
          <div className="flex items-center justify-center mt-5">
              <Button type="submit" disabled={form.formState.isSubmitting} className="w-1/12 mr-4">
                {form.formState.isSubmitting ? "Processing..." : userId ? "Update User" : "Add User"}
              </Button>
              <LinkAndScroll href={back_link} className="w-1/12  ">
                    <Button type="button" className="bg-black hover:bg-primary w-full">{"Discard"}</Button>
                </LinkAndScroll>
              </div> 
            </form>
          </Form>
        </CardContent>
      </Card>
    </div>
  );
}