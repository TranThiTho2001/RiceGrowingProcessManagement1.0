<template>
     <Form @submit="$emit('updateRiceCrop-submit', newricecrop)" :validation-schema="schema"
          class="container-fluid updateRiceCropForm">
          <div class="row content">
               <div class="col-sm-3">
                    <div class="form-group">
                         <label for="id" class="pt-1">Mã mùa vụ <span style="color:red; display: ;">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newricecrop.RiceCropInformation_id"
                              placeholder="Nhập mã mùa vụ..." :disabled="true" />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="seed" class="pt-3">Giống lúa <span style="color:red">*</span></label>
                         <Field name="seed" v-model="newricecrop.Seed_name">
                              <select class="form-control" v-model="newricecrop.Seed_name" name="seed" for="seed">
                                   <option v-for="(seed, i) in seedList" :key="i">{{ seed.Seed_name }}</option>
                              </select>
                         </Field>
                         <ErrorMessage name="seed" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-3">
                    <div class="form-group">
                         <label for="name" class="pt-1">Tên mùa vụ <span style="color:red">*</span></label>
                         <Field name="name" class="form-control" v-model="newricecrop.RiceCropInformation_name"
                              placeholder="Tên mùa vụ..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="arableLand" class="pt-3">Mẫu ruộng <span style="color:red">*</span></label>
                         <Field name="arableLand" class="form-control" v-model="newricecrop.ArableLand_id"
                              placeholder="Nhập vị trí mẫu ruộng...">
                              <select class="form-control" v-model="newricecrop.ArableLand_id" name="arableLand"
                                   for="arableLand" >
                                   <option v-for="(arableLand, i) in arableLandList" :key="i">{{ arableLand.ArableLand_id }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="arableLand" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-3">
                    <div class="form-group">
                         <label for="sowingDate" class="pt-1">Ngày gieo xạ</label><br>
                         <Field name="sowingDate" class="form-control " v-if="!selectdate"
                              v-model="newricecrop.RiceCropInformation_sowingDate" placeholder="Ngày sinh"
                              @click="selectdate = !selectdate">
                              <datepicker :enable-time-picker="false"
                                   :value="newricecrop.RiceCropInformation_sowingDate" :hide-input-icon="true"
                                   :hide-navigation="true" placeholder=""
                                   v-model="newricecrop.RiceCropInformation_sowingDate" :clearable="false" >
                              </datepicker>
                         </Field>


                         <ErrorMessage name="sowingDate" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="crop" class="pt-3">Vụ mùa <span style="color:red">*</span></label>
                         <Field name="crop" class="form-control" v-model="newricecrop.Crop_name" placeholder="Vụ mùa">
                              <select class="form-control" v-model="newricecrop.Crop_name" name="soil" for="soil">
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
                         <label for="harvestDate" class="pt-1">Ngày thu hoạch</label>
                         <Field name="harvestDate" class="form-control" v-model="newricecrop.RiceCropInformation_harvestDate"
                              placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newricecrop.RiceCropInformation_harvestDate"
                                   :hide-input-icon="true" v-model="newricecrop.RiceCropInformation_harvestDate"
                                   placeholder="DD-MM-YYYY" :clearable="false" format="dd-MM-yyyy" >
                              </datepicker>
                         </Field>
                         <ErrorMessage name="harvestDate" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="yield" class="pt-3">Năng suất</label>
                         <Field name="yield" class="form-control" v-model="newricecrop.RiceCropInformation_yield"
                              placeholder="Năng suất..." />
                         <ErrorMessage name="yield" class="error-feedback" />
                    </div>
               </div>
          </div>

          <div class="row">
               <div class="col-sm-10 text-center">
                    <span v-if="message2 == 'Cập nhật thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Cập nhật thành công.'" class="textMessage2" style="color:black;">
                         {{ message2 }}</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 "> {{ message1 }} Một
                         mùa vụ đang được theo dõi hoặc vừa được khởi tạo trên mẫu ruộng.
                    </span>
               </div>

               <div class="col-sm-2 text-right">
                    <button class="btn btn-outline-secondary btnLuu">Cập nhật</button>
               </div>
          </div>

     </form>
</template>
 
<script>


import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import moment from "moment";
export default {
     name: "updateRiceCropForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          datepicker,

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
               selectdate: false,
               dateFormat: (date) => {
                    const day = date.getDate();
                    const month = date.getMonth() + 1;
                    const year = date.getFullYear();
                    return `${day}-${month}-${year}`;
               }
          };
     },

     methods: {
          fotmatDate() {
               console.log(this.newricecrop.RiceCropInformation_sowingDate)
               return (moment(String(this.newricecrop.RiceCropInformation_sowingDate)).format("YYYY-MM-DD")).slice(0, 10);

          },
          onFocus: function () {
               this.$refs.dateObj.show();
          }
     },

};
</script>
 
<style>
@import url(../../assets/riceCropStyle.css);

.dp__theme_light {
     --dp-background-color: #FAFAFC;
     --dp-border-radius: 10px;
     --dp-text-color: #2F3033;
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
     border-radius: 15px !important;
     font-family: 'Roboto';
     font-style: normal;
     font-size: 18px;
     font-weight: 500;
     border: 1px solid var(--dp-border-color);
     outline: none;
     transition: border-color .2s cubic-bezier(0.645, 0.045, 0.355, 1);
     width: 100%;
     height: 80%;
     font-size: 1rem;
     line-height: 1.5rem;
     padding: 6px 12px;
     color: var(--dp-text-color);
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     box-sizing: border-box;
}</style>