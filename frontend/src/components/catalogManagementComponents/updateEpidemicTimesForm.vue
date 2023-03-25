<template>
     <Form @submit="newepidemictimes.close = true, $emit('updateEpidemicTimes-submit', newepidemictimes)"
          :validation-schema="schema" class="form container updateEpidemicTimesForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times"
                         @click="newepidemictimes.close = false, $emit('updateEpidemicTimes-submit', newepidemictimes)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><span class="fas fa-edit actionIcon"></span> Cập Nhật Lần Bị
                    Bệnh Dịch</p>
          </div>
          <div class="row content">
               <div class="col-sm-6 mt-2">
                    <div class="form-group">
                         <label for="ricecropid" class="mt-2">Mã mẫu ruộng <span style="color:red">*</span></label>
                         <Field name="ricecropid" type="name" class="form-control"
                              v-model="ricecropchoosen.RiceCropInformation_id" :disabled="true" />
                         <ErrorMessage name="ricecropid" class="error-feedback" />
                    </div>


                    <div class="form-group">
                         <label for="employeeid" class="mt-3">Nhân viên thực hiện<span style="color:red">*</span></label>
                         <Field name="employeeid" class="form-control" v-model="currentuser.Employee_id" :disabled="true"
                              placeholder="Nhập mã nhân viên...." />
                         <ErrorMessage name="employeeid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="start" class="mt-3 pt-1">Ngày bắt đầu</label>
                         <Field name="start" class="form-control" v-model="newepidemictimes.EpidemicTimes_startDate"
                              placeholder="Ngày bắt đầu">
                              <datepicker :enable-time-picker="false" :value="newepidemictimes.EpidemicTimes_startDate"
                                   :hide-input-icon="true" v-model="newepidemictimes.EpidemicTimes_startDate"
                                   placeholder="DD-MM-YYYY" format="dd-MM-yyyy" :clearable="false" >
                              </datepicker>
                         </Field>
                         <ErrorMessage name="start" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="temperature" class="mt-3 pt-1">Nhiệt độ</label>
                         <Field name="temperature" class="form-control" v-model="newepidemictimes.EpidemicTimes_temperature"
                              placeholder="Nhập nhiệt độ..." />
                         <ErrorMessage name="temperature" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="precipitation" class="mt-2 pt-1">Lượng mưa</label>
                         <Field name="precipitation" class="form-control"
                              v-model="newepidemictimes.EpidemicTimes_precipitation" placeholder="Nhập lượng mưa..." />
                         <ErrorMessage name="precipitation" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-6">
                    <div class="form-group ">
                         <label for="fertilizer" class="mt-3 pt-1">Tên bệnh dịch<span style="color:red">*</span></label>
                         <Field name="fertilizer" v-model="newepidemictimes.Epidemic_name">
                              <select class="form-control" v-model="newepidemictimes.Epidemic_name" name="classtify"
                                   for="classtify">
                                   <option v-for="(epidemic, i) in epidemicList" :key="i">{{ epidemic.Epidemic_name
                                   }}
                                   </option>

                              </select>
                         </Field>
                         <ErrorMessage name="fertilizer" class="error-feedback" />
                    </div>
                    <div class="form-group ">
                         <label for="times" class="mt-3 pt-1">Lần<span style="color:red">*</span></label>
                         <Field name="times" class="form-control" v-model="newepidemictimes.EpidemicTimes_times"
                              placeholder="Nhập lần thực hiện..." :disabled="true" />
                         <ErrorMessage name="times" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="developmentid" class="mt-3">Giai đoạn phát triển<span style="color:red">*</span></label>
                         <Field name="developmentid" class="form-control" v-model="newepidemictimes.DevelopmentStage_name">
                              <select class="form-control" v-model="newepidemictimes.DevelopmentStage_name"
                                   name="developmentid" for="developmentid">
                                   <option v-for="(developmentStage, i) in development" :key="i">
                                        {{ developmentStage.DevelopmentStage_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="developmentid" class="error-feedback" />
                    </div>
                    <div class="form-group ">
                         <label for="end" class="">Ngày kết thúc</label>
                         <Field name="harvendestDate" class="form-control" v-model="newepidemictimes.EpidemicTimes_endDate"
                              placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newepidemictimes.EpidemicTimes_endDate"
                                   :hide-input-icon="true" v-model="newepidemictimes.EpidemicTimes_endDate"
                                   placeholder="DD-MM-YYYY"  format="dd-MM-yyyy" :clearable="false" >
                              </datepicker>
                         </Field>
                          <ErrorMessage name="end" class="error-feedback" />
                    </div>
                        
                    <div class="form-group ">
                         <label for="humidity" class="mt-3 pt-1">Độ ẩm</label>
                         <Field name="humidity" class="form-control" v-model="newepidemictimes.EpidemicTimes_humidity"
                              placeholder="Nhập độ ẩm..." />
                         <ErrorMessage name="humidity" class="error-feedback" />
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
     name: "updateEpidemicTimesForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["updateEpidemicTimes-submit"],
     props: ["newEpidemicTimes", "message1", "message2", "epidemicList", "developmentStageList", "currentUser", "riceCropChoosen"],
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
                    .required("Lần bị bệnh dịch phải có giá trị"),
               // amount: yup
               //      .string()
               //      .required("Phân loại phải có giá trị"),
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
               newepidemictimes: this.newEpidemicTimes,
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
@import url(../../assets/epidemicTimesStyle.css);
.dp__theme_light {
    --dp-background-color:  #FAFAFC;
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
    font-family: -apple-system,blinkmacsystemfont,"Segoe UI",roboto,oxygen,ubuntu,cantarell,"Open Sans","Helvetica Neue",sans-serif;
    border: 1px solid var(--dp-border-color);
    outline: none;
    transition: border-color .2s cubic-bezier(0.645, 0.045, 0.355, 1);
    width: 100%;
    font-size: 1rem;
    line-height: 1.5rem;
    padding: 6px 12px;
    color: var(--dp-text-color);box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
    box-sizing: border-box;
}
</style>