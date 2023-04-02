<template>
     <div class="container-fluid predictiveManagement pr-4" style="background-color: #EAEAEA;height:100%;">
          <div class="row predictiveManagementFrame" style="height: 100vmin;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>
               <div class="right rightPredictiveManagement " :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="row pt-3 mb-5 pb-1 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Dự đoán năng suất</h3>
                         </div>
                         <div class="">
                              <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                                   @click="retrievePredictionList, isOpenInput1 = true"
                                   @keyup.enter="searchName(nameToSearch), away()"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch1" @click="searchName(nameToSearch), away()"
                                   v-if="nameToSearch == '' && !isOpenSearch.open">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>

                              <input v-if="isOpenInput2 || (isOpenSearch.open)" autofocus type="text"
                                   class="form-control inputSearch2" placeholder="Tìm" style="width: 2%;"
                                   v-model="nameToSearch" @click="retrievePredictionList"
                                   @keyup.enter="searchName(nameToSearch), away()"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch2" @click="isOpenInput2 = !isOpenInput2">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>

                              <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                   <p class="item" v-for="prediction in filteredList()"
                                        :key="prediction.RiceCropInformation_name"
                                        @click="searchName(prediction.RiceCropInformation_name), away()">
                                        {{ prediction.RiceCropInformation_name }}</p>
                              </div>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row ml-4 mr-1 mt-3 pb-4 pt-2">
                         <div class="col-sm-12 text-right">
                              <button class="btn btnCreate" v-if="!isOpenRiceCropDetail && !isOpenRiceCropList"
                                   @click="isOpenRiceCropList = !isOpenRiceCropList, retrieveRiceCropList()"> Dự
                                   đoán</button>
                              <button class="btn btnCreate" v-if="isOpenRiceCropDetail" @click="getWeather()"> Dự đoán</button>
                         </div>
                    </div>

                    <div class=" row scrollTable">
                         <div class="col-sm-12 justify-content-center">
                              <table class="table predictiveList"
                                   v-if="loaded && !isOpenRiceCropList && !isOpenRiceCropDetail">
                                   <thead>
                                        <tr>
                                             <th class="centerclass" style="">STT</th>
                                             <th class="centerclass">Mã mùa vụ</th>
                                             <th class="centerclass">Tên mùa vụ</th>
                                             <th class="centerclass">Ngày dự đoán</th>
                                             <th class="centerclass">Năng suất(kg/ha)</th>
                                             <th></th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(prediction, i ) in predictionList" :key="i">
                                             <td class="centerclass" data-label="STT">{{ i + 1 }}</td>
                                             <td class="centerclass" data-label="Mã mùa vụ">
                                                  {{ prediction.RiceCropInformation_id }}</td>
                                             <td class="centerclass" data-label="Tên mùa vụ">
                                                  {{ prediction.RiceCropInformation_name }}</td>
                                             <td class="centerclass" data-label="Ngày dự đoán">{{
                                                  formatDateTime(prediction.Prediction_date) }}</td>
                                             <td class="centerclass" data-label="Năng suất(kg/ha)">{{
                                                  prediction.Prediction_yield }}</td>
                                             <td data-label="Tùy chọn">
                                                  <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown"
                                                       aria-haspopup="true" aria-expanded="false">
                                                       <i class="fas fa-ellipsis-v"></i>
                                                  </button>
                                                  <div class="dropdown-menu">
                                                       <a class="dropdown-item action"
                                                            @click="setActivityChoosen(prediction), isOpenUpdateActivities = !isOpenUpdateActivities">
                                                            <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                       </a>
                                                       <a class="dropdown-item" href="#"
                                                            @click="setActivityChoosen(prediction), isOpenConfirm = !isOpenConfirm">
                                                            <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                       </a>
                                                  </div>
                                             </td>
                                        </tr>
                                   </tbody>
                              </table>

                              <table class="table riceCropList" v-if="loaded && isOpenRiceCropList && !isOpenRiceCropDetail">
                                   <thead>
                                        <tr>
                                             <th class="centerclass" style="">STT</th>
                                             <th class="centerclass">Mã mùa vụ</th>
                                             <th>Tên mùa vụ</th>
                                             <th>Vụ mùa</th>
                                             <th>Giống lúa</th>
                                             <th>Mẫu ruộng</th>
                                             <th class="centerclass">Ngày gieo xạ</th>
                                             <!-- <th class="centerclass">Năng suất(kg/ha)</th> -->
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(ricecrop, i ) in riceCropList" :key="i"
                                             @click="setRiceCropChosen(ricecrop), isOpenRiceCropDetail = true">
                                             <td class="centerclass" data-label="STT">{{ i + 1 }}</td>
                                             <td class="centerclass" data-label="Mã mùa vụ">{{
                                                  ricecrop.RiceCropInformation_id
                                             }}</td>
                                             <td data-label="Tên mùa vụ">{{
                                                  ricecrop.RiceCropInformation_name }}</td>
                                             <td data-label="Vụ mùa">{{ ricecrop.Crop_name }}</td>
                                             <td data-label="Giống lúa">{{ ricecrop.Seed_name }}</td>
                                             <td data-label="Mẫu ruộng">{{ ricecrop.ArableLand_owner }}</td>
                                             <td class="centerclass" data-label="Ngày gieo xạ">{{
                                                  formatDate(ricecrop.RiceCropInformation_sowingDate) }}</td>
                                             <!-- <td class="centerclass" data-label="Năng suất(kg/ha)">{{
                                                  prediction.Prediction_yield }}</td> -->
                                        </tr>
                                   </tbody>
                              </table>

                              <RiceCropDetailsComponent v-if="isOpenRiceCropDetail" :riceCropChosen="riceCropChosen" />
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

                    <div class="confirmationDialog" v-if="predicting">
                         <div>
                              <p class="labelConfirm mt-4 pt-4">Đang xử lý....</p>
                         </div>
                         <span v-show="predicting" class="spinner-border spinner-border-sm"></span>
                    </div>
                    <div class="confirmationDialog" v-if="result">
                         <p style="color:#515151; text-align:center; margin-top: 30px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Năng suất dự đoán cho mùa vụ {{
                                   this.riceCropChosen.RiceCropInformation_name }}<br> {{ this.riceCropChosen.Prediction_yield }}
                              kg/ha
                         </p>
                         <button class="btnNo btn btn-sm btn-outline-secondary mb-3" @click="result = !result">OK</button>
                    </div>
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import PredictionService from '../../services/prediction.service';
import RiceCropInformationService from '../../services/riceCropInformation.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import RiceCropDetailsComponent from '@/components/catalogManagementComponents/riceCropDetailsComponent.vue';
import moment from 'moment';

// import axios from 'axios';

export default {
     name: "predictiveManagement",
     components: {
          Catalog,
          TopHeader,
          RiceCropDetailsComponent
     },

     data() {
          return {
               predictionList: [],
               riceCropList: [],
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               isOpenRiceCropList: false,
               isOpenRiceCropDetail: false,
               riceCropChosen: {},
               predictionChosen: {},
               nameToSearch: "",
               message: "",
               isOpenInput2: false,
               isOpenInput1: false,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               clonePredictionList: [],
               cloneRiceCropList: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },

               active: {
                    rightActive: false,
                    leftnNoneActive: false,
               },

               loaded: false,
               result: false,
               predicting: false,
               weatherInfor: [],

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
               if (!this.isOpenRiceCropList) {
                    return this.clonePredictionList.filter(prediction => {
                         return prediction.RiceCropInformation_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
                    })
               }
               else {
                    return this.cloneRiceCropList.filter(ricecrop => {
                         return ricecrop.RiceCropInformation_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
                    })
               }

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
                    this.clonePredictionList = respone.data;
               }
               this.loaded = true;
          },

          async retrieveRiceCropList() {
               this.loaded = false;
               const [err, respone] = await this.handle(
                    RiceCropInformationService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCropList = respone.data;
                    this.cloneRiceCropList = respone.data;
               }
               this.loaded = true;
          },

          async setRiceCropChosen(data) {
               this.riceCropChosen = data;
          },



          async searchName(data) {
               if (!this.isOpenRiceCropList) {
                    this.searchPrediction(data);
               }
               else {
                    this.searchRiceCrop(data);
               }
          },

          async searchPrediction(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != '') {
                    this.predictionList = [];
                    this.clonePredictionList.forEach(prediction => {
                         if (prediction.RiceCropInformation_name == this.nameToSearch) {
                              this.predictionList.push(prediction);
                         }
                         else if ((String(prediction.RiceCropInformation_name).toUpperCase()).indexOf(String(this.nameToSearch).toUpperCase()) != -1) {
                              this.predictionList.push(prediction);
                         }
                    });

                    if (this.predictionList.length == 0) {
                         const [error, response] = await this.handle(
                              PredictionService.findByName(this.nameToSearch)
                         );
                         if (error) {
                              console.log(error);
                         } else {
                              if (response.data != null) {
                                   this.predictionList = response.data;
                              }
                         }
                    }
               }
               else {
                    this.retrievePredictionList();
               }
          },

          async searchRiceCrop(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != '') {
                    this.predictionList = [];
                    this.cloneRiceCropList.forEach(ricecrop => {
                         if (ricecrop.RiceCropInformation_name == this.nameToSearch) {
                              this.riceCropList.push(ricecrop);
                         }
                         else if ((String(ricecrop.RiceCropInformation_name).toUpperCase()).indexOf(String(this.nameToSearch).toUpperCase()) != -1) {
                              this.riceCropList.push(ricecrop);
                         }
                    });

                    if (this.predictionList.length == 0) {
                         const [error, response] = await this.handle(
                              RiceCropInformationService.findByName(this.nameToSearch)
                         );
                         if (error) {
                              console.log(error);
                         } else {
                              if (response.data != null) {
                                   this.riceCropList = response.data;
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
                    infor.windSpeed =  this.weatherInfor.WinSpeed;
                    if(this.riceCropChosen.Crop_id == 'C00001'){
                         infor.crop = '1';
                    }
                    else if(this.riceCropChosen.Crop_id == 'C00002'){
                         infor.crop = '2';
                    }
                    else{
                         infor.crop = '3';
                    }
                    infor.area = this.riceCropChosen.ArableLand_areaId;
                    console.log(infor)
                    const [err, respone] = await this.handle(
                         PredictionService.create(this.riceCropChosen.RiceCropInformation_id, infor)
                    );
                    if (err) {
                         console.log(err)
                    }
                    else {
                         console.log(respone.data);
                         console.log(infor)
                         this.riceCropChosen.Prediction_yield = respone.data.Prediction_yield;
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

               let urlAPI1 = `https://archive-api.open-meteo.com/v1/archive?latitude=${lat}&longitude=${lon}&start_date=${start_date}&end_date=${end_date}&timezone=GMT&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
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
               console.log("Tong luong Mua: " + this.weatherInfor.Precipitation + " Nhiet do trung binh: " + this.weatherInfor.Temperature + " Do am: " + this.weatherInfor.Humitidity + " Tocs do gia: " + this.weatherInfor.WinSpeed + " Buc xa: " + this.weatherInfor.SolarRadiation);
               this.weatherInfor.loadding = true;
               console.log(this.weatherInfor.loadding)
               this.predict()
          },


          // async getMoreWeather(lat, lon, Timestamp) {
          // var t;
          // const options = {
          //      method: 'GET',
          //      headers: {
          //           'X-RapidAPI-Key': 'b059eff2d8msh0a3e5c7029b2dcfp1116ddjsn5f9d12cd2b06',
          //           'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
          //      }
          // };
          // console.log(`https://weatherapi-com.p.rapidapi.com/history.json?q=${lat},${lon}&dt=${Timestamp}&lang=en`)
          // fetch(`https://weatherapi-com.p.rapidapi.com/history.json?q=${lat},${lon}&dt=${Timestamp}&lang=en`, options)
          //      .then((response) => {
          //           return response.json().then((data) => {
          //               console.log(data.forecast.forecastday[0].day)
          //               this.weatherInfor.humitidityList.push(data.forecast.forecastday[0].day.avghumidity);
          //               this.weatherInfor.temperatureList.push(data.forecast.forecastday[0].day.avgtemp_c)
          //                return data;
          //           }).catch((err) => {
          //                console.log(err);
          //           })
          //      })
          //      .catch(err => console.error(err));
          // console.log(t)


          // },

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
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrievePredictionList();
     }
}
</script>

<style>
@import url(../../assets/predictionStyle.css);
@import url(../../assets/mainStyle.css);
</style>