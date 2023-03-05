<template>
     <Form @submit="newfertilizertimes.close = true, $emit('updateFertilizerTimes-submit', newfertilizertimes)"
          :validation-schema="schema" class="container updateFertilizerTimesForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times"
                         @click="newfertilizertimes.close = false, $emit('updateFertilizerTimes-submit', newfertilizertimes)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fas fa-edit actionIcon"></span> Thêm lần bón phân</p>
          </div>
          <div class="row content">
               <div class="col-sm-4 mt-2">
                    <div class="form-group">
                         <label for="ricecropid" class="mt-2">Mã mẫu ruộng <span style="color:red">*</span></label>
                         <Field name="ricecropid" type="name" class="form-control"
                              v-model="ricecropchoosen.RiceCropInformation_id" />
                         <ErrorMessage name="ricecropid" class="error-feedback" />
                    </div>


                    <div class="form-group">
                         <label for="employeeid" class="mt-3">Nhân viên thực hiện<span style="color:red">*</span></label>
                         <Field name="employeeid" class="form-control" v-model="currentuser.Employee_id"
                              placeholder="Nhập mã nhân viên...." />
                         <ErrorMessage name="employeeid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="start" class="mt-3 pt-1">Ngày bắt đầu</label>
                         <Field name="start" class="form-control" v-model="newfertilizertimes.FertilizerTimes_startDate"
                              placeholder="Ngày bắt đầu">
                              <datepicker :enable-time-picker="false" :value="newfertilizertimes.FertilizerTimes_startDate"
                                   :hide-input-icon="true" v-model="newfertilizertimes.FertilizerTimes_startDate"
                                   placeholder="YYYY-MM-DD">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="start" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="temperature" class="mt-3 pt-1">Nhiệt độ</label>
                         <Field name="temperature" class="form-control"
                              v-model="newfertilizertimes.FertilizerTimes_temperature" placeholder="Nhập nhiệt độ..." />
                         <ErrorMessage name="temperature" class="error-feedback" />
                    </div>

               </div>
               <div class="col-sm-4">
                    <div class="form-group ">
                         <label for="times" class="mt-3 pt-1">Lần<span style="color:red">*</span></label>
                         <Field name="times" class="form-control" v-model="newfertilizertimes.FertilizerTimes_times"
                              placeholder="Nhập lần thực hiện..." />
                         <ErrorMessage name="times" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="developmentid" class="mt-3">Giai đoạn phát triển<span style="color:red">*</span></label>
                         <Field name="developmentid" class="form-control" v-model="newfertilizertimes.DevelopmentStage_name">
                              <select class="form-control" v-model="newfertilizertimes.DevelopmentStage_name"
                                   name="developmentid" for="developmentid">
                                   <option v-for="(developmentStage, i) in developmentStageList" :key="i">
                                        {{ developmentStage.DevelopmentStage_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="developmentid" class="error-feedback" />
                    </div>
                    <div class="form-group ">
                         <label for="end" class="">Ngày kết thúc</label>
                         <Field name="harvendestDate" class="form-control"
                              v-model="newfertilizertimes.FertilizerTimes_endDate" placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newfertilizertimes.FertilizerTimes_endDate"
                                   :hide-input-icon="true" v-model="newfertilizertimes.FertilizerTimes_endDate"
                                   placeholder="YYYY-MM-DD">
                              </datepicker>
                         </Field>
                    </div>
                    <ErrorMessage name="end" class="error-feedback" />
                    <div class="form-group ">
                         <label for="humidity" class="mt-3 pt-1">Độ ẩm</label>
                         <Field name="humidity" class="form-control" v-model="newfertilizertimes.FertilizerTimes_humidity"
                              placeholder="Nhập độ ẩm..." />
                         <ErrorMessage name="humidity" class="error-feedback" />
                    </div>
               </div>



               <div class="col-sm-4 ">
                    <div class="form-group ">
                         <label for="fertilizer" class="mt-3 pt-1">Loại phân<span style="color:red">*</span></label>
                         <Field name="fertilizer" v-model="newfertilizertimes.Fertilizer_name">
                              <select class="form-control" v-model="newfertilizertimes.Fertilizer_name" name="classtify"
                                   for="classtify">
                                   <option v-for="(fertilizer, i) in fertilizerList" :key="i">{{ fertilizer.Fertilizer_name
                                   }}
                                   </option>

                              </select>
                         </Field>
                         <ErrorMessage name="fertilizer" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="amount" class="mt-1">Số lượng(kg/ha)<span style="color:red">*</span></label>
                         <Field name="amount" class="form-control" v-model="newfertilizertimes.FertilizerTimes_amount"
                              placeholder="Nhập số lượng phân đã bón..." />
                         <ErrorMessage name="amount" class="error-feedback" />
                    </div>

                    <div class="form-group">

                    </div>
                    <div class="form-group">
                         <label for="precipitation" class="mt-2 pt-1">Lượng mưa</label>
                         <Field name="precipitation" class="form-control"
                              v-model="newfertilizertimes.FertilizerTimes_precipitation" placeholder="Nhập lượng mưa..." />
                         <ErrorMessage name="precipitation" class="error-feedback" />
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
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }}
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
     name: "updateFertilizerTimesForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["updateFertilizerTimes-submit"],
     props: ["newFertilizerTimes", "message1", "message2", "fertilizerList", "developmentStageList", "currentUser", "riceCropChoosen"],
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
                    .string()
                    .nullable(),
               // .required("Loại phân phải có giá trị"),
               humidity: yup
                    .string()
                    .nullable(),
               // .required("Loại phân phải có giá trị"),
               precipitation: yup
                    .string()
                    .nullable(),
               // .required("Loại phân phải có giá trị"),
          });
          return {
               newfertilizertimes: this.newFertilizerTimes,
               ricecropchoosen: this.riceCropChoosen,
               currentuser: this.currentUser,
               development: this.developmentStageList,
               schema,
          };
     },

     methods: {

     }
};
</script>
 
<style>
@import url(../../assets/fertilizerTimeStyle.css);
</style>