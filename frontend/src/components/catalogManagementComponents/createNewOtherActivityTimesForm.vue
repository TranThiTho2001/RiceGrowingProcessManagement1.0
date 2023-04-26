<template>
     <Form @submit="newactivitiesDetail.close = true, $emit('addOtherActivityTimes-submit', newactivitiesDetail)"
          :validation-schema="schema" class="form container-fluid createActivityDetailForm" :class="{open:openCreateNewOtherActivity}">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle"
                         @click="newactivitiesDetail.close = false, $emit('addOtherActivityTimes-submit', newactivitiesDetail)"
                         style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName">THÊM LẦN THỰC HIỆN HOẠT ĐỘNG CHO MÙA VỤ</p>
          </div>
          <div class="row content">
               <div class="col-sm-6 mt-2">
                    <div class="form-group">
                         <label for="ricecropid" class="mt-2 lable">Mã mùa vụ <span style="color:red">*</span></label>
                         <Field name="ricecropid" type="name" class="form-control-none-bg form-control"
                              v-model="ricecropchosen.RiceCropInformation_id" disabled/>
                         <ErrorMessage name="ricecropid" class="error-feedback" />
                    </div>
                    <div class="form-group ">
                         <label for="activity" class="mt-3">Tên hoạt động<span style="color:red">*</span></label>
                         <Field name="activity" v-model="newactivitiesDetail.OtherActivities_name">
                              <select class="selectBox form-control" v-model="newactivitiesDetail.OtherActivities_name" style="background:  #F0F2F7;box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);"
                                   @change="setOtherActivies()" name="classtify" for="classtify">
                                   <option v-for="(otheractivities, i) in otherActivitiesList" :key="i">{{
                                        otheractivities.OtherActivities_name
                                   }}
                                   </option>
                                   <option>Thêm hoạt động mới</option>
                              </select>
                         </Field>
                         <ErrorMessage name="activity" class="error-feedback" />
                    </div>
                    <div class="form-group">
                         <label for="start" class="lable ">Ngày bắt đầu</label>
                         <Field name="start" class="form-control" v-model="newactivitiesDetail.ActivityDetails_startDate"
                              placeholder="Ngày bắt đầu">
                              <datepicker :enable-time-picker="false" :value="newactivitiesDetail.ActivityDetails_startDate"
                                   :hide-input-icon="true" v-model="newactivitiesDetail.ActivityDetails_startDate"
                                    format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                              <label v-if="newactivitiesDetail.ActivityDetails_startDate == null"><i style="color: #959595; position: absolute;z-index: 1; left: 5%; margin-top:8px;" class="far fa-calendar-alt" ></i></label>
                         </Field>
                         <ErrorMessage name="start" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="employeeid" class="mt-3 lable">Nhân viên thực hiện<span
                                   style="color:red">*</span></label>
                         <Field name="employeeid" class="form-control-none-bg form-control" v-model="currentuser.Employee_id"
                              placeholder="Nhập mã nhân viên...." disabled />
                         <ErrorMessage name="employeeid" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-6">
                    <div class="form-group">
                         <label for="developmentid" class="mt-3 lable">Giai đoạn phát triển<span
                                   style="color:red">*</span></label>
                         <Field name="developmentid" class="form-control"
                              v-model="newactivitiesDetail.DevelopmentStage_name">
                              <select class="selectBox form-control" v-model="newactivitiesDetail.DevelopmentStage_name"
                                   name="developmentid" for="developmentid">
                                   <option v-for="(developmentStage, i) in development" :key="i">
                                        {{ developmentStage.DevelopmentStage_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="developmentid" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="times" class="">Lần<span style="color:red">*</span></label>
                         <Field name="times" class="form-control-none-bg form-control" v-model="newactivitiesDetail.ActivityDetails_times"
                              placeholder="Nhập lần thực hiện..."  />
                         <ErrorMessage name="times" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="end" class="mt-3">Ngày kết thúc</label>
                         <Field name="harvendestDate" class="form-control"
                              v-model="newactivitiesDetail.ActivityDetails_endDate">
                              <datepicker :enable-time-picker="false" :value="newactivitiesDetail.ActivityDetails_endDate"
                                   :hide-input-icon="true" v-model="newactivitiesDetail.ActivityDetails_endDate"
                                     format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                              <label v-if="newactivitiesDetail.ActivityDetails_endDate == null"><i style="color: #959595; position: absolute;z-index: 1; left: 5%; margin-top:8px;" class="far fa-calendar-alt" ></i></label>
                         </Field>
                         <ErrorMessage name="end" class="error-feedback" />
                    </div>
               </div>
          </div>

          <div class="row">
               <div class="col-sm-12 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         Thêm lần thực hiện hoạt động thành công</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> Thêm lần thực hiện hoạt động không thành công
                    </span>
               </div>
          </div>
          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu btnSave">Lưu</button>
               </div>
          </div>

     </form>
     <CreateNewOtherActiviesForm v-if="isOpenCreateOtherActivities" :newOtherActivities="newOtherActivities"
          :message1="message3" :message2="message4" @addOtherActivities-submit=createNewOtherActivities />
</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import moment from "moment";
import OtherActivitiesService from "@/services/otherActivities.service";
import ActivityDetailsService from "@/services/activityDetails.service";
import CreateNewOtherActiviesForm from '@/components/catalogManagementComponents/createNewOtherActivities.vue';
export default {
     name: "createActivitiesDetailForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
          CreateNewOtherActiviesForm,
     },
     emits: ["addOtherActivityTimes-submit"],
     props: ["newActivityDetail", "message1", "message2", "developmentStageList", "currentUser", "riceCropChosen"],
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
               start: yup
                    .string(),
               end: yup
                    .string(),
               activity: yup
                    .string()
                    .required("Tên hoạt động phải có giá trị"),
               // temperature: yup
               //      .string(),
               // humidity: yup
               //      .string(),
               // precipitation: yup
               //      .string(),
               // windspeed: yup
               //      .string()
               //      .nullable(),
               // solarradiation: yup
               //      .string()
               //      .nullable(),
          });
          return {
               newactivitiesDetail: this.newActivityDetail,
               ricecropchosen: this.riceCropChosen,
               currentuser: this.currentUser,
               development: this.developmentStageList,
               isOpenCreateOtherActivities: false,
               otherActivitiesList: [],
               newOtherActivities: {},
               message3: "",
               message4: "",
               weatherInfor: {},
               schema,
               openCreateNewOtherActivity: false,
          };
     },

     methods: {
          async setOtherActivies() {
               if (this.newactivitiesDetail.OtherActivities_name == "Thêm hoạt động mới") {
                    this.isOpenCreateOtherActivities = true;
                    this.openCreateNewOtherActivity = true;
               }
               else {
                    this.otherActivitiesList.forEach(element => {
                         if (this.newactivitiesDetail.OtherActivities_name == element.OtherActivities_name) {
                              this.newactivitiesDetail.OtherActivities_id = element.OtherActivities_id;
                              this.getTimes(this.newactivitiesDetail.OtherActivities_id)
                         }
                    });
               }

          },

          async getTimes(data) {
               console.log(data)
               const [err, response] = await this.handle(
                    ActivityDetailsService.get(this.riceCropChosen.RiceCropInformation_id, data)
               );
               if (err) {
                    console.log(err)
               }
               else if (response.data == "Không tìm thấy chi tiết hoạt động.") {

                    this.newactivitiesDetail.ActivityDetails_times = 1;
               }
               else {
                    var temp = response.data;
                    this.newactivitiesDetail.ActivityDetails_times = temp.length + 1;
               }
          },

          async setDevelopmentStage(data) {
               this.newactivitiesDetail.DevelopmentStage_id = data.DevelopmentStage_id;
               console.log(data.DevelopmentStage_id)
          },

          async createNewOtherActivities(data) {
               this.message3 = "";
               this.message4 = "";
               if (!data.close) {
                    this.isOpenCreateOtherActivities = false;
                    this.openCreateNewOtherActivity = false;
               }
               else {
                    const [error, response] = await this.handle(
                         OtherActivitiesService.create(data)
                    );
                    if (response.data == error) {
                         this.message3 = "Thêm không thành công.";
                    }
                    else if (response.data == "Không thể tạo chi tiết hoạt động mới.") {
                         this.message3 = "Thêm không thành công.";
                    }
                    else {
                         this.message4 = "Thêm thành công.";
                         this.retrieveOtherActivities();
                    }
               }
          },

          async retrieveOtherActivities() {
               const [err, respone] = await this.handle(
                    OtherActivitiesService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.otherActivitiesList = respone.data;
                    var temp = (String(this.otherActivitiesList[this.otherActivitiesList.length - 1].OtherActivities_id)).split("");
                    console.log(temp)
                    var id = 0;
                    temp.forEach(element => {
                         if (element != "O" && element != "A") {
                              for (let index = temp.indexOf(element); index < temp.length; index++) {
                                   id += temp[index];
                                   break;
                              }
                         }
                    });
                    this.newOtherActivities.OtherActivities_id = "OA" + String(Number(id) + 1);
                    console.log(this.newOtherActivities.OtherActivities_id)
               }
          },
          async getWeather() {
               this.newactivitiesDetail.ActivityDetails_temperature = "";
               this.newactivitiesDetail.ActivityDetails_windSpeed = "";
               this.newactivitiesDetail.ActivityDetails_precipitation = "";
               this.newactivitiesDetail.ActivityDetails_solarRadiation = "";
               this.newactivitiesDetail.ActivityDetails_humidity = "";
               let date = new Date();
               if (moment(this.newactivitiesDetail.ActivityDetails_startDate).format("YYYY-MM-DD") == moment(date).format("YYYY-MM-DD")) {
                    let urlAPI = `https://api.open-meteo.com/v1/forecast?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&current_weather=true&forecast_days=1&daily=shortwave_radiation_sum&timezone=auto&daily=precipitation_sum&hourly=relativehumidity_2m`;
                    let data = await fetch(urlAPI).then(res => res.json())
                    if (data.error != true) {
                         this.newactivitiesDetail.ActivityDetails_temperature = data.current_weather.temperature;
                         this.newactivitiesDetail.ActivityDetails_windSpeed = data.current_weather.windspeed;
                         this.newactivitiesDetail.ActivityDetails_precipitation = data.daily.precipitation_sum[0];
                         this.newactivitiesDetail.ActivityDetails_solarRadiation = data.daily.shortwave_radiation_sum[0];
                         date = moment(date).format("YYYY-MM-DDTHH:00")
                         var i = 0;
                         data.hourly.time.forEach(element => {
                              if (element == date) {
                                   this.newactivitiesDetail.ActivityDetails_humidity = data.hourly.relativehumidity_2m[i]
                              }
                              i++;
                         });
                    }
                    else {
                         this.newactivitiesDetail.ActivityDetails_temperature = "";
                         this.newactivitiesDetail.ActivityDetails_windSpeed = "";
                         this.newactivitiesDetail.ActivityDetails_precipitation = "";
                         this.newactivitiesDetail.ActivityDetails_solarRadiation = "";
                         this.newactivitiesDetail.ActivityDetails_humidity = "";
                    }
               }
               const end = new Date(this.newactivitiesDetail.ActivityDetails_endDate);
               const start = new Date(this.newactivitiesDetail.ActivityDetails_startDate);
               console.log((end.getTime() - start.getTime()) / (24 * 3600 * 1000))
               if (((end.getTime() - start.getTime()) / (24 * 3600 * 1000)) + 1 <= 7 && this.newactivitiesDetail.ActivityDetails_endDate != '') {
                    let urlAPI2 = `https://api.open-meteo.com/v1/forecast?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&start_date=${moment(this.newactivitiesDetail.ActivityDetails_startDate).format("YYYY-MM-DD")}&end_date=${moment(this.newactivitiesDetail.ActivityDetails_endDate).format("YYYY-MM-DD")}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
                    let data2 = await fetch(urlAPI2).then(res => res.json())
                    console.log(data2)
                    this.weatherInfor.precipitationList = data2.daily.precipitation_sum;
                    this.weatherInfor.temperatureList = data2.daily.temperature_2m_mean;
                    this.weatherInfor.humitidityList = data2.hourly.relativehumidity_2m;
                    this.weatherInfor.solarRadiation = data2.daily.shortwave_radiation_sum;
                    this.weatherInfor.windSpeed = data2.daily.windspeed_10m_max;

                    this.weatherInfor.Precipitation = 0;
                    this.weatherInfor.totalTemperature = 0;
                    this.weatherInfor.totalHumitidity = 0;
                    this.weatherInfor.totalWindSpeed = 0;
                    this.weatherInfor.totalSolarRadiation = 0;
                    i = 0;
                    this.weatherInfor.precipitationList.forEach(pre => {
                         this.weatherInfor.Precipitation += pre;
                         this.weatherInfor.totalTemperature += this.weatherInfor.temperatureList[i];
                         this.weatherInfor.totalWindSpeed += this.weatherInfor.windSpeed[i];
                         this.weatherInfor.totalSolarRadiation += this.weatherInfor.solarRadiation[i];
                         i++;
                    });
                    this.weatherInfor.humitidityList.forEach(humitidity => {
                         this.weatherInfor.totalHumitidity += humitidity;
                    });

                    this.newactivitiesDetail.ActivityDetails_precipitation = (this.weatherInfor.Precipitation).toFixed(2);
                    this.newactivitiesDetail.ActivityDetails_temperature = (this.weatherInfor.totalTemperature / this.weatherInfor.temperatureList.length).toFixed(2);
                    this.newactivitiesDetail.ActivityDetails_humidity = (this.weatherInfor.totalHumitidity / this.weatherInfor.humitidityList.length).toFixed(2);
                    this.newactivitiesDetail.ActivityDetails_windSpeed = (this.weatherInfor.totalWindSpeed / this.weatherInfor.windSpeed.length).toFixed(2);
                    this.newactivitiesDetail.ActivityDetails_solarRadiation = (this.weatherInfor.totalSolarRadiation / this.weatherInfor.solarRadiation.length).toFixed(2);
               }
               else if (((end.getTime() - start.getTime()) / (24 * 3600 * 1000)) + 1 >= 7 && this.newactivitiesDetail.ActivityDetails_endDate != '' && this.newactivitiesDetail.ActivityDetails_endDate <= date) {
                    let urlAPI = `https://archive-api.open-meteo.com/v1/archive?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&start_date=${moment(this.newactivitiesDetail.ActivityDetails_startDate).format("YYYY-MM-DD")}&end_date=${moment(this.newactivitiesDetail.ActivityDetails_endDate).format("YYYY-MM-DD")}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
                    let data = await fetch(urlAPI).then(res => res.json())
                    this.weatherInfor.precipitationList = data.daily.precipitation_sum;
                    this.weatherInfor.temperatureList = data.daily.temperature_2m_mean;
                    this.weatherInfor.humitidityList = data.hourly.relativehumidity_2m;
                    this.weatherInfor.solarRadiation = data.daily.shortwave_radiation_sum;
                    this.weatherInfor.windSpeed = data.daily.windspeed_10m_max;
                    this.weatherInfor.dateList = data.daily.time;
                    var valueNull = [];
                    for (let index = this.weatherInfor.precipitationList.length - 1; index > 0; index--) {
                         if (this.weatherInfor.precipitationList[index] == null) {
                              const datenull = {};
                              datenull.index = index;
                              datenull.date = this.weatherInfor.dateList[index];
                              valueNull.push(datenull);
                         }
                         else {
                              break;
                         }
                    }

                    let urlAPI2 = `https://api.open-meteo.com/v1/forecast?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&start_date=${moment(this.newactivitiesDetail.ActivityDetails_startDate).format("YYYY-MM-DD")}&end_date=${moment(this.newactivitiesDetail.ActivityDetails_endDate).format("YYYY-MM-DD")}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
                    let data2 = await fetch(urlAPI2).then(res => res.json())
                    i = data2.daily.precipitation_sum.length - 1;
                    valueNull.forEach(valuenull => {
                         this.weatherInfor.precipitationList[valuenull.index] = data2.daily.precipitation_sum[i];
                         this.weatherInfor.temperatureList[valuenull.index] = data2.daily.temperature_2m_mean[i];
                         this.weatherInfor.windSpeed[valuenull.index] = data2.daily.windspeed_10m_max[i];
                         this.weatherInfor.solarRadiation[valuenull.index] = data2.daily.shortwave_radiation_sum[i];
                         i--;
                    });
                    console.log(data2)
                    i = data2.hourly.relativehumidity_2m.length - 1;
                    for (let index = this.weatherInfor.humitidityList.length - 1; index > 0; index--) {
                         if (this.weatherInfor.humitidityList[index] == null) {
                              this.weatherInfor.humitidityList[index] = data2.hourly.relativehumidity_2m[i];
                              i--;
                         }
                         else {
                              break;
                         }
                    }
                    this.weatherInfor.Precipitation = 0;
                    this.weatherInfor.totalTemperature = 0;
                    this.weatherInfor.totalHumitidity = 0;
                    this.weatherInfor.totalWindSpeed = 0;
                    this.weatherInfor.totalSolarRadiation = 0;
                    i = 0;
                    this.weatherInfor.precipitationList.forEach(pre => {
                         this.weatherInfor.Precipitation += pre;
                         this.weatherInfor.totalTemperature += this.weatherInfor.temperatureList[i];
                         this.weatherInfor.totalWindSpeed += this.weatherInfor.windSpeed[i];
                         this.weatherInfor.totalSolarRadiation += this.weatherInfor.solarRadiation[i];
                         i++;
                    });
                    this.weatherInfor.humitidityList.forEach(humitidity => {
                         this.weatherInfor.totalHumitidity += humitidity;
                    });
                    this.newactivitiesDetail.ActivityDetails_precipitation = (this.weatherInfor.Precipitation).toFixed(2);
                    this.newactivitiesDetail.ActivityDetails_temperature = (this.weatherInfor.totalTemperature / this.weatherInfor.temperatureList.length).toFixed(2);
                    this.newactivitiesDetail.ActivityDetails_humidity = (this.weatherInfor.totalHumitidity / this.weatherInfor.humitidityList.length).toFixed(2);
                    this.newactivitiesDetail.ActivityDetails_windSpeed = (this.weatherInfor.totalWindSpeed / this.weatherInfor.windSpeed.length).toFixed(2);
                    this.newactivitiesDetail.ActivityDetails_solarRadiation = (this.weatherInfor.totalSolarRadiation / this.weatherInfor.solarRadiation.length).toFixed(2);
               }
          }
     },
     mounted() {
          this.retrieveOtherActivities();
     }
};
</script>
 
<style>
@import url(../../assets/activitiesDetailStyle.css);
@import url(../../assets/mainStyle.css);

.dp__theme_light {
     --dp-background-color: #F0F2F7;
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

.open{
     /* display: 
      */
      filter: blur(1px);
  -webkit-filter: blur(1px);
}
</style>