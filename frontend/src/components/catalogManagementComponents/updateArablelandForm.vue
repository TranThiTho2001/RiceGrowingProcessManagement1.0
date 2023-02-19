<template>
     <Form @submit="newarableLand.close = true, $emit('updateArableLand-submit', newarableLand)" :validation-schema="schema"
          class="container updateArableLandForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times"
                         @click="newarableLand.close = false, $emit('updateArableLand-submit', newarableLand)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fas fa-edit actionIcon"></span> Tạo mẫu ruộng
                    mới
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
                         <Field name="soil" v-model="newarableLand.Soil_id">
                              <select class="form-control" v-model="newarableLand.Soil_id" name="soil" for="soil">
                                   <option>Đất phù sa ven sông</option>
                                   <option>Đất phù sa xa xông</option>
                                   <option>Đất nhiễm phèn</option>
                                   <option>Đất nhiễm mặn</option>
                                   <option>Đất nhiễm mặn + phèn</option>
                              </select>
                         </Field>
                         <ErrorMessage name="soil" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-6">

                    <div class="form-group">
                         <label for="owner" class="mt-3">Chủ sở hữu <span style="color: red">*</span></label>
                         <Field name="owner" class="form-control" v-model="newarableLand.ArableLand_owner"
                              placeholder="Chủ sở hữu..." />
                         <ErrorMessage name="owner" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="location" class="mt-3">Vị trí mẫu ruộng <span style="color: red">*</span></label>
                         <Field name="location"  class="form-control" v-model="newarableLand.ArableLand_location"
                              placeholder="Nhập vị trí mẫu ruộng..." as="textarea" style="height: 126px;"/>
                         <ErrorMessage name="location" class="error-feedback" />
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
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }}
                    </span>
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
     name: "updateArableLandForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["updateArableLand-submit"],
     props: ["newArableLand", "message1", "message2"],
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
                    .required("Loại đát phải có giá trị")
          });
          return {
               newarableLand: this.newArableLand,
               schema,
          };
     },

     methods: {

     }
};
</script>
 
<style>@import url(../../assets/arablelandStyle.css);</style>