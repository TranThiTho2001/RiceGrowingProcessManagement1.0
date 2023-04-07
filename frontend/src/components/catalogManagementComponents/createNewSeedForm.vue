<template>
     <Form @submit="newseed.close = true, $emit('addSeed-submit', newseed)" :validation-schema="schema"
          class="form container createSeedForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times" @click="newseed.close = false, $emit('addSeed-submit', newseed)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fa fa-plus-circle"> </span> Thêm giống lúa mới
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-12">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã <span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newseed.Seed_id"
                              placeholder="Nhập mã giống lúa" />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="name" class="mt-3">Tên <span style="color: red">*</span></label>
                         <Field name="name" class="form-control" v-model="newseed.Seed_name"
                              placeholder="Nhập tên giống lúa" />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="supplier" class="mt-3">Nhà cung cấp<span style="color: red">*</span></label>
                         <Field name="supplier" class="form-control" v-model="newseed.Seed_supplier"
                              placeholder="Nhà cung cấp giống lúa" />
                         <ErrorMessage name="supplier" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="characteristic" class="mt-3">Đặc tính <span style="color: red">*</span></label>
                         <Field name="characteristic" class="form-control" v-model="newseed.Seed_characteristic"
                              placeholder="Đặc tính giống lúa" as="textarea" style="height: 120px;" />
                         <ErrorMessage name="characteristic" class="error-feedback" />
                    </div>
               </div>
          </div>

          <div class="row ">
               <div class="col-sm-12 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         Thêm giống lúa mới thành công</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2">Thêm giống lúa mới không
                         thành công. Vui lòng thử lại sau</span>
               </div>
          </div>
          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu">Lưu</button>
               </div>
          </div>

     </form>
</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";

export default {
     name: "NhanVienFormThem",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["addSeed-submit"],
     props: ["newSeed", "message1", "message2", "open"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã giống lúa phải có giá trị")
                    .min(10, "Mã giống lúa phải gồm 10 ký tự")
                    .max(10, "Mã giống lúa phải gồm 10 ký tự"),
               name: yup
                    .string()
                    .required("Tên giống lúa phải có giá trị"),
               characteristic: yup
                    .string()
                    .required("Đặc tính của giống lúa phải có giá trị"),
               supplier: yup
                    .string()
                    .required("Nhà cung cấp giống lúa phải có giá trị"),
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
@import url(../../assets/mainStyle.css);
</style>