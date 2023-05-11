<template>
     <Form @submit="newpesticide.close = true, $emit('addPesticide-submit', newpesticide)" :validation-schema="schema"
          class="form container-fluid createPesticideForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle" @click="newpesticide.close = false, $emit('addPesticide-submit', newpesticide)"
                    style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName">
                    THÊM LOẠI THUỐC TRỊ BỆNH DỊCH MỚI
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-4">
                    <div class="form-group">
                         <label for="id" class="">Mã thuốc <span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newpesticide.Pesticide_id"
                              placeholder="Nhập mã thuốc..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="name" class="mt-3">Tên thuốc <span style="color: red">*</span></label>
                         <Field name="name" class="form-control" v-model="newpesticide.Pesticide_name"
                              placeholder="Nhập tên thuốc..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="supplier" class="mt-3">Nhà cung cấp <span style="color: red">*</span></label>
                         <Field name="supplier" class="form-control" v-model="newpesticide.Pesticide_supplier"
                              placeholder="Nhà cung cấp thuốc..." />
                         <ErrorMessage name="supplier" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="components" class="mt-3">Thành phần <span style="color: red">*</span></label>
                         <Field name="components" class="form-control" v-model="newpesticide.Pesticide_component"
                              as="textarea" style="height: 200px;" placeholder="Thông tin thuốc..." />
                         <ErrorMessage name="components" class="error-feedback" />
                    </div>
               </div>

               <div class="col-md-4">
                    <div class="form-group">
                         <label for="uses" class="">Công dụng <span style="color: red">*</span></label>
                         <Field name="uses" class="form-control" v-model="newpesticide.Pesticide_uses" as="textarea"
                              style="height: 206px;" placeholder="Công dụng phân bón..." />
                         <ErrorMessage name="uses" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="directionsForUse" class="">Hướng dẫn sử dụng<span
                                   style="color: red">*</span></label>
                         <Field name="directionsForUse" class="form-control"
                              v-model="newpesticide.Pesticide_directionsForUse" as="textarea" style="height: 200px;"
                              placeholder="Thông tin phân bón..." />
                         <ErrorMessage name="directionsForUse" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-4">
                    <div class="form-group" style="height: 200px !important;">
                         <div class="ml-3">
                              <label for="" class="">Điều trị bệnh dịch gây hại<span style="color: red">*</span></label><br>
                         </div>
                         <div class="epidemicSelect" style="overflow-y: scroll;">
                              <div class="col-sm-12 mt-1">
                                   <div class="row ml-2" v-for="epidemic in epidemiclist" :key="epidemic.Epidemic_id">
                                        <input type="checkbox" v-model="treatment" @change="show" name="epidemic"
                                             :value="epidemic.Epidemic_id">
                                        <label style="" for="epidemic" class="labelEpidemic">&nbsp; {{ epidemic.Epidemic_name
                                        }}</label><br>
                                   </div>
                              </div>
                         </div>
                    </div>

                    <div class="row form-group " style="width: 99%; margin-left: 1%;">
                         <label for="supplier mt-3" class="" style="margin-top: 40px;">Hình ảnh <span style="color: red">*</span></label>
                         <div class="col-sm-12 text-center form-control" style="height:200px !important;">
                              <input type="file" ref="file" name="image" @change="selectFile($event)" accept="image/*"
                                   enctype="multipart/form-data" class="" v-bind:aria-disabled="true">
                              <div class="row rowImage mt-2" style=" width: 100%; height: 180px;">
                                   <div class="col-md-12 text-center" style="height: 180px; width: 50%;">
                                        <img v-if="url != ''" :src="url" class="img-fluid" style="height: 150px; !important">
                                   </div>
                              </div>
                         </div>
                    </div>
               </div>
          </div>

          <div class="row ">
               <div class="col-sm-12 mt-2 mb-2 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         Thêm thông tin một loại thuốc mới thành công</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> Thêm thông tin một loại
                         thuốc mới không thành công </span>
               </div>
          </div>
          <div class="row mb-1">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu">Lưu</button>
               </div>
          </div>
          <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>
     </form>
</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import EpidemicService from "@/services/epidemic.service";

export default {
     name: "createPesticideForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["addPesticide-submit"],
     props: ["newPesticide", "message1", "message2", "epidemicList"],
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
               components: yup
                    .string()
                    .required("Thành phần thuốc phải có giá trị"),
               uses: yup
                    .string()
                    .required("Công dụng thuốc phải có giá trị"),
               directionsForUse: yup
                    .string()
                    .required("Hướng dẫn sử dụng phải có giá trị")

          });
          return {
               newpesticide: this.newPesticide,
               schema,
               treatment: [],
               epidemiclist: this.epidemicList,
               cloneEpidemicList: this.epidemicList,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               nameToSearch: "",
               fileImage: {},
               url: "",
          };
     },

     methods: {
          show() {
               this.newpesticide.Treatment = this.treatment;
          },

          filteredList() {
               return this.cloneEpidemicList.filter(epidemic => {
                    return epidemic.Epidemic_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
          },
          async retrieveEpidemicList() {
               const [err, respone] = await this.handle(
                    EpidemicService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.epidemiclist = respone.data;
                    this.cloneEpidemicList = respone.data;
               }
          },

          async searchName(data) {
               this.nameToSearch = data;
               const [error, response] = await this.handle(EpidemicService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.epidemiclist = response.data;
                         console.log(response.data)
                    }
               }
          },

          async selectFile(event) {
               this.fileImage = event.target.files[0];
               this.newpesticide.Image = this.fileImage;
               this.url = URL.createObjectURL(this.fileImage);
          },
     }
};
</script>
 
<style>
@import url(../../assets/pesticideStyle.css);

.pesticideManagement .inputSearch3 {
     background: linear-gradient(0deg, #FFFFFF, #FFFFFF), #EAEAEA;
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     border-radius: 15px;
     width: 95%;
     height: 35px;
}

.pesticideManagement .topRight .form-control:focus {
     border-color: #E4E5EB !important;
}

.pesticideManagement .btnSearch3 {
     position: absolute;
     left: 84%;
     top: 17%;
     border-radius: 10px;
     border: none;
     background: none;
}

.pesticideManagement .closeSearch1 {
     display: none;
     width: 110%;
     margin: 0 auto 10px auto;
     padding: 10px 20px;
     color: white;
     border-radius: 5px;
     box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 3px 0px,
          rgba(0, 0, 0, 0.06) 0px 1px 2px 0px;
}

.pesticideManagement .openSearch1 {
     display: inline-block;
     position: absolute;
     top: 27%;
     width: 95%;
     background-color: #FAFAFC;
     border-radius: 5px;
     z-index: 5;
     box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 3px 0px,
          rgba(0, 0, 0, 0.06) 0px 1px 2px 0px;
}

.pesticideManagement .item {
     background-color: none;
     cursor: pointer;
     bottom: 0.1px;
     color: #1C1C1F;
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 500;
     font-size: 16px;
     padding: 0.1px;
     margin: 0.2px;
}

.pesticideManagement .item:hover {
     background-color: none;
     cursor: pointer;
     bottom: 0.1px;
     background-color: #EAEAEA;
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 500;
     font-size: 16px;
}

.createPesticideForm .epidemicSelect {
     background-color: #FAFAFC !important;
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     max-height: 200px !important;
     min-height: 200px;
     z-index: 3 !important;
     border-radius: 15px !important;
     border-radius: 15px;
}

.createPesticideForm .rowImage {
    height: 170px;
    margin: auto;
    margin-top: 5px;
}

</style>