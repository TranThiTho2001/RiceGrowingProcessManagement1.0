<template>
     <Form @submit="newfertilixer.close = true, $emit('updateFertilizer-submit', newfertilixer)" :validation-schema="schema"
          class="form container-fluid updateFertilizerForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times"
                         @click="newfertilixer.close = false, $emit('updateFertilizer-submit', newfertilixer)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fas fa-edit actionIcon"></span> 
                    CẬP NHẬT THÔNG TIN PHÂN BÓN
               </p>
          </div>
          <div class="row content">
               <div class="col-md-4">
                    <div class="form-group">
                         <label for="id" class="mt-3">Mã phân bón <span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newfertilixer.Fertilizer_id"
                              placeholder="Nhập mã phân bón..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="components" class="mt-3">Thành phần <span style="color: red">*</span></label>
                         <Field name="components" class="form-control" v-model="newfertilixer.Fertilizer_component"
                              as="textarea" style="height: 240px;" placeholder="Thông tin phân bón..." />
                         <ErrorMessage name="components" class="error-feedback" />
                    </div>
               </div>
               <div class="col-md-4">
                    <div class="form-group">
                         <label for="name" class="mt-3">Tên phân bón <span style="color: red">*</span></label>
                         <Field name="name" class="form-control" v-model="newfertilixer.Fertilizer_name"
                              placeholder="Nhập tên phân bón..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="uses" class="mt-3">Công dụng <span style="color: red">*</span></label>
                         <Field name="uses" class="form-control" v-model="newfertilixer.Fertilizer_uses" as="textarea"
                              style="height: 240px;" placeholder="Công dụng phân bón..." />
                         <ErrorMessage name="uses" class="error-feedback" />
                    </div>

               </div>

               <div class="col-md-4">
                    <div class="form-group">
                         <label for="supplier" class="mt-3">Nhà cung cấp <span style="color: red">*</span></label>
                         <Field name="supplier" class="form-control" v-model="newfertilixer.Fertilizer_supplier"
                              placeholder="Nhà cung cấp phân bón..." />
                         <ErrorMessage name="supplier" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="directionsForUse" class="mt-3">Hướng dẫn sử dụng<span style="color: red">*</span></label>
                         <Field name="directionsForUse" class="form-control" v-model="newfertilixer.Fertilizer_directionsForUse"
                              as="textarea" style="height: 240px;" placeholder="Thông tin phân bón..." />
                         <ErrorMessage name="directionsForUse" class="error-feedback" />
                    </div>
               </div>
          </div>

          <div class="row ">
               <div class="col-sm-12 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Cập nhật thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Cập nhật thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">Cập
                         nhật thông tin phân bón thành công</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2">Cập nhật thông tin
                         phân bón không thành công
                    </span>
               </div>
          </div>
          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu col-sm-2">Cập Nhật</button>
               </div>
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
               components: yup
                    .string()
                    .required("Thành phần phân bón phải có giá trị"),
               uses: yup
                    .string()
                    .required("Công dụng phân bón phải có giá trị"),
               directionsForUse: yup
                    .string()
                    .required("Hưỡng dẫn sử dụng phân bón phải có giá trị")
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
@import url(../../assets/fertilizerStyle.css);</style>