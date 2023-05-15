<template>
     <Form @submit="newemployee.close = true, $emit('updateEmployee-submit', newemployee)" :validation-schema="schema"
          class="form container-fluid updateEmployeeForm">

          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle btnClose" @click="newemployee.close = false, $emit('updateEmployee-submit', newemployee)"
                    style="font-size: 30px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>

          <div class="row">
               <p class="col-sm-12 text-center functionName">CẬP NHẬT THÔNG TIN NHÂN VIÊN</p>
          </div>

          <div class="row content">
               <div class="col-lg-4">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã <span style="color:red">*</span></label>
                         <Field name="id" type="name" class="form-control-none-bg form-control" v-model="newemployee.Employee_id"
                              placeholder="Nhập mã nhân viên" disabled />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="name" class="mt-3">Họ và tên nhân viên <span style="color:red">*</span></label>
                         <Field name="name" class="form-control" v-model="newemployee.Employee_name"
                              placeholder="Nhập họ nhân viên" />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="idCardNumber" class="mt-3">Số CMND/CCCD <span style="color:red">*</span></label>
                         <Field name="idCardNumber" class="form-control"
                              v-model="newemployee.Employee_identityCardNumber" placeholder="Nhập số CMND/CCCD" />
                         <ErrorMessage name="idCardNumber" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="birthDate" class="mt-3">Ngày sinh <span style="color:red">*</span></label>
                         <Field name="birthDate" class="form-control" v-model="newemployee.Employee_birthDate" style="background-color: antiquewhite !important; "
                              placeholder="Ngày sinh">
                              <datepicker  :enable-time-picker="false" :value="newemployee.Employee_birthDate" :hide-input-icon="true" 
                                   v-model="newemployee.Employee_birthDate"  format="dd-MM-yyyy" :clearable="false" >
                              </datepicker>
                              <label v-if="newemployee.Employee_birthDate == null"><i style="color: #959595; position: absolute;z-index: 1; left: 5%; margin-top:8px;" class="far fa-calendar-alt" ></i></label>
                         </Field>
                         
                         <ErrorMessage name="birthDate" class="error-feedback" />
                    </div>
               </div>

               <div class="col-lg-4">
                    <div class="form-group">
                         <label for="major" class="mt-2">Chuyên môn <span style="color:red">*</span></label>
                         <Field name="major" class="form-control" v-model="newemployee.Employee_major"
                              placeholder="Nhập chuyên môn" />
                         <ErrorMessage name="major" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="phoneNumber" class="mt-3">Số điện thoại <span style="color:red">*</span></label>
                         <Field name="phoneNumber" class="form-control" v-model="newemployee.Employee_phoneNumber"
                              placeholder="Nhập số điện thoại" />
                         <ErrorMessage name="phoneNumber" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="email" class="mt-3">Email <span style="color:red">*</span></label>
                         <Field name="email" class="form-control" v-model="newemployee.Employee_email"
                              placeholder="Nhập địa chỉ Email" />
                         <ErrorMessage name="email" class="error-feedback" />
                    </div>

                    <div class="form-group mt-4" >
                         <label for="sex" class="mt-3" style="margin-top: 52px !important; ">Giới tính<span style="color:red">*</span>: &nbsp;</label><br>
                         <Field name="sex" class="form-control" placeholder="" v-model="newemployee.Employee_sex">
                              <input type="radio" id="nam" value="Nam" class=""  style="margin-top: 59px;"
                                   v-model="newemployee.Employee_sex" />
                              <label for="one" class="labelInput" style="margin-top: 38px ;"> &nbsp;Nam&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                              <input type="radio" id="nu" value="Nữ" style="margin-top: 59px;"
                                   v-model="newemployee.Employee_sex" />
                              <label for="two" class="labelInput" style="margin-top: 38px "> &nbsp;Nữ</label>
                         </Field>
                         <ErrorMessage name="sex" class="error-feedback" />
                    </div>
               </div>

               <div class="col-lg-4">
                    <div class="form-group">
                         <label for="address" class="mt-2">Địa chỉ <span style="color:red">*</span></label>
                         <Field name="address" class="form-control" v-model="newemployee.Employee_address"
                              placeholder="Nhập địa chỉ" />
                         <ErrorMessage name="address" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="role" class="mt-3">Vị trí <span style="color:red">*</span> &nbsp; </label><br>
                         <Field name="role" class="form-control" v-model="newemployee.Role_name" placeholder="Chức vụ: ">
                              <select v-model="newemployee.Role_name" class="selectBox" style="background:  #F0F2F7; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);">
                                   <option class="" v-for="(role,i) in roleList" :key="i">
                                        {{ role.Role_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="role" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="password" class="">Mật khẩu <span style="color:red">*</span></label>
                         <Field name="password" class="form-control" v-model="newemployee.Employee_password"
                              placeholder="Nhập mật khẩu tài khoản" />
                         <ErrorMessage name="password" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="lock" class="mt-3" style="margin-top: 52px !important;">Tài khoản<span style="color:red">*
                         </span>: &nbsp; </label><br>
                         <Field name="lock" class="form-control" v-model="newemployee.Employee_lockAccount">
                              <input type="radio" id="mokhoa" value="1" v-model="newemployee.Employee_lockAccount" 
                              style="margin-top: 59px;" />
                              <label for="one" class="labelInput" style="margin-top: 37px;">Mở khóa &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>

                              <input type="radio" id="khoa" value="0" v-model="newemployee.Employee_lockAccount"
                              style="margin-top: 59px;" />
                              <label for="two" class="labelInput" style="margin-top: 37px;">Khóa</label>
                         </Field>
                         <ErrorMessage name="lock" class="error-feedback" />
                    </div>
               </div>
          </div>

          <div class="form-group">
               <div class="row">
                    <div class="col-sm-12 mt-2 mb-3 text-center">
                         <span v-if="message2 == 'Cập nhật thành công.'" class="fas fa-check-circle"
                              style="color:#00BA13; text-align: center;"></span>
                         <span v-if="message1 == 'Cập nhật không thành công.'" class="fas fa-times-circle "
                              style="color:red; text-align: center;"></span>
                         <p v-if="message2 == 'Cập nhật thành công.'" class="textMessage2" style="color:#00BA13;">Cập nhật thông tin người dùng thành công</p>
                         <p v-if="message2 == 'Cập nhật không thành công.'" class="textMessage1">Cập nhật thông tin người dùng không thành công</p>
                    </div>
               </div>

               <div class="row">
                    <div class="col-sm-5"></div>
                    <button class="btn btn-outline-secondary btnLuu col-sm-2"
                         @click="$emit('updateEmployee-submit', newemployee)">Cập Nhật</button>
                    <div class="col-sm-5"></div>
               </div>
          </div>
     </Form>
</template>
 
<script>
import * as yup from "yup";
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import { Form, Field, ErrorMessage } from "vee-validate";

export default {
     name: "updateEmpployeeForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["updateEmployee-submit"],
     props: ["newEmployee", "message1", "message2", "roleList"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã nhân viên phải có giá trị")
                    .min(8, "Mã nhân viên phải gồm 8 ký tự")
                    .max(8, "Mã nhân viên phải gồm 8 ký tự"),
               name: yup
                    .string()
                    .required("Họ nhân viên phải có giá trị"),
               idCardNumber: yup
                    .string()
                    .required("Số CMND/CCCD phải có giá trị")
                    .max(12, "Số CMND/CCCD có nhiều nhất 12 ký tự"),
               birthDate: yup
                    .date(),
               phoneNumber: yup
                    .string()
                    .required("Số điện thoại phải có giá trị")
                    .matches(/^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$/, 'Số điện thoại không hợp lệ'),
               email: yup
                    .string()
                    .matches(/^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$/, "Email phải đúng định dạng")
                    .required("Email phải có giá trị"),
               address: yup
                    .string()
                    .required("Địa chỉ phải có giá trị"),
               password: yup
                    .string(),
               role: yup
                    .string()
                    .required("Loại nhân viên phải được chọn"),
               sex: yup
                    .string()
                    .required("Giới tính nhân viên được yêu cầu"),
               major: yup
                    .string()
                    .required("Chuyên môn phải có giá trị"),
               lock: yup
               .number()
               .required("Trạng thái tài khoản nhân viên được yêu cầu"),
          });
          return {
               newemployee: this.newEmployee,
               schema,
          };
     },

     methods: {

     },


};
</script>
 
<style>
@import url(../../assets/employeeStyle.css);
.dp__theme_light {
     --dp-background-color: #F0F2F7;
     --dp-border-radius: 10px;
     --dp-text-color: #2F3033;
     --dp-hover-color: #f3f3f3;
     --dp-hover-text-color: #212121;
     --dp-hover-icon-color: #959595;
     --dp-primary-color: #1976d2;
     --dp-primary-disabled-color: #6bacea;
     --dp-primary-text-color: #f8f5f5;
     --dp-secondary-color: #c0c4cc;
     --dp-border-color: #ddd;
     --dp-menu-border-color: #ddd;
     --dp-border-color-hover: #aaaeb7;
     --dp-disabled-color: #f6f6f6;
     --dp-scroll-bar-background: #f3f3f3;
     --dp-scroll-bar-color: #959595;
     --dp-success-color: #76d275;
     --dp-success-color-disabled: #a3d9b1;
     --dp-icon-color: #959595;
     --dp-danger-color: #ff6f60;
     --dp-marker-color: #ff6f60;
     --dp-tooltip-color: #fafafa;
     --dp-disabled-color-text: #8e8e8e;
     --dp-highlight-color: rgb(25 118 210 / 10%);
}

.dp__input {
     background-color: var(--dp-background-color);
     border-radius: 10px !important;
     font-family: 'Roboto';
     font-style: normal;
     font-size: 18px;
     font-weight: 500;
     border: 1px solid var(--dp-border-color);
     outline: none;
     transition: border-color .2s cubic-bezier(0.645, 0.045, 0.355, 1);
     width: 100%;
     height: 80%;
     font-size: 1rem;
     line-height: 1.5rem;
     padding: 6px 12px;
     color: var(--dp-text-color);
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     box-sizing: border-box;
}

.updateEmployeeForm .selectBox{
     height: 35px;
      border: 1px solid #ced4da;
      border-radius: 4px;
      background: #FAFAFC;
      box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
      border-radius: 10px;
      color: #2F3033;
      font-family: 'Roboto';
      font-style: normal;
      font-weight: 500;
      font-size: 17px;
}
</style>