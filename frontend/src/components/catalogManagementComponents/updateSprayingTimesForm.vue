<template>
     <Form @submit="newsprayingtimes.close = true, $emit('updateSprayingTimes-submit', newsprayingtimes)"
          :validation-schema="schema" class="form container-fluid updateSprayingTimesForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle"
                         @click="newsprayingtimes.close = false, $emit('updateSprayingTimes-submit', newsprayingtimes)"
                         style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>

          <div class="row">
               <p class="col-sm-12 text-center functionName">
                    CẬP NHẬT THÔNG TIN LẦN PHUN THUỐC CỦA MÙA VỤ
               </p>
          </div>

          <div class="row content">
               <div class="col-sm-6 mt-2">
                    <div class="form-group">
                         <label for="ricecropid" class="mt-2">Mã mẫu ruộng <span style="color:red">*</span></label>
                         <Field name="ricecropid" type="name" class="form-control-none-bg form-control" disabled
                              v-model="ricecropchosen.RiceCropInformation_id" />
                         <ErrorMessage name="ricecropid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="employeeid" class="mt-3">Nhân viên thực hiện<span style="color:red">*</span></label>
                         <Field name="employeeid" class="form-control-none-bg form-control" v-model="currentuser.Employee_id"
                              placeholder="Nhập mã nhân viên...." disabled />
                         <ErrorMessage name="employeeid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="fertilizer" class="mt-3">Tên thuốc<span style="color:red">*</span></label>
                         <Field name="fertilizer" v-model="newsprayingtimes.Pesticide_name">
                              <select class="selectBox form-control" v-model="newsprayingtimes.Pesticide_name"
                                   name="classtify" style="height: 35px !important;" for="classtify">
                                   <option v-for="(pesticide, i) in pesticideList" :key="i">{{ pesticide.Pesticide_name
                                   }}
                                   </option>

                              </select>
                         </Field>
                         <ErrorMessage name="fertilizer" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="start" class="">Ngày bắt đầu</label>
                         <Field name="start" class="form-control" v-model="newsprayingtimes.SprayingTimes_startDate"
                              placeholder="Ngày bắt đầu">
                              <datepicker :enable-time-picker="false" :value="newsprayingtimes.SprayingTimes_startDate"
                                   :hide-input-icon="true" v-model="newsprayingtimes.SprayingTimes_startDate"
                                   format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                              <label v-if="newsprayingtimes.SprayingTimes_startDate == null"><i
                                        style="color: #959595; position: absolute;z-index: 1; left: 5%; margin-top:8px;"
                                        class="far fa-calendar-alt"></i></label>
                         </Field>
                         <ErrorMessage name="start" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-6">
                    <div class="form-group ">
                         <label for="times" class="mt-3">Lần<span style="color:red">*</span></label>
                         <Field name="times" class="form-control-none-bg form-control"
                              v-model="newsprayingtimes.SprayingTimes_times" placeholder="Nhập lần thực hiện..." />
                         <ErrorMessage name="times" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="developmentid" class="mt-3">Giai đoạn phát triển<span style="color:red">*</span></label>
                         <Field name="developmentid" class="form-control" v-model="newsprayingtimes.DevelopmentStage_name">
                              <select class="selectBox form-control" v-model="newsprayingtimes.DevelopmentStage_name"
                                   style="height: 35px !important;" name="developmentid" for="developmentid">
                                   <option v-for="(developmentStage, i) in development" :key="i">
                                        {{ developmentStage.DevelopmentStage_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="developmentid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="amount" class="">Liều lượng(ml/ha)<span style="color:red">*</span></label>
                         <Field name="amount" class="form-control" v-model="newsprayingtimes.SprayingTimes_amount"
                              placeholder="Nhập số lượng phân đã bón..." />
                         <ErrorMessage name="amount" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="end" class="mt-3">Ngày kết thúc</label>
                         <Field name="harvendestDate" class="form-control" v-model="newsprayingtimes.SprayingTimes_endDate"
                              placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newsprayingtimes.SprayingTimes_endDate"
                                   :hide-input-icon="true" v-model="newsprayingtimes.SprayingTimes_endDate"
                                   format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                              <label v-if="newsprayingtimes.SprayingTimes_endDate == null"><i
                                        style="color: #959595; position: absolute;z-index: 1; left: 5%; margin-top:8px;"
                                        class="far fa-calendar-alt"></i></label>
                         </Field>
                         <ErrorMessage name="end" class="error-feedback" />
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
                         Cập nhật lần phun thuốc thành công</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> Cập nhật lần phun
                         thuốc không thành công
                    </span>
               </div>
          </div>

          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu btnUpdate-">Cập Nhật</button>
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
     name: "updateSprayingTimesForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["updateSprayingTimes-submit"],
     props: ["newSprayingTimes", "message1", "message2", "pesticideList", "developmentStageList", "currentUser", "riceCropChosen"],
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
               temperature: yup
                    .string()
                    .nullable(),
               humidity: yup
                    .string()
                    .nullable(),
               precipitation: yup
                    .string()
                    .nullable(),
          });

          return {
               newsprayingtimes: this.newSprayingTimes,
               currentuser: this.currentUser,
               development: this.developmentStageList,
               ricecropchosen: this.riceCropChosen,
               schema,
          };
     },

     methods: {
     }
};
</script>
 
<style>
@import url(../../assets/sprayingTimesStyle.css);
@import url(../../assets/mainStyle.css);

.dp__theme_light {
     --dp-background-color: #FAFAFC;
     --dp-border-radius: 10px;
     --dp-text-color: #212121;
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
     border-radius: 10px;
     font-family: -apple-system, blinkmacsystemfont, "Segoe UI", roboto, oxygen, ubuntu, cantarell, "Open Sans", "Helvetica Neue", sans-serif;
     border: 1px solid var(--dp-border-color);
     outline: none;
     transition: border-color .2s cubic-bezier(0.645, 0.045, 0.355, 1);
     width: 100%;
     font-size: 1rem;
     line-height: 1.5rem;
     padding: 6px 12px;
     color: var(--dp-text-color);
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     box-sizing: border-box;
     height: 35px !important;
}</style>