<template>
     <div class="container-fluid riceCropDetail" style="background-color:#EAEAEA;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row riceCropDetailFrame" style="height: max-content;" v-if="!loading">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>
               <div class="right rightRiceCropDetail" data-bs-spy="scroll">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Theo dõi mùa vụ</h3>
                         </div>
                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="container-fluid riceCropDetailComponent"
                         style="margin-top: 140px; margin-left:20px; width: 97%; margin-right:10px">

                         <div class="row">
                              <h4 style="padding-bottom: 10px; width: 100%;">Thông tin {{ riceCrop.RiceCropInformation_name
                              }}</h4>
                              <button class="btn btnPredict" @click="predictRiceYield()">
                                   Dự Đoán</button>
                              <table class="tablericeCropInfor tablePredict">
                                   <tbody>
                                        <tr>
                                             <td data-label="Mã mùa vụ">{{
                                                  riceCrop.RiceCropInformation_id }}</td>
                                        </tr>
                                        <tr>
                                             <td data-label="Tên mùa vụ">{{ riceCrop.RiceCropInformation_name }}</td>
                                        </tr>
                                        <tr>
                                             <td data-label="Vụ mùa">Vụ mùa - {{ riceCrop.Crop_name }}</td>
                                        </tr>
                                        <tr>
                                             <td data-label="Giống lúa">Sử dụng giống lúa {{ riceCrop.Seed_name }}
                                             </td>
                                        </tr>
                                        <tr>
                                             <td data-label="Mẫu ruộng" @click="goToMap">Vị trí mẫu ruộng: {{
                                                  riceCrop.ArableLand_latitude }}, {{ riceCrop.ArableLand_longitude }}</td>
                                        </tr>
                                        <tr>
                                             <td data-label="Ngày gieo xạ">{{
                                                  formatDate(riceCrop.RiceCropInformation_sowingDate) }}</td>
                                        </tr>
                                        <tr>
                                             <td data-label="Ngày thuc hoạch">{{
                                                  formatDate(riceCrop.RiceCropInformation_harvestDate) }}</td>
                                        </tr>
                                   </tbody>
                              </table>
                              <div class="calendarComponent">
                                        <time  class="icon">
                                             <em>Ngày</em>
                                             <strong>Gieo trồng</strong>
                                             <span>{{ get_day_of_time(riceCrop.RiceCropInformation_sowingDate) }}</span>
                                        </time>
                              </div>
                              <div class="resultRiceYield">
                                   <div class="result-prediction">
                                        <p>Dự đoán</p>
                                        <h4>400kg/ha</h4>
                                   </div>
                                   <div class="result-readly">
                                        <p>Thực tế</p>
                                        <h4>400kg/ha</h4>
                                   </div>
                              </div>
                         </div>

                         <div class="row mt-4">
                              <h4 style="padding-bottom: 10px;">Thông tin thời tiết trong mùa vụ</h4>
                              <button class="btn btnDowload" @click="dowload()">Tải file CSV <i
                                        class="fas fa-arrow-alt-circle-down"></i></button>
                              <table class="tablePredict" id="weatherInfor" v-if="weatherInfor.loadding">
                                   <thead>
                                        <tr>
                                             <th class="centerclass">STT</th>
                                             <th class="centerclass">Ngày</th>
                                             <th class="centerclass">Nhiệt Độ(°C )</th>
                                             <th class="centerclass">Độ ẩm(%)</th>
                                             <th class="centerclass">Lương mưa(mm/h)</th>
                                             <th class="centerclass">Tốc độ gió(Km/h)</th>
                                             <th class="centerclass">Bức xạ mặt trời(MJ/m²)</th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(data, i) in weatherInfor.dateList" :key="i">
                                             <td class="centerclass">{{ i }}</td>
                                             <td class="centerclass">{{ data }}</td>
                                             <td class="centerclass">{{ weatherInfor.temperatureList[i] }}</td>
                                             <td class="centerclass">{{ weatherInfor.humitidityList.final[i] }}</td>
                                             <td class="centerclass">{{ weatherInfor.precipitationList[i] }}</td>
                                             <td class="centerclass">{{ weatherInfor.windSpeed[i] }}</td>
                                             <td class="centerclass">{{ weatherInfor.solarRadiation[i] }}</td>
                                        </tr>
                                        <tr>
                                             <td class="centerclass final-row">Dữ liệu dùng cho dự đoán</td>
                                             <td class="centerclass final-row">{{ weatherInfor.dateList.length }}</td>
                                             <td class="centerclass final-row">{{ weatherInfor.Temperature }}</td>
                                             <td class="centerclass final-row">{{ weatherInfor.Humitidity }}</td>
                                             <td class="centerclass final-row">{{ weatherInfor.Precipitation }}</td>
                                             <td class="centerclass final-row">{{ weatherInfor.WinSpeed }}</td>
                                             <td class="centerclass final-row">{{ weatherInfor.SolarRadiation }}</td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>
                         <div class="row mt-4">
                              <h4>Hoạt động bón phân</h4>
                              <table class="tablePredict">
                                   <thead>
                                        <tr>
                                             <th class="text-center th_pre">Lần</th>
                                             <th class="th_pre">Tên phân bón</th>
                                             <th class="text-center th_pre">Số lượng (kg/ha)</th>
                                             <th class="text-center th_pre">Ngày bất đầu</th>
                                             <th class="text-center th_pre">Ngày kết thúc</th>
                                             <th class="th_pre">Nhân viên</th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-if="fertilizerTimesList.length < 1">
                                             <td colspan="6" class="centerclass">Chưa có lần bón phân nào được thực hiện</td>
                                        </tr>
                                        <tr v-for="(fertilizer, i) in (fertilizerTimesList)" :key="i">
                                             <td class="text-center ">{{ fertilizer.FertilizerTimes_times }}</td>
                                             <td class="">{{ fertilizer.Fertilizer_name }}</td>
                                             <td class="text-center ">{{ fertilizer.FertilizerTimes_amount }}</td>
                                             <td class="text-center ">{{
                                                  formatDate(fertilizer.FertilizerTimes_startDate) }}</td>
                                             <td class="text-center ">{{
                                                  formatDate(fertilizer.FertilizerTimes_endDate)
                                             }}</td>
                                             <td class="">{{ fertilizer.Employee_name }}</td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>

                         <div class="row mt-4">
                              <h4>Các lần bị bệnh dịch</h4>
                              <table class="tablePredict">
                                   <thead>
                                        <tr>
                                             <th class="text-center th_pre">Lần</th>
                                             <th class="th_pre">Tên bệnh dịch</th>
                                             <th class="text-center th_pre">Ngày bất đầu</th>
                                             <th class="text-center th_pre">Ngày kết thúc</th>
                                             <th class="th_pre">Nhân viên</th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-if="epidemicTimesList.length < 1">
                                             <td colspan="5" class="centerclass">Mùa vụ không trải qua lần bị bệnh dịch nào.
                                             </td>
                                        </tr>
                                        <tr v-for="(epidemic, i ) in (epidemicTimesList)" :key="i">
                                             <td class="text-center ">{{ epidemic.EpidemicTimes_times }}</td>
                                             <td class="">{{ epidemic.Epidemic_name }}</td>
                                             <td class="text-center ">{{
                                                  formatDate(epidemic.EpidemicTimes_startDate)
                                             }}</td>
                                             <td class="text-center ">{{ formatDate(epidemic.EpidemicTimes_endDate)
                                             }}
                                             </td>
                                             <td class="">{{ epidemic.Employee_name }}</td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>

                         <div class="row mt-4">
                              <h4>Hoạt động phun thuốc</h4>
                              <table class="tablePredict">
                                   <thead>
                                        <tr>
                                             <th class="text-center th_pre">Mã</th>
                                             <th class="th_pre">Tên thuốc</th>
                                             <th class="text-center th_pre">Liều lượng (lít/ha)</th>
                                             <th class="text-center th_pre">Ngày bất đầu</th>
                                             <th class="text-center th_pre">Ngày kết thúc</th>
                                             <th class="th_pre">Nhân viên</th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-if="sprayingTimesList.length < 1">
                                             <td colspan="6" class="centerclass">Chưa có làn phun thuốc nào được thực hiện
                                                  trên ruộng lúa</td>
                                        </tr>
                                        <tr v-for="(sprayingTimes, i ) in (sprayingTimesList)" :key="i">
                                             <td class="text-center ">{{ sprayingTimes.SprayingTimes_times }}</td>
                                             <td class="">{{ sprayingTimes.Pesticide_name }}</td>
                                             <td class="text-center ">{{ sprayingTimes.SprayingTimes_amount }}</td>
                                             <td class="text-center ">{{
                                                  formatDate(sprayingTimes.SprayingTimes_startDate)
                                             }}</td>
                                             <td class="text-center ">{{
                                                  formatDate(sprayingTimes.SprayingTimes_endDate)
                                             }}
                                             </td>
                                             <td class="">{{ sprayingTimes.Employee_name }}</td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>

                         <div class="row mt-4">
                              <h4>Các hoạt động khác</h4>
                              <table class="tablePredict">
                                   <thead>
                                        <tr>
                                             <th class="centerclass th_pre">STT</th>
                                             <th class="centerclass th_pre">Mã</th>
                                             <th class="th_pre">Tên hoạt động</th>
                                             <th class="th_pre">Lần</th>
                                             <th class="th_pre">Ngày bắt đầu</th>
                                             <th class="th_pre">Ngày kết thúc</th>
                                             <th class="th_pre">Nhân viên</th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-if="activitiesDetailList.length < 1">
                                             <td colspan="7" class="centerclass">Chưa có hoạt động nào được thực hiện cho mùa
                                                  vụ </td>
                                        </tr>
                                        <tr v-for="(activity, i ) in (activitiesDetailList)" :key="i">
                                             <td class="text-center">{{ i }}</td>
                                             <td class="text-center">{{ activity.OtherActivities_id }}</td>
                                             <td>{{ activity.OtherActivities_name }}</td>
                                             <td>{{ activity.ActivityDetails_times }}</td>
                                             <td>{{ formatDate(activity.ActivityDetails_startDate) }}</td>
                                             <td>{{ formatDate(activity.ActivityDetails_endDate) }}</td>
                                             <td class="">{{ activity.Employee_name }}</td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>
                    </div>
               </div>
          </div>
     </div>
</template>

<script>
import { mapGetters, mapMutations } from "vuex";
import FertilizerTimesService from '@/services/fertilizerTimes.service';
import RiceCropInformationService from '@/services/riceCropInformation.service';
import EpidemicTimesService from '@/services/epidemicTimes.service';
import SprayingTimesService from '@/services/sprayingTimes.service';
import ActivityDetailsService from '@/services/activityDetails.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import PredictionService from "@/services/prediction.service";

import moment from 'moment';
export default {
     name: "riceCropDetail",
     components: {
          Catalog,
          TopHeader,
          Preloader,
     },

     data() {
          return {
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: false,
                    isCloseMenu: false,
               },

               loading: true,
               riceCrop: {},
               fertilizerTimesList: [],
               epidemicTimesList: [],
               sprayingTimesList: [],
               activitiesDetailList: [],
               weatherInfor: [],
          }
     },
     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },
     created() {
          this.riceCrop.RiceCropInformation_id = this.$route.params.id;
          this.weatherInfor.loadding = false;
          this.initEmployeeState();
          this.retrieveRiceCrop();
     },
     methods: {
          ...mapMutations([
               "initEmployeeState"
          ]),

          async retrieveFertilizerTimesList() {
               console.log(this.riceCrop.RiceCropInformation_id)
               const [err, respone] = await this.handle(
                    FertilizerTimesService.get(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần bón phân.") {
                         this.fertilizerTimesList = respone.data;
                    }
               }
               this.retrieveEpidemicTimesList();
          },

          async retrieveRiceCrop() {
               this.loading = true;
               const [err, respone] = await this.handle(
                    RiceCropInformationService.get(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCrop = respone.data;
               }
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
               console.log(this.riceCrop)
               this.retrieveFertilizerTimesList();
               this.getWeather()
          },

          async retrieveEpidemicTimesList() {
               const [err, respone] = await this.handle(
                    EpidemicTimesService.get(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    console.log(respone.data)
                    if (respone.data != "Không tìm thấy lần bị dịch bệnh.") {
                         this.epidemicTimesList = respone.data;
                    }
               }
               this.retrieveSprayingTimesList();
          },

          async retrieveSprayingTimesList() {
               const [err, respone] = await this.handle(
                    SprayingTimesService.get(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần phun thuốc mới.") {
                         this.sprayingTimesList = respone.data;
                    }

               }
               this.retrieveActivitiesDetailList();
          },

          async retrieveActivitiesDetailList() {
               const [err, respone] = await this.handle(
                    ActivityDetailsService.findByName(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.activitiesDetailList = respone.data;
               }
          },

          async predictRiceYield() {
               if (this.weatherInfor.loadding) {
                    var infor = {};
                    infor.precipitation = this.weatherInfor.Precipitation;
                    infor.temperature = this.weatherInfor.Temperature;
                    infor.humitidity = this.weatherInfor.Humitidity;
                    infor.solarRadiation = this.weatherInfor.SolarRadiation;
                    infor.windSpeed = this.weatherInfor.WinSpeed;
                    if (this.riceCropChosen.Crop_id == 'C00001') {
                         infor.crop = '1';
                    }
                    else if (this.riceCropChosen.Crop_id == 'C00002') {
                         infor.crop = '2';
                    }
                    else {
                         infor.crop = '3';
                    }
                    infor.area = this.riceCropChosen.Province_id;
                    const [err, respone] = await this.handle(
                         PredictionService.create(this.riceCropChosen.RiceCropInformation_id, infor)
                    );
                    if (err) {
                         console.log(err)
                    }
                    else {
                         this.riceCropChosen.Prediction_yield = respone.data.Prediction_yield;
                         this.riceCropChosen.Prediction_yield = Number(this.riceCropChosen.Prediction_yield).toFixed(2);
                         this.predicting = false;
                         this.result = true;
                    }
               }
          },

          async getWeather() {
               this.predicting = true;
               this.result = false;
               this.weatherInfor.loadding = false;
               var lat = this.riceCrop.ArableLand_latitude;
               var lon = this.riceCrop.ArableLand_longitude;
               const start_date = moment(this.riceCrop.RiceCropInformation_sowingDate).format("YYYY-MM-DD");
               const end_date = moment(new Date()).format("YYYY-MM-DD");

               let urlAPI1 = `https://archive-api.open-meteo.com/v1/archive?latitude=${lat}&longitude=${lon}&start_date=${start_date}&end_date=${end_date}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
               let data = await fetch(urlAPI1).then(res => res.json())

               this.weatherInfor.precipitationList = data.daily.precipitation_sum;
               this.weatherInfor.temperatureList = data.daily.temperature_2m_mean;
               this.weatherInfor.humitidityList = data.hourly;
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

               for (let index = this.weatherInfor.humitidityList.relativehumidity_2m.length - 1; index > 0; index--) {
                    var date = moment(new Date(this.weatherInfor.humitidityList.time[index])).format("YYYY-MM-DD")
                    if (date >= valueNull[valueNull.length - 1].date) {
                         this.weatherInfor.humitidityList.relativehumidity_2m.pop();
                         this.weatherInfor.humitidityList.time.pop();
                    }
                    else {
                         break;
                    }
               }
               let urlAPI2 = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&start_date=${valueNull[valueNull.length - 1].date}&end_date=${valueNull[0].date}&timezone=GMT&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
               let data2 = await fetch(urlAPI2).then(res => res.json())
               var i = data2.daily.precipitation_sum.length - 1;
               valueNull.forEach(valuenull => {
                    this.weatherInfor.precipitationList[valuenull.index] = data2.daily.precipitation_sum[i];
                    this.weatherInfor.temperatureList[valuenull.index] = data2.daily.temperature_2m_mean[i];
                    this.weatherInfor.windSpeed[valuenull.index] = data2.daily.windspeed_10m_max[i];
                    this.weatherInfor.solarRadiation[valuenull.index] = data2.daily.shortwave_radiation_sum[i];
                    i--;
               });

               this.weatherInfor.humitidityList.time = this.weatherInfor.humitidityList.time.concat(data2.hourly.time);
               this.weatherInfor.humitidityList.relativehumidity_2m = this.weatherInfor.humitidityList.relativehumidity_2m.concat(data2.hourly.relativehumidity_2m);

               this.weatherInfor.humitidityList.final = [];
               for (let index = 0; index < this.weatherInfor.dateList.length; index++) {
                    let total = 0;
                    for (let i = index * 24; i < (index + 1) * 24; i++) {
                         total = total + this.weatherInfor.humitidityList.relativehumidity_2m[i];
                    }
                    this.weatherInfor.humitidityList.final.push((total / 24).toFixed(2));
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
                    this.weatherInfor.totalHumitidity += Number(this.weatherInfor.humitidityList.final[i]);
                    i++;
               });

               this.weatherInfor.Temperature = (this.weatherInfor.totalTemperature / this.weatherInfor.temperatureList.length).toFixed(2);
               this.weatherInfor.Humitidity = (this.weatherInfor.totalHumitidity / this.weatherInfor.dateList.length).toFixed(2);
               this.weatherInfor.WinSpeed = (this.weatherInfor.totalWindSpeed / this.weatherInfor.windSpeed.length).toFixed(2);
               this.weatherInfor.SolarRadiation = (this.weatherInfor.totalSolarRadiation / this.weatherInfor.solarRadiation.length).toFixed(2);
               this.weatherInfor.Precipitation = (this.weatherInfor.Precipitation).toFixed(2);
               this.weatherInfor.loadding = true;
          },

          async download_csv(csv, filename) {
               var csvFile;
               var downloadLink;

               // CSV FILE
               csvFile = new Blob(["\uFEFF" + csv], { type: "text/csv" });

               // Download link
               downloadLink = document.createElement("a");

               // File name
               downloadLink.download = filename;

               // We have to create a link to the file
               downloadLink.href = window.URL.createObjectURL(csvFile);

               // Make sure that the link is not displayed
               downloadLink.style.display = "none";

               // Add the link to your DOM
               document.body.appendChild(downloadLink);

               // Lanzamos
               downloadLink.click();
          },

          async export_table_to_csv(html, filename) {
               var csv = [];
               var rows = html.querySelectorAll("table tr");

               for (var i = 0; i < rows.length; i++) {
                    var row = [], cols = rows[i].querySelectorAll("td, th");

                    for (var j = 0; j < cols.length; j++)
                         row.push(String(cols[j].innerText).replaceAll(',', ''));

                    csv.push(row.join(","));

               }
               console.log(row)
               // Download CSV
               this.download_csv(csv.join("\n"), filename);
          },

          async dowload() {
               var html = document.getElementById("weatherInfor");
               console.log(html)
               this.export_table_to_csv(html, "table.csv");
          },

          get_day_of_time(d1) {
               let ms1 = (new Date(d1)).getTime();
               var d2 = new Date();
               let ms2 = d2.getTime();
               return Math.ceil((ms2 - ms1) / (24 * 60 * 60 * 1000));
          },

          goToMap() {
               window.open(`https://www.google.com/maps/@${this.riceCrop.ArableLand_latitude},${this.riceCrop.ArableLand_longitude},15z?hl=vi-VN`);
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY"));
          },

     },

     mounted() {
          // this.retrieveRiceCrop()
          // this.getWeather()
     }

};

</script>

<style>
@import url(../../assets/mainStyle.css);
@import url(../../assets/predictionStyle.css);</style>