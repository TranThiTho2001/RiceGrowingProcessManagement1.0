<template>
     <Form @submit="newpesticide.close = true, $emit('updatePesticide-submit', newpesticide)" :validation-schema="schema"
          class="form container-fluid updatePesticideForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle"
                         @click="newpesticide.close = false, $emit('updatePesticide-submit', newpesticide)"
                         style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>

          <div class="row">
               <p class="col-sm-12 text-center functionName">
                    CẬP NHẬT THÔNG TIN BỆNH DỊCH
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
                         <label for="directionsForUse" class="mt-1">Hướng dẫn sử dụng<span
                                   style="color: red">*</span></label>
                         <Field name="directionsForUse" class="form-control"
                              v-model="newpesticide.Pesticide_directionsForUse" as="textarea" style="height: 200px;"
                              placeholder="Thông tin phân bón..." />
                         <ErrorMessage name="directionsForUse" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-4">
                    <div class="form-group" style="height: 225px !important;">
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
                         <label for="supplier mt-3" class="" style="margin-top: 20px;">Hình ảnh <span style="color: red">*</span></label>
                         <div class="col-sm-12 text-center form-control" style="height: 200px !important;">
                              <input type="file" ref="file" name="image" @change="selectFile($event)" accept="image/*"
                                   enctype="multipart/form-data" class="" v-bind:aria-disabled="true">
                              <div class="row rowImage mt-2" style=" width: 100%; height: 180px; padding-top: 6px;">
                                   <div class="col-md-12 text-center" style="height: 180px; width: 50%;">
                                        <img v-if="newpesticide.url != ''" :src="newpesticide.url" class="img-fluid" style="height: 150px; !important">
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
                         Cập nhật thông tin loại thuốc thành công</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> Cập nhật thông tin
                         loại thuốc không thành công
                    </span>
               </div>
          </div>

          <div class="row mb-2">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu col-sm-2">Lưu</button>
               </div>
          </div>
     </form>
</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import EpidemicService from "@/services/epidemic.service";
import TreatmentService from "@/services/treatment.service";
export default {
     name: "updatePesticideForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["updatePesticide-submit"],
     props: ["newPesticide", "message1", "message2", "epidemicList", "treatmentList"],
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
               treatmentlist: this.treatmentList,
               count: 0,
          };
     },

     methods: {
          show() {
               this.newpesticide.NewTreatment = this.treatment;
          },

          async selectFile(event) {
               this.fileImage = event.target.files[0];
               this.newpesticide.newImage = this.fileImage;
               this.newpesticide.url = URL.createObjectURL(this.fileImage);
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

          async findTreatmentByPesticideId() {
               const [error, respone] = await this.handle(
                    TreatmentService.findByPesticideId(this.newPesticide.Pesticide_id)
               );
               if (error) {
                    console.log(error);
               } else if (respone.data != "Không tìm thấy.") {
                    this.treatmentlist = respone.data;
               }
               this.setTreatment();

          },

          async setTreatment() {
               this.count = 1;
               this.newpesticide.NewTreatment = [];
               this.treatmentlist.forEach(element => {
                    this.treatment.push(element.Epidemic_id);
                    this.newpesticide.NewTreatment.push(element.Epidemic_id);
               });
          }
     },

     created() {
          this.findTreatmentByPesticideId()
     }
};
</script>
 
<style>
@import url(../../assets/mainStyle.css);

.pesticideManagement .topRight .form-control:focus {
     border-color: #E4E5EB !important;
}

.updatePesticideForm .rowImage {
    height: 200px;
    margin: auto;
    margin-top: 5px;
}

.epidemicSelect {
     background-color: #f7f7f7;
     border-radius: 3px;
     max-height: 200px !important;
     min-height: 220px;
     width: 100%;
     position: relative;
}

.pesticideManagement .createPesticideForm,
.pesticideManagement .updatePesticideForm{
    margin: auto;
    padding: 20px;
    background: #FAFAFC;
    box-shadow: 0px 4px 24px -1px rgba(0, 0, 0, 0.3);
    backdrop-filter: blur(37.5px);
    border-radius: 5px;
    width: 85%;
    position: relative;
    top:20px;
    transition: all 5s ease-in-out;
}

@media only screen and (max-width: 1430px) {
    .pesticideManagement .createPesticideForm,
    .pesticideManagement .updatePesticideForm{
         margin: auto;
    }
}
</style>