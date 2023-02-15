<template>
     <Form @submit="$emit('addSeed-submit', newseed)" :validation-schema="schema"
          class="container-fluid createSeedForm">
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fa fa-plus-circle"> </span> Thêm nhân viên mới
               </p>
          </div>
          <div class="row  content">
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
          </div>
          <div class="form-group">
               <div class="row">
                    <div class="col-sm-3"></div>
                    <div class="col-sm-6 mt-2 mb-3">
                         <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                              style="color:#00BA13; text-align: center;"></span>
                         <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                              style="color:red; text-align: center;"></span>
                         <p v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">{{message2}}</p>
                         <p v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2">{{ message1 }} Mã nhân viên đã tồn tại</p>
                    </div>
                    <div class="col-sm-3"></div>
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
import '@vuepic/vue-datepicker/dist/main.css';
export default {
     name: "NhanVienFormThem",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["addSeed-submit"],
     props: ["newSeed", "message1", "message2"],
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
                    .string()
                    .required("Ngày sinh phải có giá trị"),
          });
          return {
               newseed: this.newSeed,
               schema,
          };
     },

     methods: {
     }
};
</script>
 
<style>
@import url(../../assets/seedStyle.css);
</style>