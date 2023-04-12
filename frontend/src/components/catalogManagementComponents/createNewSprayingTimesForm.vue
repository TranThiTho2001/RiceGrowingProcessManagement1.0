<template>
     <Form @submit="newsprayingtimes.close = true, $emit('addSprayingTimes-submit', newsprayingtimes)"
          :validation-schema="schema" class="form container-fluid createSprayingTimesForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times"
                         @click="newsprayingtimes.close = false, $emit('addSprayingTimes-submit', newsprayingtimes)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><i class="fas fa-plus-circle"></i>THÊM LẦN PHUN THUỐC MÙA VỤ
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-3">
                    <div class="form-group">
                         <label for="ricecropid" class="mt-1">Mã mẫu ruộng <span style="color:red">*</span></label>
                         <Field name="ricecropid" type="name" class="form-control"
                              v-model="ricecropchosen.RiceCropInformation_id" :disabled="true" />
                         <ErrorMessage name="ricecropid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="employeeid" class="mt-3">Nhân viên thực hiện<span style="color:red">*</span></label>
                         <Field name="employeeid" class="form-control" v-model="currentuser.Employee_id"
                              placeholder="Nhập mã nhân viên...." :disabled="true" />
                         <ErrorMessage name="employeeid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="start" class="mt-3">Ngày bắt đầu</label>
                         <Field name="start" class="form-control" v-model="newsprayingtimes.SprayingTimes_startDate"
                              placeholder="Ngày bắt đầu">
                              <datepicker :enable-time-picker="false" :value="newsprayingtimes.SprayingTimes_startDate"
                                   :hide-input-icon="true" v-model="newsprayingtimes.SprayingTimes_startDate" @closed="getWeather()"
                                   placeholder="DD-MM-YYYY" format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="start" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-3">
                    <div class="form-group ">
                         <label for="times" class="mt-1">Lần<span style="color:red">*</span></label>
                         <Field name="times" class="form-control" v-model="newsprayingtimes.SprayingTimes_times"
                              placeholder="Nhập lần thực hiện..." />
                         <ErrorMessage name="times" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="developmentid" class="mt-3">Giai đoạn phát triển<span style="color:red">*</span></label>
                         <Field name="developmentid" class="form-control" v-model="newsprayingtimes.DevelopmentStage_name">
                              <select class="form-control" v-model="newsprayingtimes.DevelopmentStage_name"
                                   name="developmentid" for="developmentid">
                                   <option v-for="(developmentStage, i) in development" :key="i">
                                        {{ developmentStage.DevelopmentStage_name }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="developmentid" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="end" class="">Ngày kết thúc</label>
                         <Field name="harvendestDate" class="form-control" v-model="newsprayingtimes.SprayingTimes_endDate"
                              placeholder="Ngày sinh">
                              <datepicker :enable-time-picker="false" :value="newsprayingtimes.SprayingTimes_endDate"
                                   :hide-input-icon="true" v-model="newsprayingtimes.SprayingTimes_endDate" @closed="getWeather()"
                                   placeholder="DD-MM-YYYY" format="dd-MM-yyyy" :clearable="false">
                              </datepicker>
                         </Field>
                         <ErrorMessage name="end" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-3">
                    <div class="form-group">
                         <label for="temperature" class="mt-1">Nhiệt độ(°C)</label>
                         <Field name="temperature" class="form-control" v-model="newsprayingtimes.SprayingTimes_temperature"
                              placeholder="Nhập nhiệt độ..." />
                         <ErrorMessage name="temperature" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="humidity" class="mt-3 pt-1">Độ ẩm(%)</label>
                         <Field name="humidity" class="form-control" v-model="newsprayingtimes.SprayingTimes_humidity"
                              placeholder="Nhập độ ẩm..." />
                         <ErrorMessage name="humidity" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="precipitation" class="mt-2 pt-1">Lượng mưa(mm)</label>
                         <Field name="precipitation" class="form-control"
                              v-model="newsprayingtimes.SprayingTimes_precipitation" placeholder="Nhập lượng mưa..." />
                         <ErrorMessage name="precipitation" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-3">
                    <div class="form-group">
                         <label for="windspeed" class="mt-1">Tốc độ gió(km/h)</label>
                         <Field name="windspeed" class="form-control" v-model="newsprayingtimes.SprayingTimes_windSpeed"
                              placeholder="Nhập tốc độ gió..." />
                         <ErrorMessage name="windspeed" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="solarradiation" class="mt-3 pt-1">Bức xạ mặt trời(MJ/m²)</label>
                         <Field name="solarradiation" class="form-control" v-model="newsprayingtimes.SprayingTimes_solarRadiation"
                              placeholder="Nhập bức xạ mặt trời..." />
                         <ErrorMessage name="solarradiation" class="error-feedback" />
                    </div>
               </div>
          </div>
          <div class="row mt-2 ml-1 mr-1 pesticideUsed">
               <button type="button" @click="addPesticide()" class="btnAddPesticide row mt-2"> Thêm </button>
               <div class="pesticidelist ml-2">
                    <table class="table thead-dark table-striped" style="min-height: max-content;">
                         <thead>

                              <tr>
                                   <th class="text-center">STT</th>
                                   <th>Tên thuốc</th>
                                   <th>Liều lượng (ml/ha)</th>
                              </tr>
                         </thead>
                         <tbody>
                              <tr v-for="(Pesticide, i) in newsprayingtimes.Pesticide" :key="i">
                                   <td class="text-center">{{ i + 1 }}</td>
                                   <td>
                                        <select class="selectionPesticide" name="classtify"
                                             v-model="Pesticide.Pesticide_name" for="classtify">
                                             <option v-for="(pesticide, i) in pesticideList" :key="i"
                                                  :value="pesticide.Pesticide_name">{{
                                                       pesticide.Pesticide_name
                                                  }}
                                             </option>

                                        </select>
                                   </td>
                                   <td>
                                        <div class="">
                                             <input class="inputAmount" type="text" v-model="Pesticide.Pesticide_amount">
                                        </div>
                                   </td>
                              </tr>

                         </tbody>
                    </table>
               </div>
          </div>
          <div class="row ">
               <div class="col-sm-12 mt-2 mb-2 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         Thêm lần phun thuốc thành công</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> Thêm lần phum thuốc không thành công
                    </span>
               </div>
          </div>
          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu ">Lưu</button>
               </div>
          </div>

     </form>
</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import moment
     from "moment";
export default {
     name: "createSprayingTimesForm",
     components: {
          Form,
          Field,
          ErrorMessage,
          Datepicker,
     },
     emits: ["addSprayingTimes-submit"],
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
               start: yup
                    .string(),
               end: yup
                    .string(),
               temperature: yup
                    .string(),
               humidity: yup
                    .string(),
               precipitation: yup
                    .string(),
               windspeed: yup
                    .string()
                    .nullable(),
               solarradiation: yup
                    .string()
                    .nullable(),
          });
          return {
               newsprayingtimes: this.newSprayingTimes,
               currentuser: this.currentUser,
               development: this.developmentStageList,
               ricecropchosen: this.riceCropChosen,
               weatherInfor: [],
               schema,
          };
     },

     methods: {
          async addPesticide() {
               var temp = {};
               temp.Pesticide_name = "";
               temp.Pesticide_amount = 0;
               this.newsprayingtimes.Pesticide.push(temp);
          },

          async getWeather() {
               this.newsprayingtimes.SprayingTimes_temperature = "";
               this.newsprayingtimes.SprayingTimes_windSpeed = "";
               this.newsprayingtimes.SprayingTimes_precipitation = "";
               this.newsprayingtimes.SprayingTimes_solarRadiation = "";
               this.newsprayingtimes.SprayingTimes_humidity = "";
               let date = new Date();
               if (moment(this.newsprayingtimes.SprayingTimes_startDate).format("YYYY-MM-DD") == moment(date).format("YYYY-MM-DD")) {
                    let urlAPI = `https://api.open-meteo.com/v1/forecast?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&current_weather=true&forecast_days=1&daily=shortwave_radiation_sum&timezone=auto&daily=precipitation_sum&hourly=relativehumidity_2m`;
                    let data = await fetch(urlAPI).then(res => res.json())
                    if (data.error != true) {
                         this.newsprayingtimes.SprayingTimes_temperature = data.current_weather.temperature;
                         this.newsprayingtimes.SprayingTimes_windSpeed = data.current_weather.windspeed;
                         this.newsprayingtimes.SprayingTimes_precipitation = data.daily.precipitation_sum[0];
                         this.newsprayingtimes.SprayingTimes_solarRadiation = data.daily.shortwave_radiation_sum[0];
                         date = moment(date).format("YYYY-MM-DDTHH:00")
                         var i = 0;
                         data.hourly.time.forEach(element => {
                              if (element == date) {
                                   this.newsprayingtimes.SprayingTimes_humidity = data.hourly.relativehumidity_2m[i]
                              }
                              i++;
                         });
                    }
                    else {
                         this.newsprayingtimes.SprayingTimes_temperature = "";
                         this.newsprayingtimes.SprayingTimes_windSpeed = "";
                         this.newsprayingtimes.SprayingTimes_precipitation = "";
                         this.newsprayingtimes.SprayingTimes_solarRadiation = "";
                         this.newsprayingtimes.SprayingTimes_humidity = "";
                    }
               }
               const end = new Date(this.newsprayingtimes.SprayingTimes_endDate);
               const start = new Date(this.newsprayingtimes.SprayingTimes_startDate);
               console.log((end.getTime() - start.getTime()) / (24 * 3600 * 1000))
               if (((end.getTime() - start.getTime()) / (24 * 3600 * 1000)) + 1 <= 7 && this.newsprayingtimes.SprayingTimes_endDate != '') {
                    let urlAPI2 = `https://api.open-meteo.com/v1/forecast?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&start_date=${moment(this.newsprayingtimes.SprayingTimes_startDate).format("YYYY-MM-DD")}&end_date=${moment(this.newsprayingtimes.SprayingTimes_endDate).format("YYYY-MM-DD")}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
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

                    this.newsprayingtimes.SprayingTimes_precipitation = (this.weatherInfor.Precipitation).toFixed(2);
                    this.newsprayingtimes.SprayingTimes_temperature = (this.weatherInfor.totalTemperature / this.weatherInfor.temperatureList.length).toFixed(2);
                    this.newsprayingtimes.SprayingTimes_humidity = (this.weatherInfor.totalHumitidity / this.weatherInfor.humitidityList.length).toFixed(2);
                    this.newsprayingtimes.SprayingTimes_windSpeed = (this.weatherInfor.totalWindSpeed / this.weatherInfor.windSpeed.length).toFixed(2);
                    this.newsprayingtimes.SprayingTimes_solarRadiation = (this.weatherInfor.totalSolarRadiation / this.weatherInfor.solarRadiation.length).toFixed(2);
               }
               else if (((end.getTime() - start.getTime()) / (24 * 3600 * 1000)) + 1 >= 7 && this.newsprayingtimes.SprayingTimes_endDate != '' && this.newsprayingtimes.SprayingTimes_endDate <= date) {
                    let urlAPI = `https://archive-api.open-meteo.com/v1/archive?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&start_date=${moment(this.newsprayingtimes.SprayingTimes_startDate).format("YYYY-MM-DD")}&end_date=${moment(this.newsprayingtimes.SprayingTimes_endDate).format("YYYY-MM-DD")}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
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

                    let urlAPI2 = `https://api.open-meteo.com/v1/forecast?latitude=${this.riceCropChosen.ArableLand_latitude}&longitude=${this.riceCropChosen.ArableLand_longitude}&start_date=${moment(this.newsprayingtimes.SprayingTimes_startDate).format("YYYY-MM-DD")}&end_date=${moment(this.newsprayingtimes.SprayingTimes_endDate).format("YYYY-MM-DD")}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
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

                    this.newsprayingtimes.SprayingTimes_precipitation = (this.weatherInfor.Precipitation).toFixed(2);
                    this.newsprayingtimes.SprayingTimes_temperature = (this.weatherInfor.totalTemperature / this.weatherInfor.temperatureList.length).toFixed(2);
                    this.newsprayingtimes.SprayingTimes_humidity = (this.weatherInfor.totalHumitidity / this.weatherInfor.humitidityList.length).toFixed(2);
                    this.newsprayingtimes.SprayingTimes_windSpeed = (this.weatherInfor.totalWindSpeed / this.weatherInfor.windSpeed.length).toFixed(2);
                    this.newsprayingtimes.SprayingTimes_solarRadiation = (this.weatherInfor.totalSolarRadiation / this.weatherInfor.solarRadiation.length).toFixed(2);
                    console.log("Tong luong Mua: " + this.weatherInfor.Precipitation + " Nhiet do trung binh: " + this.weatherInfor.Temperature + " Do am: " + this.weatherInfor.Humitidity + " Tocs do gia: " + this.weatherInfor.WinSpeed + " Buc xa: " + this.weatherInfor.SolarRadiation);
               }

          }
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
}
</style>