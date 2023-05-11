<template>
     <Form @submit="newepidemic.close = true, $emit('updateEpidemic-submit', newepidemic)" :validation-schema="schema"
          class="form container-fluid updateEpidemicForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle" @click="newepidemic.close = false, $emit('updateEpidemic-submit', newepidemic)"
                    style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName">
                    CẬP NHẬT THÔNG TIN BỆNH DỊCH
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-4 mt-2">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã <span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newepidemic.Epidemic_id"
                              placeholder="Nhập mã bệnh dịch..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="classtify" class="mt-3">Phân loại <span style="color: red">*</span></label>
                         <Field name="classtify" v-model="newepidemic.EpidemicClassification_name">
                              <select class="form-control" v-model="newepidemic.EpidemicClassification_name"
                                   style="background:  #F0F2F7;box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);" name="classtify"
                                   for="classtify">
                                   <option for="classtify">Côn trùng</option>
                                   <option>Dịch bệnh</option>
                                   <option>Nấm hại</option>
                                   <option>Sâu bệnh</option>
                              </select>
                         </Field>
                         <ErrorMessage name="classtify" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="environment" class="">Môi trường phát triển <span
                                   style="color: red">*</span></label>
                         <Field name="environment" class="form-control" v-model="newepidemic.Epidemic_developmentEnvironment"
                              as="textarea" style="height: 250px;" placeholder="Nhập môi trường phát triển..." />
                         <ErrorMessage name="environment" class="error-feedback" />
                    </div>

               </div>

               <div class="col-sm-4">
                    <div class="form-group">
                         <label for="name" class="mt-3">Tên <span style="color: red">*</span></label>
                         <Field name="name" class="form-control" v-model="newepidemic.Epidemic_name"
                              placeholder="Nhập tên bệnh dịch..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>
                    <div class="form-group">
                         <label for="time" class="mt-3">Thời điểm xuất hiện</label>
                         <Field name="time" class="form-control" v-model="newepidemic.Epidemic_timeOfDevelopment"
                              placeholder="Nhập thời điểm xuất hiện...." />
                         <ErrorMessage name="time" class="error-feedback" />
                    </div>
                    <div class="form-group">
                         <label for="harm" class="mt-3 pt-1">Tác hại <span style="color: red">*</span></label>
                         <Field name="harm" class="form-control" v-model="newepidemic.Epidemic_Harm" as="textarea"
                              style="height: 250px;" placeholder="Nhập tác hại..." />
                         <ErrorMessage name="harm" class="error-feedback" />
                    </div>

               </div>

               <div class="col-sm-4">
                    <div class="row form-group " style="width: 99%; margin-left: 1%;">
                         <label for="supplier mt-3" class="" style="margin-top: 20px;">Hình ảnh <span style="color: red">*</span></label>
                         <div class="col-sm-12 text-center form-control" style="height: 250px !important;">
                              <input type="file" ref="file" name="image" @change="selectFile($event)" accept="image/*"
                                   enctype="multipart/form-data" class="" v-bind:aria-disabled="true">
                              <div class="row rowImage mt-2" style=" width: 100%; height: 200px; padding-top: 6px;">
                                   <div class="col-md-12 text-center" style="height: 180px; width: 50%;">
                                        <img v-if="newepidemic.url != ''" :src="newepidemic.url" class="img-fluid" style="height: 190px; !important">
                                   </div>
                              </div>
                         </div>
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
                         Cập nhật thông tin bệnh dịch thành công</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> Cập nhật thông tin bệnh dịch không thành công
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
     name: "updateEpidemicForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["updateEpidemic-submit"],
     props: ["newEpidemic", "message1", "message2", "epidemicClassificationList"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã bệnh dịch phải có giá trị")
                    .min(10, "Mã bệnh dịch phải gồm 10 ký tự")
                    .max(10, "Mã bệnh dịch phải gồm 10 ký tự"),
               name: yup
                    .string()
                    .required("Tên bệnh dịch phải có giá trị"),
               environment: yup
                    .string()
                    .required("Môi trường phát triển của bệnh dịch phải có giá trị"),
               time: yup
                    .string()
                    .required("Thời điểm thường xuất hiện bệnh dịch phải có giá trị"),
               harm: yup
                    .string()
                    .required("Tác hại bệnh dịch phải có giá trị"),
               classtify: yup
                    .string()
                    .required("Phân loại bệnh dịch phải có giá trị")
          });
          return {
               newepidemic: this.newEpidemic,
               schema,
          };
     },

     methods: {
          async selectFile(event) {
               this.fileImage = event.target.files[0];
               // this.fileImage.name = "Fertilizer_" + this.newepidemic.Epidemic_id + this.fileImage.name;
               this.newepidemic.newImage = this.fileImage;
               this.newepidemic.url = URL.createObjectURL(this.fileImage);
          },
     }
};
</script>
 
<style>
.updateEpidemicForm .rowImage {
    height: 200px;
    margin: auto;
    margin-top: 5px;
}


@import url(../../assets/epidemicStyle.css);
</style>