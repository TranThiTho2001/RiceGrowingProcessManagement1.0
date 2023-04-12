<template>
     <Form @submit="newarableLand.close = true, $emit('updateArableLand-submit', newarableLand)" :validation-schema="schema"
          class="form  container updateArableLandForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times"
                         @click="newarableLand.close = false, $emit('updateArableLand-submit', newarableLand)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fas fa-edit actionIcon"></span> 
                    CẬP NHẬT THÔNG TIN MẪU RUỘNG
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-6 mt-2">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã mẫu ruộng <span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newarableLand.ArableLand_id"
                              placeholder="Nhập mã mẫu ruộng..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="area" class="mt-3">Diện tích (đơn vị ha) <span style="color: red">*</span></label>
                         <Field name="area" class="form-control" v-model="newarableLand.ArableLand_area"
                              placeholder="Diện tích..." />
                         <ErrorMessage name="area" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="soil" class="mt-3">Phân loại <span style="color: red">*</span></label>
                         <Field name="soil" v-model="newarableLand.Soil_name" style="width: 100%; position: relative;">
                              <select class="form-control" v-model="newarableLand.Soil_name" name="soil" for="soil"
                                   style=" width: 100%;">
                                   <option v-for="(soil, i) in soillist" :key="i">{{ soil.Soil_name }}</option>
                              </select>
                         </Field>
                         <ErrorMessage name="soil" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="owner" class="">Chủ sở hữu <span style="color: red">*</span></label>
                         <Field name="owner" class="form-control" v-model="newarableLand.ArableLand_owner"
                              placeholder="Chủ sở hữu..." />
                         <ErrorMessage name="owner" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-6">
                    <div class="form-group">
                         <label for="latitude" class="mt-3">Vĩ độ <span style="color: red">*</span></label>
                         <Field name="latitude" class="form-control" v-model="newarableLand.ArableLand_latitude"
                              placeholder="Vĩ độ..." />
                         <ErrorMessage name="latitude" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="longitude" class="mt-3">Kinh độ <span style="color: red">*</span></label>
                         <Field name="longitude" class="form-control" v-model="newarableLand.ArableLand_longitude"
                              placeholder="Kinh độ..." />
                         <ErrorMessage name="longitude" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="province" class="mt-3">Tỉnh<span style="color: red">*</span></label>
                         <Field name="province" v-model="newarableLand.Province_name"
                              style="width: 100%; position: relative;">
                              <select class="form-control" v-model="newarableLand.Province_name" name="province"
                                   for="province" @change="select()" style=" width: 100%;">
                                   <option v-for="(province, i) in provincelist" :key="i">{{ province.Province_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="province" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="location" class="">Vị trí mẫu ruộng <span style="color: red">*</span></label>
                         <Field name="location" class="form-control" v-model="newarableLand.ArableLand_location"
                              placeholder="Nhập vị trí mẫu ruộng..." />
                         <ErrorMessage name="location" class="error-feedback" />
                    </div>
               </div>
          </div>

          <div class="row ">
               <div class="col-sm-12 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Cập nhật thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Cập nhật thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         Cập nhật thông tin mẫu ruộng thành công</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2">Cập nhật thông tin
                         mẫu ruộng không thành công
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
     name: "updateArableLandForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["updateArableLand-submit"],
     props: ["newArableLand", "message1", "message2", "provinceList", "soilList"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã mẫu ruộng phải có giá trị")
                    .min(10, "Mã phải gồm 10 ký tự")
                    .max(10, "Mã mẫu ruộng phải gồm 10 ký tự"),
               location: yup
                    .string()
                    .required("Vị trí mẫu ruộng phải có giá trị"),
               area: yup
                    .number()
                    .required("Diện tích mẫu ruộng phải có giá trị"),
               owner: yup
                    .string()
                    .required("Chủ sở hữu mẫu ruộng phải có giá trị"),
               soil: yup
                    .string()
                    .required("Loại đất phải có giá trị"),
               latitude: yup
                    .string()
                    .required("Vĩ độ của mẫu ruộng phải có giá trị"),
               longitude: yup
                    .string()
                    .required("Kinh độ của mẫu ruộng phải có giá trị"),
               province: yup
                    .string()
                    .required("Tỉnh phải được chọn"),
          });
          return {
               newarableLand: this.newArableLand,
               provincelist: this.provinceList,
               soillist: this.soilList,
               schema,
          };
     },

     methods: {

     }
};
</script>
 
<style>@import url(../../assets/arablelandStyle.css);</style>