<template>
     <Form @submit="newricecrop.close = true, $emit('addRiceCrop-submit', newricecrop)" :validation-schema="schema"
          class="form  container-fluid createRiceCropForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle" @click="newricecrop.close = false, $emit('addRiceCrop-submit', newricecrop)"
                    style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName">THÊM MÙA VỤ
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-6 mt-2">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã mùa vụ <span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newricecrop.RiceCropInformation_id"
                              placeholder="Nhập mã mùa vụ..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="seed" class="mt-3">Giống lúa <span style="color: red">*</span></label>
                         <Field name="seed" v-model="newricecrop.Seed_id">
                              <select class="form-control" v-model="newricecrop.Seed_id" name="seed" for="seed">
                                   <option v-for="(seed, i) in seedlist" :key="i">{{ seed.Seed_name }}</option>
                              </select>
                         </Field>
                         <ErrorMessage name="seed" class="error-feedback" />
                    </div>
                    <div class="form-group">
                         <label for="arableLand" class="mt-1">Mẫu ruộng <span style="color: red">*</span></label>
                         <Field name="arableLand" class="form-control" v-model="newricecrop.ArableLand_id"
                              placeholder="Nhập vị trí mẫu ruộng...">
                              <select class="form-control" v-model="newricecrop.ArableLand_id" name="arableLand"
                                   for="arableLand">
                                   <option v-for="(arableLand, i) in arableLandlist" :key="i">{{ arableLand.ArableLand_id }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="arableLand" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="sowingDate" class="">Ngày gieo xạ </label>
                         <Field name="sowingDate" class="form-control" v-model="newricecrop.RiceCropInformation_sowingDate"
                              placeholder="">
                              <datepicker :enable-time-picker="false" :value="newricecrop.RiceCropInformation_sowingDate"
                                   :hide-input-icon="true" v-model="newricecrop.RiceCropInformation_sowingDate" :clearable="false" 
                                   placeholder="DD-MM-YYYY" format="dd-MM-yyyy">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="sowingDate" class="error-feedback" />
                    </div>

               </div>
               <div class="col-sm-6">
                    <div class="form-group">
                         <label for="name" class="mt-3">Tên mùa vụ <span style="color: red">*</span></label>
                         <Field name="name" class="form-control" v-model="newricecrop.RiceCropInformation_name"
                              placeholder="Tên mùa vụ..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="crop" class="mt-3">Vụ mùa <span style="color: red">*</span></label>
                         <Field name="crop" class="form-control" v-model="newricecrop.Crop_id" placeholder="Vụ mùa">
                              <select class="form-control" v-model="newricecrop.Crop_id" name="soil" for="soil">
                                   <option>Đông Xuân</option>
                                   <option>Hè Thu</option>
                                   <option>Vụ Mùa</option>
                              </select>
                         </Field>
                         <ErrorMessage name="crop" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="yield" class="mt-1">Năng suất</label>
                         <Field name="yield" class="form-control" v-model="newricecrop.RiceCropInformation_yield"
                              placeholder="Năng suất..." />
                         <ErrorMessage name="yield" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="harvestDate" class="mt-3">Ngày thu hoạch</label>
                         <Field name="harvestDate" class="form-control" v-model="newricecrop.RiceCropInformation_harvestDate"
                              placeholder="">
                              <datepicker :enable-time-picker="false" :value="newricecrop.RiceCropInformation_harvestDate"
                                   :input-class-name="myclass" :hide-input-icon="true"
                                   v-model="newricecrop.RiceCropInformation_harvestDate" placeholder="DD-MM-YYYY" :clearable="false" 
                                   format="dd-MM-yyyy" style="background-color: red !important; ">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="harvestDate" class="error-feedback" />
                    </div>
               </div>
          </div>

          <div class="row ">
               <div class="col-sm-12 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         Thêm mùa vụ thành công</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }} Một mùa
                         vụ đang được theo dõi hoặc vừa được khởi tạo trên mẫu ruộng.
                    </span>
               </div>
          </div>
          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu">Lưu</button>
               </div>
          </div>
     </form>
</template>
 
<script>


import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
export default {
     name: "createNewRiceCropForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["addnewRiceCrop-submit"],
     props: ["newRiceCrop", "message1", "message2", "seedList", "arableLandList"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã mùa vụ phải có giá trị")
                    .min(10, "Mã mùa vụ phải gồm 10 ký tự")
                    .max(10, "Mã mùa vụ phải gồm 10 ký tự"),
               name: yup
                    .string()
                    .required("Tên mùa vụ phải có giá trị"),
               seed: yup
                    .string()
                    .required("Giống lúa phải có giá trị"),
               crop: yup
                    .string()
                    .required("Vụ mùa phải có giá trị"),
               arableLand: yup
                    .string()
                    .required("Mẫu ruộng canh tác phải có giá trị"),
               yield: yup
                    .number(),
          });
          return {
               newricecrop: this.newRiceCrop,
               seedlist: this.seedList,
               arableLandlist: this.arableLandList,
               schema,
          };
     },

     methods: {

     }
};
</script>
 
<style >
@import url(../../assets/riceCropStyle.css);

.createRiceCropForm {}</style>