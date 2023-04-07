<template>
     <Form @submit="newepidemictimes.close = true, $emit('updateEpidemicTimes-submit', newepidemictimes)"
          :validation-schema="schema" class="form container-fluid updateEpidemicTimesForm">
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
               <div class="col-sm-4 mt-2">
                    <div class="form-group">
                         <label for="ricecropid" class="mt-2">Mã mẫu ruộng <span style="color:red">*</span></label>
                         <Field name="ricecropid" type="name" class="form-control"
                              v-model="ricecropchosen.RiceCropInformation_id" :disabled="true" />
                         <ErrorMessage name="ricecropid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="employeeid" class="mt-3">Nhân viên thực hiện<span style="color:red">*</span></label>
                         <Field name="employeeid" class="form-control" v-model="currentuser.Employee_id" :disabled="true"
                              placeholder="Nhập mã nhân viên...." />
                         <ErrorMessage name="employeeid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="start" class="mt-3">Ngày bắt đầu<span style="color:red">*</span></label>
                         <Field name="start" class="form-control" v-model="newepidemictimes.EpidemicTimes_startDate"
                              placeholder="Ngày bắt đầu">
                              <datepicker :enable-time-picker="false" :value="newepidemictimes.EpidemicTimes_startDate"
                                   :hide-input-icon="true" v-model="newepidemictimes.EpidemicTimes_startDate" @closed="getWeather"
                                   placeholder="DD-MM-YYYY" format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="start" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="developmentid" class="mt-3 pt-1">Giai đoạn phát triển<span
                                   style="color:red">*</span></label>
                         <Field name="developmentid" class="form-control" v-model="newepidemictimes.DevelopmentStage_name">
                              <select class="form-control" v-model="newepidemictimes.DevelopmentStage_name" style="height: 35px;"
                                   name="developmentid" for="developmentid">
                                   <option v-for="(developmentStage, i) in development" :key="i">
                                        {{ developmentStage.DevelopmentStage_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="developmentid" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-4">
                    <div class="form-group ">
                         <label for="fertilizer" class="mt-3">Tên bệnh dịch<span style="color:red">*</span></label>
                         <Field name="fertilizer" v-model="newepidemictimes.Epidemic_name">
                              <select class="form-control" v-model="newepidemictimes.Epidemic_name" name="classtify" style="height: 35px;"
                                   for="classtify">
                                   <option v-for="(epidemic, i) in epidemicList" :key="i">{{ epidemic.Epidemic_name
                                   }}
                                   </option>

                              </select>
                         </Field>
                         <ErrorMessage name="fertilizer" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="times" class="">Lần<span style="color:red">*</span></label>
                         <Field name="times" class="form-control" v-model="newepidemictimes.EpidemicTimes_times"
                              placeholder="Nhập lần thực hiện..." />
                         <ErrorMessage name="times" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="end" class="mt-2 pt-2">Ngày kết thúc</label>
                         <Field name="harvendestDate" class="form-control" v-model="newepidemictimes.EpidemicTimes_endDate"
                              placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newepidemictimes.EpidemicTimes_endDate"
                                   :hide-input-icon="true" v-model="newepidemictimes.EpidemicTimes_endDate" @closed="getWeather"
                                   placeholder="DD-MM-YYYY" format="dd-MM-yyyy" v-bind:on-closed="false" :clearable="false">
                              </datepicker>
                         </Field>
                    </div>

                    <div class="form-group ">
                         <label for="temperature" class="mt-3 pt-1">Nhiệt độ(°C)</label>
                         <Field name="temperature" class="form-control" v-model="newepidemictimes.EpidemicTimes_temperature"
                              placeholder="Nhập nhiệt độ..." />
                         <ErrorMessage name="temperature" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-4">
                    <div class="form-group">
                         <label for="precipitation" class="mt-3 pt-1">Lượng mưa(mm)</label>
                         <Field name="precipitation" class="form-control"
                              v-model="newepidemictimes.EpidemicTimes_precipitation" placeholder="Nhập lượng mưa..." />
                         <ErrorMessage name="precipitation" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="humidity" class="mt-2 pt-2">Độ ẩm(%)</label>
                         <Field name="humidity" class="form-control" v-model="newepidemictimes.EpidemicTimes_humidity"
                              placeholder="Nhập độ ẩm..." />
                         <ErrorMessage name="humidity" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="windspeed" class="mt-1 pt-1">Tốc độ gió(km/h)</label>
                         <Field name="windspeed" class="form-control" v-model="newepidemictimes.EpidemicTimes_windSpeed"
                              placeholder="Nhập tốc độ gió..." />
                         <ErrorMessage name="windspeed" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="solarradiation" class="mt-3 pt-1">Bức xạ mặt trời(MJ/m²)</label>
                         <Field name="solarradiation" class="form-control"
                              v-model="newepidemictimes.EpidemicTimes_solarRadiation"
                              placeholder="Nhập bức xạ mặt trời..." />
                         <ErrorMessage name="solarradiation" class="error-feedback" />
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
                         Cập nhật bị bệnh dịch thành công</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> Cập nhật lần bị
                         bệnh dịch thành công
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
import moment from "moment";

export default {
     name: "updateEpidemicTimesForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["updateEpidemicTimes-submit"],
     props: ["newEpidemicTimes", "message1", "message2", "epidemicList", "developmentStageList", "currentUser", "riceCropChosen"],
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
               windspeed: yup
                    .string()
                    .nullable(),
               solarradiation: yup
                    .string()
                    .nullable(),
          });
          return {
               newepidemictimes: this.newEpidemicTimes,
               ricecropchosen: this.riceCropChosen,
               currentuser: this.currentUser,
               development: this.developmentStageList,
               weatherInfor: [],
               schema,
          };
     },

     methods: {
          async getWeather() {
               this.newepidemictimes.EpidemicTimes_temperature = "";
               this.newepidemictimes.EpidemicTimes_windSpeed = "";
               this.newepidemictimes.EpidemicTimes_precipitation = "";
               this.newepidemictimes.EpidemicTimes_solarRadiation = "";
               this.newepidemictimes.EpidemicTimes_humidity = "";
               let date = new Date();
               if (moment(this.newepidemictimes.EpidemicTimes_startDate).format("YYYY-MM-DD") == moment(date).format("YYYY-MM-DD")) {
                    let urlAPI = `https://api.open-meteo.com/v1/forecast?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&current_weather=true&forecast_days=1&daily=shortwave_radiation_sum&timezone=auto&daily=precipitation_sum&hourly=relativehumidity_2m`;
                    let data = await fetch(urlAPI).then(res => res.json())
                    if (data.error != true) {
                         this.newepidemictimes.EpidemicTimes_temperature = data.current_weather.temperature;
                         this.newepidemictimes.EpidemicTimes_windSpeed = data.current_weather.windspeed;
                         this.newepidemictimes.EpidemicTimes_precipitation = data.daily.precipitation_sum[0];
                         this.newepidemictimes.EpidemicTimes_solarRadiation = data.daily.shortwave_radiation_sum[0];
                         date = moment(date).format("YYYY-MM-DDTHH:00")
                         var i = 0;
                         data.hourly.time.forEach(element => {
                              if (element == date) {
                                   this.newepidemictimes.EpidemicTimes_humidity = data.hourly.relativehumidity_2m[i]
                              }
                              i++;
                         });
                    }
                    else {
                         this.newepidemictimes.EpidemicTimes_temperature = "";
                         this.newepidemictimes.EpidemicTimes_windSpeed = "";
                         this.newepidemictimes.EpidemicTimes_precipitation = "";
                         this.newepidemictimes.EpidemicTimes_solarRadiation = "";
                         this.newepidemictimes.EpidemicTimes_humidity = "";
                    }
               }
               const end = new Date(this.newepidemictimes.EpidemicTimes_endDate);
               const start = new Date(this.newepidemictimes.EpidemicTimes_startDate);
               console.log((end.getTime() - start.getTime()) / (24 * 3600 * 1000))
               if (((end.getTime() - start.getTime()) / (24 * 3600 * 1000)) + 1 <= 7 && this.newepidemictimes.EpidemicTimes_endDate != '') {
                    let urlAPI2 = `https://api.open-meteo.com/v1/forecast?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&start_date=${moment(this.newepidemictimes.EpidemicTimes_startDate).format("YYYY-MM-DD")}&end_date=${moment(this.newepidemictimes.EpidemicTimes_endDate).format("YYYY-MM-DD")}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
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

                    this.newepidemictimes.EpidemicTimes_precipitation = (this.weatherInfor.Precipitation).toFixed(2);
                    this.newepidemictimes.EpidemicTimes_temperature = (this.weatherInfor.totalTemperature / this.weatherInfor.temperatureList.length).toFixed(2);
                    this.newepidemictimes.EpidemicTimes_humidity = (this.weatherInfor.totalHumitidity / this.weatherInfor.humitidityList.length).toFixed(2);
                    this.newepidemictimes.EpidemicTimes_windSpeed = (this.weatherInfor.totalWindSpeed / this.weatherInfor.windSpeed.length).toFixed(2);
                    this.newepidemictimes.EpidemicTimes_solarRadiation = (this.weatherInfor.totalSolarRadiation / this.weatherInfor.solarRadiation.length).toFixed(2);
               }
               else if (((end.getTime() - start.getTime()) / (24 * 3600 * 1000)) + 1 >= 7 && this.newepidemictimes.EpidemicTimes_endDate != '' && this.newepidemictimes.EpidemicTimes_endDate <= date) {
                    let urlAPI = `https://archive-api.open-meteo.com/v1/archive?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&start_date=${moment(this.newepidemictimes.EpidemicTimes_startDate).format("YYYY-MM-DD")}&end_date=${moment(this.newepidemictimes.EpidemicTimes_endDate).format("YYYY-MM-DD")}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
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

                    let urlAPI2 = `https://api.open-meteo.com/v1/forecast?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&start_date=${moment(this.newepidemictimes.EpidemicTimes_startDate).format("YYYY-MM-DD")}&end_date=${moment(this.newepidemictimes.EpidemicTimes_endDate).format("YYYY-MM-DD")}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
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
                    this.newepidemictimes.EpidemicTimes_precipitation = (this.weatherInfor.Precipitation).toFixed(2);
                    this.newepidemictimes.EpidemicTimes_temperature = (this.weatherInfor.totalTemperature / this.weatherInfor.temperatureList.length).toFixed(2);
                    this.newepidemictimes.EpidemicTimes_humidity = (this.weatherInfor.totalHumitidity / this.weatherInfor.humitidityList.length).toFixed(2);
                    this.newepidemictimes.EpidemicTimes_windSpeed = (this.weatherInfor.totalWindSpeed / this.weatherInfor.windSpeed.length).toFixed(2);
                    this.newepidemictimes.EpidemicTimes_solarRadiation = (this.weatherInfor.totalSolarRadiation / this.weatherInfor.solarRadiation.length).toFixed(2);
               }
          }
     }
};
</script>
 
<style>
@import url(../../assets/epidemicTimesStyle.css);

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
}
</style>