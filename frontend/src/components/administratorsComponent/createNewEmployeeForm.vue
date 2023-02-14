<template>
     <Form @submit="$emit('addEmployee-submit', newemployee)" :validation-schema="schema"
          class="container-fluid createEmployeeForm">
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fa fa-plus-circle"> </span> Thêm nhân viên mới
               </p>
          </div>
          <div class="row  content">
               <div class="col-md-6">
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
                         <Field name="idCardNumber" class="form-control"
                              v-model="newemployee.Employee_identityCardNumber" placeholder="Nhập số CMND/CCCD" />
                         <ErrorMessage name="idCardNumber" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="birthDate" class="mt-3">Ngày sinh</label>
                         <Field name="birthDate" class="form-control" v-model="newemployee.Employee_birthDate"
                              placeholder="Ngày sinh">
                              <datepicker  :enable-time-picker="false" :value="newemployee.Employee_birthDate" :hide-input-icon="true"
                                   v-model="newemployee.Employee_birthDate" placeholder="YYYY-MM-DD">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="birthDate" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="major" class="mt-3">Chuyên môn</label>
                         <Field name="major" class="form-control" v-model="newemployee.Employee_major"
                              placeholder="Nhập chuyên môn" />
                         <ErrorMessage name="major" class="error-feedback" />
                    </div>
                    <div class="form-group">
                         <label for="sex" class="mt-3">Giới tính: &nbsp;</label><br>
                         <Field name="sex" class="form-control" placeholder="" v-model="newemployee.Employee_sex">
                              <input type="radio" id="nam" value="true" class="mt-4"
                                   v-model="newemployee.Employee_sex" />
                              <label for="one" class="mt-3"> &nbsp;Nam &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                              <input type="radio" id="nu" value="false" class="mt-4"
                                   v-model="newemployee.Employee_sex" />
                              <label for="two" class="mt-3"> &nbsp;Nữ</label>
                         </Field>
                         <ErrorMessage name="gioitinhNV" class="error-feedback" />
                    </div>
               </div>
               <div class="col-md-6">
                    <div class="form-group">
                         <label for="phoneNumber" class="mt-2">Số điện thoại</label>
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
                         <label for="address" class="mt-3">Địa chỉ</label>
                         <Field name="address" class="form-control" v-model="newemployee.Employee_address"
                              placeholder="Nhập địa chỉ" />
                         <ErrorMessage name="address" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="password" class="mt-3">Mật khẩu</label>
                         <Field name="password" class="form-control" v-model="newemployee.Employee_password"
                              placeholder="Nhập mật khẩu tài khoản" />
                         <ErrorMessage name="password" class="error-feedback" />
                    </div>
                    <div class="form-group">
                         <label for="role" class="mt-3">Chức vụ &nbsp; </label><br>
                         <Field name="role" class="form-control" v-model="newemployee.Role_id" placeholder="Chức vụ: ">
                              <select v-model="newemployee.Role_id" class="selectBox ">
                                   <option selected style="font-size:17px">Quản lý</option>
                                   <option>Chuyên gia</option>
                                   <option>Nhân viên</option>
                              </select>
                         </Field>
                         <ErrorMessage name="role" class="error-feedback" />
                    </div>
                    <!-- <div class="form-group">
                         <label for="lock">Tài khoản: &nbsp; </label><br>
                         <Field name="lock" class="form-control" v-model="newemployee.NV_KhoaTaiKhoan">
                              <input type="radio" id="mokhoa" value="false" v-model="newemployee.NV_KhoaTaiKhoan"
                                   @click="setKhoaTaiKhoan(false)" />
                              <label for="one">Mở khóa &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>

                              <input type="radio" id="khoa" value="true" v-model="newemployee.NV_KhoaTaiKhoan"
                                   @click="setKhoaTaiKhoan(true)" />
                              <label for="two">Khóa</label>
                         </Field>
                         <ErrorMessage name="lock" class="error-feedback" />
                    </div> -->
               </div>
          </div>
          <div class="form-group">
               <div class="row">
                    <div class="col-sm-4"></div>
                    <div class="col-sm-4">
                         <span v-if="message2 == 'Thêm thành công'" class="fas fa-check-circle"
                              style="color:#00BA13; text-align: center;"></span>
                         <span v-if="message1 == 'Thêm không thành công'" class="fas fa-times-circle"
                              style="color:red; text-align: center;"></span>
                         <p v-if="message2 == 'Thêm thành công'" class="textMessage2" style="color:#00BA13; text-align: center;">{{message2}}</p>
                         <p v-if="message2 == 'Thêm không thành công.'" class="textMessage1" style="text-align: center;">{{ message1 }}</p>
                    </div>
                    <div class="col-sm-4"></div>
               </div>
               <div class="row">
                    <div class="col-sm-5"></div>
                    <button class="btn btn-outline-secondary btnLuu col-sm-2">Lưu</button>
                    <div class="col-sm-5"></div>
               </div>
          </div>
     </form>

</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
export default {
     name: "NhanVienFormThem",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["addEmployee-submit"],
     props: ["newEmployee", "message1", "message2"],
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
                    .date()
                    .required("Ngày sinh phải có giá trị"),
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
                    .string()
                    .required("Mật khẩu tài khoản phải có giá trị")
                    .min(8, "Mật khẩu có ít nhất 8 ký tự"),
               role: yup
                    .string()
                    .required("Loại nhân viên phải được chọn"),
               sex: yup
                    .boolean()
                    .required("Giới tính nhân viên được yêu cầu"),
               major: yup
                    .string()
                    .required("Chuyên môn phải có giá trị"),
               // lock: yup
               // .boolean()
               // .required("Trạng thái tài khoản nhân viên được yêu cầu"),
          });
          return {
               newemployee: this.newEmployee,
               schema,
          };
     },

     methods: {


          // async setKhoaTaiKhoan(data) {
          //      this.newemployee.NV_KhoaTaiKhoan = data;
          //      console.log(this.newemployee.NV_KhoaTaiKhoan);
          // },
     }
};
</script>
 
<style>
@import url(../../assets/employeeStyle.css);
</style>