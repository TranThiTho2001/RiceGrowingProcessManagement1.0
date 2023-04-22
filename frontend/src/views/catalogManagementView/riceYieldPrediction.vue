<template>
     <div class="container-fluid predictiveManagement pr-4"
          style="background-color: #EAEAEA;height:max-content; min-height: 100vh;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row predictiveManagementFrame" style="height: max-content;" v-if="!loading">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>
               <div class="right rightPredictiveManagement " :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Dự Đoán Năng Suất</h3>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row row-inputSearch">
                         <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                              @click="retrievePredictionList, isOpenInput1 = true"
                              @keyup.enter="searchRiceCrop(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchRiceCrop(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>

                         <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="ricecrop in filteredList()" :key="ricecrop.RiceCropInformation_name"
                                   @click="searchRiceCrop(ricecrop.RiceCropInformation_name), away()">
                                   {{ ricecrop.RiceCropInformation_name }}</p>
                         </div>
                         <label class="labelYear">Năm</label>
                         <select class="selectYear" v-model="filter.year" @change="searchByYear()">
                              <option class="optionYear" v-for="year in getYear()" :key="year">{{ year }}</option>
                         </select>
                         <button class="btn btnPredict1" @click="goToRiceYieldPredictionDetail()">Lịch Sử
                              Dự Đoán</button>
                    </div>

                    <div class=" row ricecropList-row" style="margin-left:-5px;margin-right: 10px ; margin-top:20px">
                         <div class="ricecrop-Component" v-for="(ricecrop, i) in clonePredictionList" :key="i">
                              <div class="btnMoreInfor">
                                   <button type="button" class="btn-sm btnmore" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>

                                        <div class=" select dropdown-menu">
                                             <option class="dropdown-item action"
                                                  @click="setRiceCropChosen(ricecrop), goToRiceCropData()">
                                                  <span class="fas fa-lightbulb" style="font-size: 20px;"></span> Dự
                                                  Đoán
                                             </option>
                                             <option class="dropdown-item" href="#"
                                                  @click="setRiceCropChosen(ricecrop), goToRiceCropDetail()">
                                                  <span class="fas fa-eye"></span>Xem Mùa Vụ
                                             </option>
                                             <option class="dropdown-item" href="#"
                                                  @click="setRiceCropChosen(ricecrop), goToRiceCropData()">
                                                  <span class="fas fa-eye"></span>Dữ liệu Dự Đoán
                                             </option>
                                        </div>
                                   </button>
                              </div>
                              <h5 class="riceCropName">{{ ricecrop.RiceCropInformation_name }}</h5>
                              <p class="riceCropId">{{ ricecrop.RiceCropInformation_id }}</p>
                              <p class="riceCropId">{{ get_day_of_time(ricecrop.RiceCropInformation_sowingDate) }} Ngày</p>
                              <p class="textPredict">Dự đoán </p><button class="resultPrediction">{{
                                   ricecrop.Prediction_yield
                              }}</button>
                              <p class="textKg">kg/ha</p>
                         </div>
                    </div>

                    <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->

                    <div class="confirmationDialog" v-if="isOpenConfirm">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteOtherActivity(activityChoosen)">Xóa</button>
                         <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                              @click="isOpenConfirm = !isOpenConfirm">Hủy</button>
                    </div>

                    <div class="messageDialog" v-if="isOpenMessage">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelThongBao">
                              <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{
                                   message
                              }}
                         </p>
                         <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                              @click="isOpenMessage = !isOpenMessage">OK</button>
                    </div>

                    <div class="waitingDialog" v-if="predicting">
                         <div>
                              <p class="labelConfirm mt-4 pt-4">Đang xử lý....</p>
                         </div>
                         <span v-show="predicting" class="spinner-border spinner-border-sm"></span>
                    </div>
                    <div class="resultDialog" v-if="result">
                         <p style="color:#515151; text-align:center; margin-top: 30px; font-size: 20px;"
                              class="labelConfirm"> Năng suất dự đoán cho mùa vụ {{
                                   this.riceCropChosen.RiceCropInformation_name }}<br> <span class="result">{{
          this.riceCropChosen.Prediction_yield }}</span>
                              kg/ha
                         </p>
                         <button class="btnOK btn btn-sm btn-outline-secondary mb-3" @click="result = !result">OK</button>
                    </div>
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>

import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import ImagesService from '@/services/images.service';
import PredictionService from '../../services/prediction.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';

import RiceCropInformationService from '../../services/riceCropInformation.service';

export default {
     name: "predictiveManagement",
     components: {
          Catalog,
          TopHeader,
          Preloader,
     },

     data() {
          return {
               message: "",
               loading: true,
               loaded: false,
               result: false,
               message1: " ",
               message2: " ",
               nameToSearch: "",
               riceCropList: [],
               weatherInfor: [],
               predicting: false,
               predictionList: [],
               riceCropChosen: {},
               isOpenInput2: false,
               isOpenInput1: false,
               predictionChosen: {},
               isOpenMessage: false,
               isOpenConfirm: false,
               cloneRiceCropList: [],
               clonePredictionList: [],
               isOpenRiceCropList: false,
               isOpenRiceCropDetail: false,
               predictionListByRiceCrop: [],
               isOpenPredictionHistory: false,
               years: [],
               filter: {},
               isOpenSearch: {
                    open: false,
                    close: true,
               },

               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: false,
                    isCloseMenu: false,
               },

               active: {
                    rightActive: false,
                    leftnNoneActive: false,
               },
          }
     },

     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },
     methods: {
          ...mapMutations([
               "initEmployeeState"
          ]),

          filteredList() {
               return this.riceCropList.filter(ricecrop => {
                    return ricecrop.RiceCropInformation_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })

          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          async retrievePredictionList() {
               this.loaded = false;
               const [err, respone] = await this.handle(
                    PredictionService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {

                    this.predictionList = respone.data;
               }
               this.retrieveRiceCropList();
               this.loaded = true;
          },


          async getURLForResult(position) {
               const [err, response] = await this.handle(
                    ImagesService.findByName(this.predictionList[position].RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    const temp = response.data;
                    if (temp.length > 0) {
                         this.predictionList[position].Images_link = require('@/images/' + temp[temp.length - 1].Image_link);
                    }
                    else {
                         this.predictionList[position].Images_link = require('@/images/' + "Rice14.jpg");
                    }
               }
          },

          async getURLForRiceCrop(position) {
               const [err, response] = await this.handle(
                    ImagesService.findByName(this.riceCropList[position].RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    const temp = response.data;
                    if (temp.length > 0) {
                         this.riceCropList[position].Images_link = require('@/images/' + temp[temp.length - 1].Image_link);
                    }
                    else {
                         this.riceCropList[position].Images_link = require('@/images/' + "Rice14.jpg");
                    }
               }
          },

          async retrieveRiceCropList() {
               this.loading = true;
               const [err, respone] = await this.handle(
                    RiceCropInformationService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    respone.data.forEach(ricecrop => {
                         if (ricecrop.RiceCropInformation_sowingDate != null ) {
                              if (this.get_day_of_time(ricecrop.RiceCropInformation_sowingDate) >= 60) {
                                   this.riceCropList.push(ricecrop);
                                   this.clonePredictionList.push(ricecrop);
                                   ricecrop.Prediction_yield = 0;
                                   ricecrop.Prediction_date = "";
                                   this.predictionList.forEach(result => {
                                        if (result.RiceCropInformation_id == ricecrop.RiceCropInformation_id) {
                                             if (ricecrop.Prediction_yield == 0) {
                                                  ricecrop.Prediction_yield = result.Prediction_yield;
                                                  ricecrop.Prediction_date = result.Prediction_date;
                                             }
                                             else {
                                                  if (ricecrop.Prediction_date < result.Prediction_date) {
                                                       ricecrop.Prediction_yield = result.Prediction_yield;
                                                       ricecrop.Prediction_date = result.Prediction_date;
                                                  }
                                             }
                                        }
                                   });
                              }
                         }
                    });

                    for (let index = 0; index < this.riceCropList.length; index++) {
                         this.getURLForRiceCrop(index);
                    }
                    this.cloneRiceCropList = this.riceCropList;
               }
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
          },

          async setRiceCropChosen(data, id) {
               if (id == "1") {
                    const [err, respone] = await this.handle(
                         RiceCropInformationService.get(data.RiceCropInformation_id)
                    );
                    if (err) {
                         console.log(err)
                    }
                    else {
                         this.riceCropChosen = respone.data;
                         this.isOpenRiceCropDetail = true;
                    }
               }
               else {
                    this.riceCropChosen = data;
               }
          },

          async searchRiceCrop(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != '') {
                    this.clonePredictionList = [];
                    this.riceCropList.forEach(ricecrop => {
                         if (ricecrop.RiceCropInformation_name == this.nameToSearch) {
                              this.clonePredictionList.push(ricecrop);
                         }
                         else if ((String(ricecrop.RiceCropInformation_name).toUpperCase()).indexOf(String(this.nameToSearch).toUpperCase()) != -1) {
                              this.clonePredictionList.push(ricecrop);
                         }
                    });

                    if (this.clonePredictionList.length == 0) {
                         const [error, response] = await this.handle(
                              RiceCropInformationService.findByName(this.nameToSearch)
                         );
                         if (error) {
                              console.log(error);
                         } else {
                              if (response.data != null) {
                                   this.clonePredictionList = response.data;
                              }
                         }
                    }
               }
               else {
                    this.retrieveRiceCropList();
               }
          },

          async predict() {
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
               this.weatherInfor.loadding = false;
               var lat = this.riceCropChosen.ArableLand_latitude;
               var lon = this.riceCropChosen.ArableLand_longitude;
               const start_date = moment(this.riceCropChosen.RiceCropInformation_sowingDate).format("YYYY-MM-DD");
               const end_date = moment(new Date()).format("YYYY-MM-DD");

               let urlAPI1 = `https://archive-api.open-meteo.com/v1/archive?latitude=${lat}&longitude=${lon}&start_date=${start_date}&end_date=${end_date}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
               let data = await fetch(urlAPI1).then(res => res.json())

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

               this.weatherInfor.Temperature = this.weatherInfor.totalTemperature / this.weatherInfor.temperatureList.length;
               this.weatherInfor.Humitidity = this.weatherInfor.totalHumitidity / this.weatherInfor.humitidityList.length;
               this.weatherInfor.WinSpeed = this.weatherInfor.totalWindSpeed / this.weatherInfor.windSpeed.length;
               this.weatherInfor.SolarRadiation = this.weatherInfor.totalSolarRadiation / this.weatherInfor.solarRadiation.length;
               this.weatherInfor.loadding = true;
               this.predict();
          },


          async searchByYear() {
               this.clonePredictionList = [];
               if (this.filter.year == "Tất cả") {
                    this.clonePredictionList = this.riceCropList;
               }
               else {
                    this.riceCropList.forEach(ricecrop => {
                         if (((new Date(ricecrop.RiceCropInformation_sowingDate)).getFullYear() == this.filter.year || (new Date(ricecrop.RiceCropInformation_harvestDate)).getFullYear() == this.filter.year)) {
                              this.clonePredictionList.push(ricecrop);
                         }
                    });
               }

          },

          getYear() {
               this.years = [];
               this.years[0] = "Tất cả";
               for (let index = 2022; index <= (new Date()).getFullYear(); index++) {
                    this.years.push(index);

               }
               return this.years;
          },

          get_day_of_time(d1) {
               let ms1 = (new Date(d1)).getTime();
               var d2 = new Date();
               let ms2 = d2.getTime();
               return Math.ceil((ms2 - ms1) / (24 * 60 * 60 * 1000));
          },

          formatDateTime(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY hh:mm:ss A"));
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY"));
          },

          async setPredictionChoosen(prediction) {
               this.predictionChosen = prediction;
          },

          goToRiceCropDetail() {
               this.$router.push({ name: 'RiceCropDetail', params: { id: this.riceCropChosen.RiceCropInformation_id } });
          },

          goToRiceYieldPredictionDetail() {
               this.$router.push("/RiceYieldPredictionDetail");
          },
          goToRiceCropData() {
               this.$router.push({ name: 'RiceCropDetailForPrediction', params: { id: this.riceCropChosen.RiceCropInformation_id } });
          }
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrievePredictionList();
          this.filter.year = "Tất cả";
     }
}
</script>

<style>
@import url(../../assets/predictionStyle.css);
@import url(../../assets/mainStyle.css);
</style>