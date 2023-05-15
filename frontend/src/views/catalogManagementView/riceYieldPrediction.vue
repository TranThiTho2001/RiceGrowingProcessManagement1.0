<template>
     <div class="container-fluid predictiveManagement pr-4"
          style="background-color: #EAEAEA;height:max-content; min-height: 100vh;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>

          <div class="row predictiveManagementFrame" style="height: max-content;" v-if="!loading">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>
               <div class="right rightPredictiveManagement ">
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
                         <div class="selection-component1">
                              <label class="labelYear">Năm</label>
                              <select class="selectYear" v-model="filter.year" @change="searchByYear()">
                                   <option class="optionYear" v-for="year in getYear()" :key="year">{{ year }}</option>
                              </select>

                              <label class="labelYear">Trạng Thái</label>
                              <select class="selectStatus" v-model="filter.status"
                                   @change="searchByYear(), nameToSearch = ''">
                                   <option class="optionYear" value="all" selected="true">Tất cả</option>
                                   <option class="optionYear" value="monitoring">Đang theo dõi</option>
                                   <option class="optionYear" value="finished">Đã kết thúc</option>
                              </select>
                         </div>
                    </div>

                    <div class=" row ricecropList-row" style="margin-left:-5px;margin-right: 10px ; margin-top:20px">
                         <div class="ricecrop-Component" v-for="(ricecrop, i) in cloneRiceCropList" :key="i">
                              <div class="btnMoreInfor">
                                   <li class="dropdown">
                                        <button type="button " class="btnmore fas fa-ellipsis-v"
                                             data-toggle="dropdown"></button>
                                        <ul class="dropdown-menu multi-level">
                                             <li @click="setRiceCropChosen(ricecrop, 0), goToRiceCropDetail()">
                                                  <a href="#">Xem mùa vụ</a>
                                             </li>
                                             <li class="dropdown-submenu">
                                                  <a href="#" class="" data-toggle="">Dự đoán <i class="fas fa-caret-right"
                                                            style="float: right; padding: auto; font-size: 22px;"></i>
                                                  </a>
                                                  <ul class="dropdown-menu">
                                                       <li
                                                            @click="setRiceCropChosen(ricecrop, 'LinearRegression'), goToRiceCropData()">
                                                            <a href="#">Giải thuật Hồi quy tuyến tính <br>
                                                                 {{ getAlgorithmLinear(ricecrop) }} Kg/ha</a>
                                                       </li>
                                                       <li
                                                            @click="setRiceCropChosen(ricecrop, 'RandomForestRegression'), goToRiceCropData()">
                                                            <a href="#">Giải thuật rừng ngầu nhiên<br>
                                                                 {{ getAlgorithmRandom(ricecrop) }} Kg/ha</a>
                                                       </li>
                                                  </ul>
                                             </li>
                                        </ul>
                                   </li>
                              </div>
                              <h5 class="riceCropName">{{ ricecrop.RiceCropInformation_name }}</h5>
                              <p class="riceCropId">{{ ricecrop.RiceCropInformation_id }}</p>
                              <p class="riceCropId">{{ get_day_of_time(ricecrop.RiceCropInformation_sowingDate) }} Ngày</p>
                              <p class="riceCropId" v-if="ricecrop.Predictions.length > 0">
                                   Giải thuật {{ ricecrop.Predictions[0].Algorithm_name }}
                              </p>
                              <p class="riceCropId" v-if="ricecrop.Predictions.length == 0">Giải thuật </p>
                              <p class="textPredict">Dự đoán </p>
                              <button v-if="ricecrop.Predictions.length > 0" class="resultPrediction">
                                   {{ ricecrop.Predictions[0].Prediction_yield }}
                              </button>
                              <button v-if="ricecrop.Predictions.length == 0" class="resultPrediction">0</button>
                              <p class="textKg">kg/ha</p>
                         </div>
                    </div>
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>

import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
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
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
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

          async loadData() {
               this.loading = true;
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
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


          async retrieveRiceCropList() {
               const [err, respone] = await this.handle(
                    RiceCropInformationService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    var temp = respone.data;
                    this.getPredictionList(temp);
               }
          },

          async getPredictionList(list) {
               var i = 0;
               this.riceCropList = [];
               list.forEach(ricecrop => {
                    if (ricecrop.RiceCropInformation_sowingDate != null) {
                         if (this.get_day_of_time(ricecrop.RiceCropInformation_sowingDate) >= 60) {
                              ricecrop.Predictions = [];
                              this.predictionList.forEach(result => {
                                   if (result.RiceCropInformation_id == ricecrop.RiceCropInformation_id) {
                                        var temp = {
                                             Prediction_yield: 0,
                                             Prediction_date: "",
                                             Algorithm_name: "",
                                        }
                                        if (ricecrop.Predictions == null) {
                                             temp.Prediction_yield = result.Prediction_yield;
                                             temp.Prediction_date = result.Prediction_date;
                                             temp.Algorithm_name = result.Algorithm_name;
                                             ricecrop.Predictions.push(temp);
                                        } else {
                                             temp.Prediction_yield = result.Prediction_yield;
                                             temp.Prediction_date = result.Prediction_date;
                                             temp.Algorithm_name = result.Algorithm_name;
                                             ricecrop.Predictions.push(temp);
                                        }
                                   }

                              });
                              this.riceCropList.push(ricecrop);
                              this.bubbleSort(i);
                              i++;
                         }
                    }
               });
               this.cloneRiceCropList = this.riceCropList;
          },

          async setRiceCropChosen(data, name) {
               if (name == "0") {
                    this.riceCropChosen = data;
               }
               else {
                    data.Algorithm_name = name;
                    this.riceCropChosen = data;
               }
          },


          bubbleSort(position) {
               if (this.riceCropList[position].Predictions.length > 0) {
                    console.log(this.riceCropList[position].Predictions.length)
                    for (let i = 0; i < this.riceCropList[position].Predictions.length - 1; i++) {
                         for (let j = this.riceCropList[position].Predictions.length - 1; j > i; j--) {
                              if ((new Date(this.riceCropList[position].Predictions[j].Prediction_date)).getTime() > (new Date(this.riceCropList[position].Predictions[j - 1].Prediction_date)).getTime()) {
                                   let t = this.riceCropList[position].Predictions[j];
                                   this.riceCropList[position].Predictions[j] = this.riceCropList[position].Predictions[j - 1];
                                   this.riceCropList[position].Predictions[j - 1] = t;
                              }
                         }
                    }
               }

          },

          async searchRiceCrop(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != '') {
                    this.cloneRiceCropList = [];
                    this.riceCropList.forEach(ricecrop => {
                         if (ricecrop.RiceCropInformation_name == this.nameToSearch) {
                              this.cloneRiceCropList.push(ricecrop);
                         }
                         else if ((String(ricecrop.RiceCropInformation_name).toUpperCase()).indexOf(String(this.nameToSearch).toUpperCase()) != -1) {
                              this.cloneRiceCropList.push(ricecrop);
                         }
                    });

                    if (this.cloneRiceCropList.length == 0) {
                         const [error, response] = await this.handle(
                              RiceCropInformationService.findByName(this.nameToSearch)
                         );
                         if (error) {
                              console.log(error);
                         } else {
                              if (response.data != null) {
                                   this.getPredictionList(response.data);
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

          async searchByYear() {
               if (this.filter.year == "Tất cả" && this.filter.status == 'all') {
                    this.cloneRiceCropList = this.riceCropList;
               }
               else if (this.filter.year == "Tất cả" && this.filter.status == 'monitoring') {
                    this.cloneRiceCropList = [];
                    this.riceCropList.forEach(ricecrop => {
                         if (ricecrop.RiceCropInformation_harvestDate == null) {
                              this.cloneRiceCropList.push(ricecrop);
                         }
                    });
               }
               else if (this.filter.year == "Tất cả" && this.filter.status == 'finished') {
                    this.cloneRiceCropList = [];
                    this.riceCropList.forEach(ricecrop => {
                         if (ricecrop.RiceCropInformation_harvestDate != null) {
                              this.cloneRiceCropList.push(ricecrop);
                         }
                    });
               }
               else if (this.filter.year != "Tất cả" && this.filter.status == 'all') {
                    this.cloneRiceCropList = [];
                    this.riceCropList.forEach(ricecrop => {
                         if (((new Date(ricecrop.RiceCropInformation_sowingDate)).getFullYear() == this.filter.year || (new Date(ricecrop.RiceCropInformation_harvestDate)).getFullYear() == this.filter.year)) {
                              this.cloneRiceCropList.push(ricecrop);
                         }
                    });
               }
               else if (this.filter.year != "Tất cả" && this.filter.status == 'monitoring') {
                    this.cloneRiceCropList = [];
                    this.riceCropList.forEach(ricecrop => {
                         if ((new Date(ricecrop.RiceCropInformation_sowingDate)).getFullYear() == this.filter.year && ricecrop.RiceCropInformation_harvestDate == null) {
                              this.cloneRiceCropList.push(ricecrop);
                         }
                    });
               }
               else {
                    this.cloneRiceCropList = [];
                    this.riceCropList.forEach(ricecrop => {
                         if ((new Date(ricecrop.RiceCropInformation_sowingDate)).getFullYear() == this.filter.year && ricecrop.RiceCropInformation_harvestDate != null) {
                              this.cloneRiceCropList.push(ricecrop);
                         }
                    });
               }
          },

          getAlgorithmRandom(ricecrop) {
               var rice_yield = 0;
               if (ricecrop.Predictions.length > 0) {
                    for (let index = 0; index < ricecrop.Predictions.length; index++) {
                         const element = ricecrop.Predictions[index];
                         if (element.Algorithm_name == "Rừng ngẫu nhiên") {
                              rice_yield = element.Prediction_yield;
                              break;
                         }
                    }
               }
               return rice_yield;
          },

          getAlgorithmLinear(ricecrop) {
               var rice_yield = 0;
               if (ricecrop.Predictions.length > 0) {
                    for (let index = 0; index < ricecrop.Predictions.length; index++) {
                         const element = ricecrop.Predictions[index];
                         if (element.Algorithm_name == "Hồi quy tuyến tính") {
                              rice_yield = element.Prediction_yield;
                              break;
                         }
                    }
               }
               return rice_yield;
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
               this.$router.push({ name: 'Prediction', params: { id: this.riceCropChosen.RiceCropInformation_id, Algorithm: this.riceCropChosen.Algorithm_name } });
          }
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrievePredictionList();
          this.filter.year = "Tất cả";
          this.filter.status = "all"
          this.loadData();

     }
}
</script>

<style>
@import url(../../assets/predictionStyle.css);
@import url(../../assets/mainStyle.css);


.predictiveManagement .btnMoreInfor .dropdown-submenu {
     position: relative;
}

.predictiveManagement .btnMoreInfor .dropdown {
     display: inline-block;
     height: 37px;
     background: none;
     box-shadow: none !important;
     border-radius: 0px !important;
}

.predictiveManagement .btnMoreInfor .dropdown-menu .dropdown-submenu>.dropdown-menu {
     top: -10px;
     left: 195%;
     margin-top: -6px;
     margin-left: -1px;
     -webkit-border-radius: 0 6px 6px 6px;
     -moz-border-radius: 0 6px 6px;
     border-radius: 0 6px 6px 6px;
     right: 0;
     position: absolute;
     width: max-content !important;
}

.predictiveManagement .btnMoreInfor .dropdown:hover>.dropdown-menu {
     display: block;
}

.predictiveManagement .btnMoreInfor .dropdown-submenu:hover>.dropdown-menu {
     display: block;

}

.predictiveManagement .btnMoreInfor .dropdown-submenu>a:after {
     display: none;
     content: " ";
     float: right;
}

.predictiveManagement .btnMoreInfor .dropdown-submenu:hover>a:after {
     border-left-color: #fff;
     text-decoration: none;
}

.predictiveManagement .btnMoreInfor .dropdown-menu li a {
     font-family: 'Roboto';
     font-style: normal;
     color: #6D6E73;
     text-decoration: none;
     text-align: center;
}

.predictiveManagement .btnMoreInfor .dropdown-submenu>.dropdown-menu li {
     text-align: center;
     border-bottom: 1px solid #6D6E73;
}

.predictiveManagement .btnMoreInfor .dropdown-menu li:hover {
     background-color: #FFFA37;
     color: #1C1C1F;
}

.predictiveManagement .btnMoreInfor .dropdown-menu li:hover a {
     color: #1C1C1F;
     text-decoration: none;
}
</style>