<template>
     <Form @submit="newimage.close = true, $emit('addImage-submit', newimage)" enctype="multipart/form-data"
          class="container createImageForm form">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times" @click="newimage.close = false, $emit('addImage-submit', newricecrop)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><i class="fas fa-plus-circle"></i> Thêm Ảnh Cho Mùa Vụ
               </p>
          </div>

          <div class="row content">
               <div class="form-group col-sm-12 text-center">
                    <Field name="id" type="name" class="form-control " v-model="newimage.Image_name"
                         placeholder="Nhập mã giống lúa">
                         <button class="btnAddImage">
                              <label for="inputTag" class="labelImage pt-1">
                                   Chọn ảnh<!-- <i class="fas fa-camera"></i> -->
                                   <input type="file" ref="file" name="image" @change="selectFile" accept="image/*"
                                    class="" v-bind:aria-disabled="true"/>
                              </label>
                         </button>
                    </Field>
                    <br>
                    <ErrorMessage name="id" class="error-feedback mt-3" />

               </div>
          </div>
          <div class="row">
               <div class="col-md-2"></div>
               <div class="col-md-8 text-center">
                    <img v-if="url != ''" :src="url" class="img-fluid" style="max-height: 300px;">
               </div>
               <div class="col-md-2"></div>

          </div>
          <div class="row">
               <div class="col-sm-2"></div>
               <div class="col-sm-8 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         {{ message2 }}</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }} Một mùa
                         vụ đang được theo dõi hoặc vừa được khởi tạo trên mẫu ruộng.
                    </span>
               </div>
               <div class="col-sm-2"></div>
          </div>
          <div class="row mb-4" v-if="url!=''">
               <div class="col-sm-5"></div>
               <button class="btn btn-outline-secondary btnLuu col-sm-2">Lưu</button>
               <div class="col-sm-5"></div>
          </div>
     </Form>
</template>
 
<script>


import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";

export default {
     name: "createNewImageForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["addImage-submit"],
     props: ["newImage", "message1", "message2"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Vui lòng chọn hình ảnh."),

          });
          return {
               newimage: this.newImage,
               schema,
               fileImage: "",
               url: "",
          };
     },

     methods: {
          async selectFile(event) {
               this.fileImage = event.target.files[0];
               this.newimage.Image_name = "image_" + this.fileImage.name;
               console.log(this.newimage.Image_name);
               this.newimage = event.target.files[0];
               console.log(this.newimage.Image);
               this.url = URL.createObjectURL(this.fileImage);

               console.log(this.url)
          },
     }
};
</script>
 
<style >
/* @import url(../../assets/riceCropStyle.css); */
.createImageForm {
     position: absolute;
     top: 20%;
     left: 15%;
     background-color: beige;
     width: 20%;
     height: 500px;
}

.inputClass {
     display: none;
}

.labelImage {
     font-size: 15px;
}

.btnAddimage {
     background-color: rgb(241, 248, 164);
     border-radius: 5px;
}

.createImageForm .form-group .btnAddImage{
     background-color: rgb(241, 248, 164);
        border-radius: 5px;
        /* position: absolute; */
        left: 40%;
}

.createImageForm .functionName{
     font-family: 'Roboto';
     font-size: 20px;
     font-weight: 600;
}

.createImageForm .error-feedback{
     color: red;
     font-size: 16px;
     font-size: 500;
}
</style>