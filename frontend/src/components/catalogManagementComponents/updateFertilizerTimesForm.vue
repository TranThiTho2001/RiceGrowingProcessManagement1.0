<template>
     <Form @submit="newfertilizertimes.close = true, $emit('updateFertilizerTimes-submit', newfertilizertimes)"
          :validation-schema="schema" class="form container-fluid updateFertilizerTimesForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle"
                         @click="newfertilizertimes.close = false, $emit('updateFertilizerTimes-submit', newfertilizertimes)"
                         style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>

          <div class="row">
               <p class="col-sm-12 text-center functionName">
                    CẬP NHẬT THÔNG TIN LẦN BÓN PHÂN CỦA MÙA VỤ
               </p>
          </div>

          <div class="row content">
               <div class="col-sm-6">
                    <div class="form-group">
                         <label for="ricecropid" class="mt-2">Mã mẫu ruộng <span style="color:red">*</span></label>
                         <Field name="ricecropid" type="name" class=" form-control-none-bg form-control"
                              v-model="ricecropchosen.RiceCropInformation_id" disabled />
                         <ErrorMessage name="ricecropid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="employeeid" class="mt-3">Nhân viên thực hiện<span style="color:red">*</span></label>
                         <Field name="employeeid" class="form-control-none-bg form-control" v-model="currentuser.Employee_id"
                              placeholder="Nhập mã nhân viên...." disabled />
                         <ErrorMessage name="employeeid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="start" class="mt-3 pt-1">Ngày bắt đầu</label>
                         <Field name="start" class="form-control" v-model="newfertilizertimes.FertilizerTimes_startDate"
                              placeholder="Ngày bắt đầu">
                              <datepicker :enable-time-picker="false" :value="newfertilizertimes.FertilizerTimes_startDate"
                                   :hide-input-icon="true" v-model="newfertilizertimes.FertilizerTimes_startDate"
                                   @closed="getWeather" placeholder="DD-MM-YYYY" format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                              <label v-if="newfertilizertimes.FertilizerTimes_startDate == null"><i style="color: #959595; position: absolute;z-index: 1; left: 5%; margin-top:8px;" class="far fa-calendar-alt" ></i></label>
                         </Field>
                         <ErrorMessage name="start" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="fertilizer" class="mt-3 pt-1">Loại phân<span style="color:red">*</span></label>
                         <Field name="fertilizer" v-model="newfertilizertimes.Fertilizer_name">
                              <select class="selectBox form-control" v-model="newfertilizertimes.Fertilizer_name" name="classtify" disabled
                                   for="classtify">
                                   <option v-for="(fertilizer, i) in fertilizerList" :key="i">{{ fertilizer.Fertilizer_name
                                   }}
                                   </option>

                              </select>
                         </Field>
                         <ErrorMessage name="fertilizer" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-6">
                    <div class="form-group ">
                         <label for="times" class="mt-1 pt-1">Lần<span style="color:red">*</span></label>
                         <Field name="times" class="form-control-none-bg form-control" v-model="newfertilizertimes.FertilizerTimes_times"
                              placeholder="Nhập lần thực hiện..." disabled />
                         <ErrorMessage name="times" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="developmentid" class="mt-3">Giai đoạn phát triển<span style="color:red">*</span></label>
                         <Field name="developmentid" class="form-control" v-model="newfertilizertimes.DevelopmentStage_name">
                              <select class="selectBox form-control" v-model="newfertilizertimes.DevelopmentStage_name" 
                                   name="developmentid" for="developmentid">
                                   <option v-for="(developmentStage, i) in developmentStageList" :key="i">
                                        {{ developmentStage.DevelopmentStage_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="developmentid" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="end" class="mt-1">Ngày kết thúc</label>
                         <Field name="harvendestDate" class="form-control"
                              v-model="newfertilizertimes.FertilizerTimes_endDate" placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newfertilizertimes.FertilizerTimes_endDate"
                                   :hide-input-icon="true" v-model="newfertilizertimes.FertilizerTimes_endDate"
                                   @closed="getWeather()" placeholder="DD-MM-YYYY" format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                              <label v-if="newfertilizertimes.FertilizerTimes_endDate == null"><i style="color: #959595; position: absolute;z-index: 1; left: 5%; margin-top:8px;" class="far fa-calendar-alt" ></i></label>
                         </Field>
                         <ErrorMessage name="end" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="amount" class="mt-3 pt-1">Số lượng(kg/ha)<span style="color:red">*</span></label>
                         <Field name="amount" class="form-control" v-model="newfertilizertimes.FertilizerTimes_amount"
                              placeholder="Nhập số lượng phân đã bón..." />
                         <ErrorMessage name="amount" class="error-feedback" />
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
                         {{ message2 }}</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }}
                    </span>
               </div>
          </div>

          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu col-sm-2">Cập Nhật</button>
               </div>
          </div>

     </form>
</template>
 
<script>
import * as yup from "yup";
import '@vuepic/vue-datepicker/dist/main.css';
import Datepicker from '@vuepic/vue-datepicker';
import { Form, Field, ErrorMessage } from "vee-validate";

export default {
     name: "updateFertilizerTimesForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     
     emits: ["updateFertilizerTimes-submit"],
     
     props: ["newFertilizerTimes", "message1", "message2", "fertilizerList", "developmentStageList", "currentUser", "riceCropChosen"],
     
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
               end: yup
                    .string(),
               fertilizer: yup
                    .string()
                    .required("Loại phân phải có giá trị"),
          });
          return {
               newfertilizertimes: this.newFertilizerTimes,
               ricecropchosen: this.riceCropChosen,
               currentuser: this.currentUser,
               development: this.developmentStageList,
               weatherInfor: [],
               schema,
          };
     },

     methods: {

     }
};
</script>
 
<style>
@import url(../../assets/fertilizerTimeStyle.css);
@import url(../../assets/mainStyle.css);
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
     border-radius: 10px !important;
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
}
</style>