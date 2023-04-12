<template>
     <Form @submit="newpesticide.close = true, $emit('updatePesticide-submit', newpesticide)" :validation-schema="schema"
          class="form container-fluid updatePesticideForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times"
                         @click="newpesticide.close = false, $emit('updatePesticide-submit', newpesticide)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fas fa-edit actionIcon"></span> 
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
                              as="textarea" style="height: 185px;" placeholder="Thông tin thuốc..." />
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
                              v-model="newpesticide.Pesticide_directionsForUse" as="textarea" style="height: 182px;"
                              placeholder="Thông tin phân bón..." />
                         <ErrorMessage name="directionsForUse" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-4">
                    <div class="form-group" style="height: 420px !important;">
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
          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu col-sm-2">Lưu</button>
               </div>
          </div>
          <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>

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
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               nameToSearch: "",
               treatmentlist: this.treatmentList,
               count: 0,
          };
     },

     methods: {
          show() {
               this.newpesticide.NewTreatment = this.treatment;
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
                    }
               }
          },

          check(data) {

               var t = 0;
               this.treatmentlist = this.treatmentList;
               this.treatmentList.forEach(element => {
                    if (data == element.Epidemic_id) {
                         t = 1;
                    }
               });
               if (this.count == 0) {
                    this.setTreatment();
                    console.log(this.treatment)
               }
               if (t) return true;
               else return false;
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

.scrollList {
     overflow: auto;
     height: 200px;
     width: 90%;
     margin-top: 30px;
}

.selectItem {
     white-space: nowrap;
     overflow: hidden;
}

.epidemicSelect {
     background-color: #f7f7f7;
     border-radius: 3px;
     max-height: 240px !important;
     min-height: 280px;
     width: 100%;
     position: relative;
}</style>