<template>
     <Form @submit="newpesticide.close = true, $emit('addPesticide-submit', newpesticide)" :validation-schema="schema"
          class="container createPesticideForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times" @click="newpesticide.close = false, $emit('addPesticide-submit', newpesticide)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fas fa-edit actionIcon"></span> Tạo thuốc trị bệnh dịch mới
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-12">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã thuốc</label>
                         <Field name="id" type="name" class="form-control" v-model="newpesticide.Pesticide_id"
                              placeholder="Nhập mã thuốc..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="name" class="mt-3">Tên thuốc</label>
                         <Field name="name" class="form-control" v-model="newpesticide.Pesticide_name"
                              placeholder="Nhập tên thuốc..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="supplier" class="mt-3">Nhà cung cấp</label>
                         <Field name="supplier" class="form-control" v-model="newpesticide.Pesticide_supplier"
                              placeholder="Nhà cung cấp thuốc..." />
                         <ErrorMessage name="supplier" class="error-feedback" />
                    </div>

               </div>
          </div>

          <div class="row ">
               <div class="col-sm-2"></div>
               <div class="col-sm-8 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;"> 
                         {{ message2 }}</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }} </span>
               </div>
               <div class="col-sm-2"></div>
          </div>
          <div class="row mb-4">
               <div class="col-sm-5"></div>
               <button class="btn btn-outline-secondary btnLuu col-sm-2">Lưu</button>
               <div class="col-sm-5"></div>
          </div>

     </form>

</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";

export default {
     name: "createPesticideForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["addPesticide-submit"],
     props: ["newPesticide", "message1", "message2"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã thuốc trị bệnh dịch phải có giá trị")
                    .min(10, "Mã thuốc trị bệnh dịch phải gồm 10 ký tự")
                    .max(10, "Mã thuốc trị bệnh dịch phải gồm 10 ký tự"),
               name: yup
                    .string()
                    .required("Tên thuốc trị bệnh dịch phải có giá trị"),
               supplier: yup
                    .string()
                    .required("Nhà cung cấp thuốc trị bệnh dịch phải có giá trị"),
          });
          return {
               newpesticide: this.newPesticide,
               schema,
          };
     },

     methods: {

     }
};
</script>
 
<style>
@import url(../../assets/pesticideStyle.css);
</style>