<template>
     <Form @submit="newemployee.close = true, $emit('updateEmployee-submit', newemployee)" :validation-schema="schema"
          class="form container-fluid updateEmployeeForm">

          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times" @click="newemployee.close = false, $emit('updateEmployee-submit', newemployee)"
                         style="font-size: 25px; "></i>
               </div>
          </div>

          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fa fa-plus-circle"> </span> CẬP NHẬT THÔNG TIN NHÂN VIÊN
               </p>
          </div>

          <div class="row content">
               <div class="col-md-4">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã</label>
                         <Field name="id" type="name" class="form-control" v-model="newemployee.Employee_id"
                              placeholder="Nhập mã nhân viên" />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="name" class="mt-3">Họ và tên nhân viên</label>
                         <Field name="name" class="form-control" v-model="newemployee.Employee_name"
                              placeholder="Nhập họ nhân viên" />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="idCardNumber" class="mt-3">Số CMND/CCCD</label>
                         <Field name="idCardNumber" class="form-control" v-model="newemployee.Employee_identityCardNumber"
                              placeholder="Nhập số CMND/CCCD" />
                         <ErrorMessage name="idCardNumber" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="birthDate" class="mt-3">Ngày sinh</label>
                         <Field name="birthDate" class="form-control" v-model="newemployee.Employee_birthDate"
                              placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newemployee.Employee_birthDate"
                                   :hide-input-icon="true" v-model="newemployee.Employee_birthDate" placeholder="DD-MM-YYYY"
                                   format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="birthDate" class="error-feedback" />
                    </div>

               </div>
               <div class="col-md-4">
                    <div class="form-group">
                         <label for="major" class="mt-2">Chuyên môn</label>
                         <Field name="major" class="form-control" v-model="newemployee.Employee_major"
                              placeholder="Nhập chuyên môn" />
                         <ErrorMessage name="major" class="error-feedback" />
                    </div>
                    <div class="form-group">
                         <label for="phoneNumber" class="mt-3">Số điện thoại</label>
                         <Field name="phoneNumber" class="form-control" v-model="newemployee.Employee_phoneNumber"
                              placeholder="Nhập số điện thoại" />
                         <ErrorMessage name="phoneNumber" class="error-feedback" />
                    </div>
                    <div class="form-group">
                         <label for="email" class="mt-3">Email</label>
                         <Field name="email" class="form-control" v-model="newemployee.Employee_email"
                              placeholder="Nhập địa chỉ Email" />
                         <ErrorMessage name="email" class="error-feedback" />
                    </div>
                    <div class="form-group">
                         <label for="sex" class="mt-3">Giới tính: &nbsp;</label><br>
                         <Field name="sex" class="form-control" placeholder="" v-model="newemployee.Employee_sex">
                              <input type="radio" id="nam" value="Nam"
                                   v-model="newemployee.Employee_sex" />
                              <label for="one" class="labelInput" > &nbsp;Nam&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
                              <input type="radio" id="nu" value="Nữ"
                                   v-model="newemployee.Employee_sex" />
                              <label for="two" class="labelInput" > &nbsp;Nữ</label>
                         </Field>
                         <ErrorMessage name="sex" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-4">
                    <div class="form-group">
                         <label for="address" class="mt-2">Địa chỉ</label>
                         <Field name="address" class="form-control" v-model="newemployee.Employee_address"
                              placeholder="Nhập địa chỉ" />
                         <ErrorMessage name="address" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="role" class="mt-3">Chức vụ &nbsp; </label><br>
                         <Field name="role" class="form-control" v-model="newemployee.Role_name" placeholder="Chức vụ: ">
                              <select v-model="newemployee.Role_name" class="selectBox ">
                                   <option v-for="(role,i) in roleList" :key="i">
                                        {{ role.Role_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="role" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="password" class="">Mật khẩu</label>
                         <Field name="password" class="form-control" v-model="newemployee.Employee_password"
                              placeholder="Nhập mật khẩu tài khoản" />
                         <ErrorMessage name="password" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="lock" class="mt-3">Tài khoản: &nbsp; </label><br>
                         <Field name="lock" class="form-control" v-model="newemployee.Employee_lockAccount">
                              <input type="radio" id="mokhoa" value="1" v-model="newemployee.Employee_lockAccount" />
                              <label for="one" class="labelInput" >Mở khóa &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>

                              <input type="radio" id="khoa" value="0" v-model="newemployee.Employee_lockAccount" />
                              <label for="two" class="labelInput" >Khóa</label>
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
import { Form, Field, ErrorMessage } from "vee-validate";
import Datepicker from '@vuepic/vue-datepicker';
// import EmployeeService from '../../services/employee.service';
// import moment from 'moment';
import '@vuepic/vue-datepicker/dist/main.css';
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
               //      .required()
               //      .nullable()
               //      .transform(v => (v instanceof Date && !isNaN(v) ? v : null)),
               // .required("Ngày sinh phải có giá trị"),
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
     --dp-background-color: #FAFAFC;
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
</style>