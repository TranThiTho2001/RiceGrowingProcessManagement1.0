<template>
     <Form @submit="newfertilixer.close = true, $emit('updateFertilizer-submit', newfertilixer)" :validation-schema="schema"
          class="container updateFertilizerForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times" @click="newfertilixer.close = false, $emit('updateFertilizer-submit', newfertilixer)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fas fa-edit actionIcon"></span> Cập nhật thông tin phân bón
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-12">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã phân bón</label>
                         <Field name="id" type="name" class="form-control" v-model="newfertilixer.Fertilizer_id"
                              placeholder="Nhập mã phân bón..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="name" class="mt-3">Tên phân bón</label>
                         <Field name="name" class="form-control" v-model="newfertilixer.Fertilizer_name"
                              placeholder="Nhập tên phân bón..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="supplier" class="mt-3">Nhà cung cấp</label>
                         <Field name="supplier" class="form-control" v-model="newfertilixer.Fertilizer_supplier"
                              placeholder="Nhà cung cấp phân bón..." />
                         <ErrorMessage name="supplier" class="error-feedback" />
                    </div>

               </div>
          </div>

          <div class="row ">
               <div class="col-sm-2"></div>
               <div class="col-sm-8 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Cập nhật thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Cập nhật thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;"> 
                         {{ message2 }}</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }} </span>
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
     name: "updateFertilizerForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["updateFertilizer-submit"],
     props: ["newFertilizer", "message1", "message2"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã phân bón phải có giá trị")
                    .min(10, "Mã phân bón phải gồm 10 ký tự")
                    .max(10, "Mã phân bón phải gồm 10 ký tự"),
               name: yup
                    .string()
                    .required("Tên phân bón phải có giá trị"),
               supplier: yup
                    .string()
                    .required("Nhà cung cấp phân bón phải có giá trị"),
          });
          return {
               newfertilixer: this.newFertilizer,
               schema,
          };
     },

     methods: {

     }
};
</script>
 
<style>
@import url(../../assets/fertilizerStyle.css);
</style>