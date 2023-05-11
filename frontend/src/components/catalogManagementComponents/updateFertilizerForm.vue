<template>
     <Form @submit="newfertilixer.close = true, $emit('updateFertilizer-submit', newfertilixer)" :validation-schema="schema"
          class="form container-fluid updateFertilizerForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle"
                         @click="newfertilixer.close = false, $emit('updateFertilizer-submit', newfertilixer)"
                         style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName">
                    CẬP NHẬT THÔNG TIN PHÂN BÓN
               </p>
          </div>
          <div class="row content">
               <div class="col-md-3">
                    <div class="form-group">
                         <label for="id" class="">Mã phân bón <span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control mb-3" v-model="newfertilixer.Fertilizer_id"
                              placeholder="Nhập mã phân bón..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="row nutrient-row">
                         <label class="lable-nutrient">Thành phần dinh dưỡng</label>
                         <div class="form-group" style="margin-left: 20px !important;"
                              v-for="(contain, i) in newfertilixer.Contain" :key="contain.Nutrient_id">
                              <label :for="contain.Nutrient_id" class="">{{ contain.Nutrient_name }} <span
                                        style="color: red">*</span></label>
                              <Field :name="contain.Nutrient_id" class="form-control"
                                   v-model="newfertilixer.Contain[i].Contain_percent" placeholder="Thông tin phân bón..." />
                              <ErrorMessage :name="contain.Nutrient_id" class="error-feedback" />
                         </div>
                    </div>


               </div>
               <div class="col-md-4">
                    <div class="form-group">
                         <label for="name" class="">Tên phân bón <span style="color: red">*</span></label>
                         <Field name="name" class="form-control" v-model="newfertilixer.Fertilizer_name"
                              placeholder="Nhập tên phân bón..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="supplier" class="mt-3 pt-1">Nhà cung cấp <span style="color: red">*</span></label>
                         <Field name="supplier" class="form-control" v-model="newfertilixer.Fertilizer_supplier"
                              placeholder="Nhà cung cấp phân bón..." />
                         <ErrorMessage name="supplier" class="error-feedback" />
                    </div>
                    <div class="row form-group " style="width: 99%; margin-left: 1%;">
                         <label for="supplier mt-3" class="" style="margin-top: 20px;">Hình ảnh <span style="color: red">*</span></label>
                         <div class="col-sm-12 text-center form-control" style="height: 250px !important;">
                              <input type="file" ref="file" name="image" @change="selectFile($event)" accept="image/*"
                                   enctype="multipart/form-data" class="" v-bind:aria-disabled="true">
                              <div class="row rowImage mt-2" style=" width: 100%; height: 200px; padding-top: 6px;">
                                   <div class="col-md-12 text-center" style="height: 180px; width: 50%;">
                                        <img v-if="newfertilixer.url != ''" :src="newfertilixer.url" class="img-fluid" style="height: 190px; !important">
                                   </div>
                              </div>
                         </div>
                    </div>

               </div>

               <div class="col-md-5">
                    <div class="form-group">
                         <label for="uses" class="">Công dụng <span style="color: red">*</span></label>
                         <Field name="uses" class="form-control" v-model="newfertilixer.Fertilizer_uses" as="textarea"
                              style="height: 180px;" placeholder="Công dụng phân bón..." />
                         <ErrorMessage name="uses" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="directionsForUse" class="mt-3">Hướng dẫn sử dụng<span
                                   style="color: red">*</span></label>
                         <Field name="directionsForUse" class="form-control"
                              v-model="newfertilixer.Fertilizer_directionsForUse" as="textarea" style="height: 180px;"
                              placeholder="Thông tin phân bón..." />
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
          <div class="row mb-2">
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
               N: yup
                    .number()
                    .typeError("Tỉ lệ là phải là số")
                    .required("Tỉ lệ đạm phải có giá trị"),
               K: yup
                    .number()
                    .typeError("Tỉ lệ là phải là số")
                    .required("Tỉ lệ đạm phải có giá trị"),
               P: yup
                    .number()
                    .typeError("Tỉ lệ là phải là số")
                    .required("Tỉ lệ đạm phải có giá trị"),
               Y: yup
                    .number()
                    .typeError("Tỉ lệ là phải là số"),
               uses: yup
                    .string()
                    .required("Công dụng phân bón phải có giá trị"),
               directionsForUse: yup
                    .string()
                    .required("Hưỡng dẫn sử dụng phân bón phải có giá trị")
          });
          return {
               newfertilixer: this.newFertilizer,
               nutrientlist: this.nutrientList,
               schema,
          };
     },

     methods: {
          async selectFile(event) {
               this.fileImage = event.target.files[0];
               this.newfertilixer.filename = "Fertilizer_" + this.newfertilixer.Fertilizer_id + this.fileImage.name;
               console.log(this.fileImage.name);
               this.newfertilixer.newImage = this.fileImage;
               console.log(this.newfertilixer.Image)
               this.newfertilixer.url = URL.createObjectURL(this.fileImage);
          },
     }
};
</script>
 
<style>
@import url(../../assets/fertilizerStyle.css);

.dp__theme_light {
     --dp-background-color: #FAFAFC;
     --dp-border-radius: 10px;
     --dp-text-color: #212121;
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
     border-radius: 10px;
     font-family: -apple-system, blinkmacsystemfont, "Segoe UI", roboto, oxygen, ubuntu, cantarell, "Open Sans", "Helvetica Neue", sans-serif;
     border: 1px solid var(--dp-border-color);
     outline: none;
     transition: border-color .2s cubic-bezier(0.645, 0.045, 0.355, 1);
     width: 100%;
     font-size: 1rem;
     line-height: 1.5rem;
     padding: 6px 12px;
     color: var(--dp-text-color);
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     box-sizing: border-box;
}

.updateFertilizerForm .rowImage {
    height: 200px;
    margin: auto;
    margin-top: 5px;
}

.lable-nutrient {
     float: left;
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 500;
     font-size: 18px;
     color: #008B8E;
     padding-top: 5px;
}

.nutrient-row {
     width: 98.5% !important;
     margin-left: 3px !important;
     margin-top: 10px !important;
     background-color: #f0f0f0;
     background: #FAFAFC;
box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
border-radius: 15px;
     font-size: 17px;
     border-radius: 10px;
     color: #2F3033;
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 500;
     vertical-align: middle;
}
</style>