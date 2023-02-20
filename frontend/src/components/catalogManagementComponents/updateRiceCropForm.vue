<template>
     <Form @submit="$emit('updateRiceCrop-submit', newricecrop)" :validation-schema="schema"
          class="container-fluid updateRiceCropForm">
          <div class="row content">
               <div class="col-sm-3 mt-2">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã mùa vụ</label>
                         <Field name="id" type="name" class="form-control" v-model="newricecrop.RiceCropInformation_id"
                              placeholder="Nhập mã mùa vụ..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="seed" class="mt-3">Giống lúa</label>
                         <Field name="seed" v-model="newricecrop.Seed_id">
                              <select class="form-control" v-model="newricecrop.Seed_id" name="seed" for="seed">
                                   <option v-for="(seed, i) in seedList" :key="i">{{ seed.Seed_name }}</option>
                              </select>
                         </Field>
                         <ErrorMessage name="seed" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-3">
                    <div class="form-group">
                         <label for="name" class="mt-3">Tên mùa vụ</label>
                         <Field name="name" class="form-control" v-model="newricecrop.RiceCropInformation_name"
                              placeholder="Tên mùa vụ..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="arableLand" class="mt-3">Mẫu ruộng</label>
                         <Field name="arableLand" class="form-control" v-model="newricecrop.ArableLand_id"
                              placeholder="Nhập vị trí mẫu ruộng...">
                              <select class="form-control" v-model="newricecrop.ArableLand_id" name="arableLand"
                                   for="arableLand">
                                   <option v-for="(arableLand, i) in arableLandList" :key="i">{{ arableLand.ArableLand_id }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="arableLand" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-3">
                    <div class="form-group">
                         <label for="sowingDate" class="mt-3">Ngày gieo xạ</label>
                         <Field name="sowingDate" class="form-control" v-model="newricecrop.RiceCropInformation_sowingDate"
                              placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newricecrop.RiceCropInformation_sowingDate"
                                   :hide-input-icon="true" v-model="newricecrop.RiceCropInformation_sowingDate"
                                   placeholder="YYYY-MM-DD">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="sowingDate" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="crop" class="mt-3">Vụ mùa</label>
                         <Field name="crop" class="form-control" v-model="newricecrop.Crop_id" placeholder="Vụ mùa">
                              <select class="form-control" v-model="newricecrop.Crop_id" name="soil" for="soil">
                                   <option>Đông Xuân</option>
                                   <option>Hè Thu</option>
                                   <option>Vụ Mùa</option>
                              </select>
                         </Field>
                         <ErrorMessage name="crop" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-3">
                    <div class="form-group">
                         <label for="harvestDate" class="mt-3">Ngày thu hoạch</label>
                         <Field name="harvestDate" class="form-control" v-model="newricecrop.RiceCropInformation_harvestDate"
                              placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newricecrop.RiceCropInformation_harvestDate"
                                   :hide-input-icon="true" v-model="newricecrop.RiceCropInformation_harvestDate"
                                   placeholder="YYYY-MM-DD">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="harvestDate" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="yield" class="mt-3">Năng suất</label>
                         <Field name="yield" class="form-control" v-model="newricecrop.RiceCropInformation_yield"
                              placeholder="Năng suất..." />
                         <ErrorMessage name="yield" class="error-feedback" />
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
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }} Một
                         mùa vụ đang được theo dõi hoặc vừa được khởi tạo trên mẫu ruộng.
                    </span>
               </div>
               <div class="col-sm-2"></div>
          </div>
          <div class="row">
               <button class="btn btn-outline-secondary btnLuu ml-3">Cập nhật</button>
          </div>

     </form>
</template>
 
<script>


import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
export default {
     name: "updateRiceCropForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["updateRiceCrop-submit"],
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
                    .number()
                    .nullable(),
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
 
<style>
@import url(../../assets/riceCropStyle.css);
</style>