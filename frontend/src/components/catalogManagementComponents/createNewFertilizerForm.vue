<template>
     <Form @submit="newfertilixer.close = true, newfertilixer.Nutrient = nutrientlist, $emit('addFertilizer-submit', newfertilixer)"
          :validation-schema="schema" class="form  createFertilizerForm container-fluid">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle"
                         @click="newfertilixer.close = false, newfertilixer.Nutrient = nutrientlist, $emit('addFertilizer-submit', newfertilixer)"
                         style="font-size: 25px; padding-top:10px; color:#FAFAFC"></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><i class="fas fa-plus-circle"></i> THÊM LOẠI PHÂN BÓN MỚI
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

                    <div class="form-group" v-for="(contain,i) in newfertilixer.Contain" :key="contain.Nutrient_id">
                         <label :for="contain.Nutrient_id " class="mt-3">{{contain.Nutrient_name}} <span style="color: red">*</span></label>
                         <Field :name="contain.Nutrient_id " class="form-control" v-model="newfertilixer.Contain[i].Contain_percent"
                              placeholder="Thông tin phân bón..." @update:model-value="show(newfertilixer.Contain[i].Contain_percent)" />
                         <ErrorMessage :name="contain.Nutrient_id " class="error-feedback" />
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
                         <label for="directionsForUse" class="mt-3">Hướng dẫn sử dụng<span
                                   style="color: red">*</span></label>
                         <Field name="directionsForUse" class="form-control"
                              v-model="newfertilixer.Fertilizer_directionsForUse" as="textarea" style="height: 240px;"
                              placeholder="Thông tin phân bón..." />
                         <ErrorMessage name="directionsForUse" class="error-feedback" />
                    </div>

                    <!-- <div class="form-group">
                         <label for="image">Hình ảnh &nbsp; &nbsp;</label>
                         <Field name="image" class="form-control " v-model="images">
                              <input type="file" ref="file" :multiple="true" name="image" @change="selectFile($event)"
                                   accept="image/*" class="" v-bind:aria-disabled="true">
                         </Field>
                         <div class="row">
                              <div class="col-md-5">
                                   <img v-if="url != ''" :src="url" class="img-fluid">
                              </div>
                              <div class="col-md-7">
                              </div>
                         </div>
                    </div> -->
               </div>
          </div>

          <div class="row ">
               <div class="col-sm-12 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         Thêm phân bón thành công</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2">Thêm phân bón không
                         thành công </span>
               </div>
          </div>
          <div class="row mb-5">
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
     name: "createFertilizerForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["addFertilizer-submit"],
     props: ["newFertilizer", "message1", "message2", "nutrientList"],
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
               // components: yup
               //      .string()
               //      .required("Thành phần phân bón phải có giá trị"),
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
               images: [],
          };
     },

     methods: {
          show(data){
               console.log(data)
          },

          async selectFile(event) {
               console.log(event.target.files);
               var fileImage = {};
               fileImage = event.target.files[0]; console.log(fileImage);
               const filename = "image_" + fileImage.name;

               console.log("filename" + filename)

               this.url = URL.createObjectURL(fileImage);
          },
     }
};
</script>
 
<style>
@import url(../../assets/mainStyle.css);
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
</style>