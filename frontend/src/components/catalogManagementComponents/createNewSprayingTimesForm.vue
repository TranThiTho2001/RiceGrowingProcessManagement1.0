<template>
     <Form @submit="newsprayingtimes.close = true, $emit('addSprayingTimes-submit', newsprayingtimes)"
          :validation-schema="schema" class="container createSprayingTimesForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times"
                         @click="newsprayingtimes.close = false, $emit('addSprayingTimes-submit', newsprayingtimes)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fas fa-edit actionIcon"></span> Thêm Lần Phun Thuốc
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-4 mt-2">
                    <div class="form-group">
                         <label for="ricecropid" class="mt-2">Mã mẫu ruộng <span style="color:red">*</span></label>
                         <Field name="ricecropid" type="name" class="form-control"
                              v-model="ricecropchoosen.RiceCropInformation_id" :disabled="true"/>
                         <ErrorMessage name="ricecropid" class="error-feedback" />
                    </div>


                    <div class="form-group">
                         <label for="employeeid" class="mt-3">Nhân viên thực hiện<span style="color:red">*</span></label>
                         <Field name="employeeid" class="form-control" v-model="currentuser.Employee_id"
                              placeholder="Nhập mã nhân viên...." :disabled="true"/>
                         <ErrorMessage name="employeeid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="start" class="mt-3">Ngày bắt đầu</label>
                         <Field name="start" class="form-control" v-model="newsprayingtimes.SprayingTimes_startDate"
                              placeholder="Ngày bắt đầu">
                              <datepicker :enable-time-picker="false" :value="newsprayingtimes.SprayingTimes_startDate"
                                   :hide-input-icon="true" v-model="newsprayingtimes.SprayingTimes_startDate"
                                   placeholder="YYYY-MM-DD">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="start" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="temperature" class="mt-3 pt-1">Nhiệt độ</label>
                         <Field name="temperature" class="form-control" v-model="newsprayingtimes.SprayingTimes_temperature"
                              placeholder="Nhập nhiệt độ..." />
                         <ErrorMessage name="temperature" class="error-feedback" />
                    </div>

               </div>
               <div class="col-sm-4">
                    <div class="form-group ">
                         <label for="times" class="mt-3">Lần<span style="color:red">*</span></label>
                         <Field name="times" class="form-control" v-model="newsprayingtimes.SprayingTimes_times"
                              placeholder="Nhập lần thực hiện..." />
                         <ErrorMessage name="times" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="developmentid" class="mt-3">Giai đoạn phát triển<span style="color:red">*</span></label>
                         <Field name="developmentid" class="form-control" v-model="newsprayingtimes.DevelopmentStage_name">
                              <select class="form-control" v-model="newsprayingtimes.DevelopmentStage_name" name="developmentid"
                                   for="developmentid">
                                   <option v-for="(developmentStage, i) in development" :key="i">
                                        {{ developmentStage.DevelopmentStage_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="developmentid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="end" class="">Ngày kết thúc</label>
                         <Field name="harvendestDate" class="form-control"
                              v-model="newsprayingtimes.SprayingTimes_endDate" placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newsprayingtimes.SprayingTimes_endDate"
                                   :hide-input-icon="true" v-model="newsprayingtimes.SprayingTimes_endDate"
                                   placeholder="YYYY-MM-DD">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="end" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="radiation" class="mt-3 pt-1">Độ ẩm</label>
                         <Field name="radiation" class="form-control" v-model="newsprayingtimes.SprayingTimes_radiation"
                              placeholder="Nhập độ ẩm..." />
                         <ErrorMessage name="radiation" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-4">

                    <div class="form-group">
                         <label for="fertilizer" class="mt-3">tên thuốc<span style="color:red">*</span></label>
                         <Field name="fertilizer" v-model="newsprayingtimes.Pesticide_name">
                              <select class="form-control" v-model="newsprayingtimes.Pesticide_name" name="classtify"
                                   for="classtify">
                                   <option v-for="(pesticide, i) in pesticideList" :key="i">{{ pesticide.Pesticide_name
                                   }}
                                   </option>

                              </select>
                         </Field>
                         <ErrorMessage name="fertilizer" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="amount" class="mt-1">Số lượng(kg/ha)<span style="color:red">*</span></label>
                         <Field name="amount" class="form-control" v-model="newsprayingtimes.SprayingTimes_amount"
                              placeholder="Nhập số lượng phân đã bón..." />
                         <ErrorMessage name="amount" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="precipitation" class="mt-2 pt-1">Lượng mưa</label>
                         <Field name="precipitation" class="form-control" v-model="newsprayingtimes.SprayingTimes_precipitation"
                              placeholder="Nhập lượng mưa..." />
                         <ErrorMessage name="precipitation" class="error-feedback" />
                    </div>

               </div>
          </div>

          <div class="row ">
               <div class="col-sm-2"></div>
               <div class="col-sm-8 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         {{ message2 }}</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }}
                    </span>
               </div>
               <div class="col-sm-2"></div>
          </div>
          <div class="row mb-4">
               <div class="col-sm-5"></div>
               <button class="btn btn-outline-secondary btnLuu col-sm-2">Lưu</button>
               <div class="col-sm-5"></div>
          </div>

     </form>
</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';

export default {
     name: "createSprayingTimesForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["addSprayingTimes-submit"],
     props: ["newSprayingTimes", "message1", "message2", "pesticideList", "developmentStageList", "currentUser", "riceCropChoosen"],
     data() {

          const schema = yup.object().shape({
               ricecropid: yup
                    .string()
                    .required("Mã mẫu ruộng phải có giá trị")
                    .min(10, "Mã mẫu ruộng phải gồm 10 ký tự")
                    .max(10, "Mã mẫu ruộng phải gồm 10 ký tự"),
               employeeid: yup
                    .string()
                    .required("Tên mã nhân viên phải có giá trị"),
               developmentid: yup
                    .string()
                    .required("Giai đoạn phát triển phải có giá trị"),
               times: yup
                    .string()
                    .required("Lần bón phải có giá trị"),
               amount: yup
                    .string()
                    .required("Số lượng phải có giá trị"),
               start: yup
                    .string(),
               // .required("Phân loại bệnh dịch phải có giá trị"),
               end: yup
                    .string(),
               // .required("Tác hại bệnh dịch phải có giá trị"),
               fertilizer: yup
                    .string()
                    .required("Loại phân phải có giá trị"),
               temperature: yup
                    .string(),
                    // .required("Loại phân phải có giá trị"),
               radiation: yup
                    .string(),
                    // .required("Loại phân phải có giá trị"),
               precipitation: yup
                    .string(),
                    // .required("Loại phân phải có giá trị"),
          });
          return {
               newsprayingtimes: this.newSprayingTimes,
               currentuser: this.currentUser,
               development: this.developmentStageList,
               ricecropchoosen: this.riceCropChoosen,
               schema,
          };
     },

     methods: {

     }
};
</script>
 
<style>
@import url(../../assets/sprayingTimesStyle.css);
</style>