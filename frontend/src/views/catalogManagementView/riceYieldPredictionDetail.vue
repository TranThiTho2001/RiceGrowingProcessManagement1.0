<template>
     <div class="container-fluid predictiveDetailManagement pr-4" style="background-color: #EAEAEA;height:max-content;">
          
          <div class="row predictiveManagementFrame" style="height: max-content;">
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
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Dự đoán năng suất</h3>
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
                              @keyup.enter="searchPrediction(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchPrediction(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>

                         <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="prediction in filteredList()" :key="prediction.RiceCropInformation_name"
                                   @click="searchPrediction(prediction.RiceCropInformation_name), away()">
                                   {{ prediction.RiceCropInformation_name }}</p>
                         </div>

                         <button class="btn btnFinal" @click="goToRiceCropHarvested()">Mùa Vụ Đã Kết Thúc</button>
                         <button class="btn btnPredict1" @click="goToRiceCropToPredict()">Dự Đoán</button>
                    </div>

                    <div class="row resultPrediction-row" style="margin-left:20px;margin-right: 10px ; margin-top:20px">
                         <div class="result-Component" v-for="(resultPrediction, i) in clonePredictionListByRiceCrop"
                              :key="i">
                              <div class="row" style="width: 96%; margin-left: 10px;">
                                   <h5 class="name-Component" style="display: block;">
                                   {{ resultPrediction.RiceCropInformation_name }} - {{ resultPrediction.RiceCropInformation_id }}</h5>
                              </div>
                              <div class="row" style="width: 100%; margin-left: 10px;">
                                   <apexchart style="width: 95%;" type="line" :options="data(resultPrediction)"
                                        :series="dataset(resultPrediction)"></apexchart>
                                   
                              </div>
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
                                   this.riceCropChosen.RiceCropInformation_name }}<br>
                                    <span class="result">{{ this.riceCropChosen.Prediction_yield }}</span>
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
import VueApexCharts from "vue3-apexcharts";
import { mapGetters, mapMutations } from "vuex";
import PredictionService from '../../services/prediction.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import RiceCropInformationService from '../../services/riceCropInformation.service';

export default {
     name: "predictiveManagement",
     components: {
          Catalog,
          TopHeader,
          apexchart: VueApexCharts,
     },

     data() {
          return {
               message: "",
               message1: " ",
               message2: " ",
               nameToSearch: "",
               riceCropList: [],
               predictionList: [],
               isOpenMessage: false,
               isOpenConfirm: false,
               predictionChosen: {},
               isOpenInput2: false,
               isOpenInput1: false,
               predictionListByRiceCrop: [],
               isOpenPredictionHistory: false,
               clonePredictionListByRiceCrop: [],
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
               return this.clonePredictionListByRiceCrop.filter(ricecrop => {
                    return ricecrop.RiceCropInformation_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })

          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          async find(){
               const [err, respone] = await this.handle(
                    RiceCropInformationService.findRiceCropHarvested()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    console.log(respone.data);
               }
          },
          async retrievePredictionList() {
               this.find()
               this.loaded = false;
               const [err, respone] = await this.handle(
                    PredictionService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {

                    this.predictionList = respone.data;
                    this.clonePredictionListByRiceCrop = respone.data;
                    for (let index = 0; index < this.predictionList.length; index++) {
                         var temp = this.predictionList[index];
                         if (this.predictionListByRiceCrop == 0) {
                              var resultPrediction = {};
                              resultPrediction.RiceCropInformation_id = temp.RiceCropInformation_id;
                              resultPrediction.RiceCropInformation_name = temp.RiceCropInformation_name;
                              resultPrediction.resultList = [];
                              const newResult1 = {};
                              newResult1.Prediction_yield = temp.Prediction_yield;
                              newResult1.Prediction_date = temp.Prediction_date;
                              resultPrediction.resultList.push(newResult1);
                              this.predictionListByRiceCrop.push(resultPrediction);
                         }
                         else {
                              var check = 0;
                              this.predictionListByRiceCrop.forEach(element => {
                                   if (element.RiceCropInformation_id == temp.RiceCropInformation_id) {
                                        const newResult2 = {};
                                        newResult2.Prediction_yield = temp.Prediction_yield;
                                        newResult2.Prediction_date = temp.Prediction_date;
                                        element.resultList.push(newResult2);
                                        check = 1;
                                   }
                              });
                              if (check == 0) {
                                   const newRiceCrop = {};
                                   newRiceCrop.RiceCropInformation_id = temp.RiceCropInformation_id;
                                   newRiceCrop.RiceCropInformation_name = temp.RiceCropInformation_name;
                                   newRiceCrop.resultList = [];
                                   const newResult2 = {};
                                   newResult2.Prediction_yield = temp.Prediction_yield;
                                   newResult2.Prediction_date = temp.Prediction_date;
                                   newRiceCrop.resultList.push(newResult2);
                                   this.predictionListByRiceCrop.push(newRiceCrop);
                              }
                         }
                    }
               }
               this.bubbleSort();
               this.clonePredictionListByRiceCrop = this.predictionListByRiceCrop;
               this.loaded = true;
          },

          async searchPrediction(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != '') {
                    this.clonePredictionListByRiceCrop = [];
                    this.predictionListByRiceCrop.forEach(prediction => {
                         if (prediction.RiceCropInformation_name == this.nameToSearch) {
                              this.clonePredictionListByRiceCrop.push(prediction);
                         }
                         else if ((String(prediction.RiceCropInformation_name).toUpperCase()).indexOf(String(this.nameToSearch).toUpperCase()) != -1) {
                              this.clonePredictionListByRiceCrop.push(prediction);
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
                                   this.clonePredictionListByRiceCrop = response.data;
                              }
                         }
                    }
               }
               else {
                    this.retrievePredictionList();
               }
          },

          bubbleSort() {
               for (let i = 0; i < this.predictionListByRiceCrop.length - 1; i++) {
                    for (let j = this.predictionListByRiceCrop.length - 1; j > i; j--) {
                         if (this.predictionListByRiceCrop[j].resultList.length > this.predictionListByRiceCrop[j - 1].resultList.length) {
                              let t = this.predictionListByRiceCrop[j];
                              this.predictionListByRiceCrop[j] = this.predictionListByRiceCrop[j - 1];
                              this.predictionListByRiceCrop[j - 1] = t;
                         }
                    }
               }
          },


          data(prediction) {
               const options = {
                    chart: {
                         id: 'vuechart-example'
                    },
                    xaxis: {
                         categories: []
                    },
                    colors: ['#556b6b'],
                    borders:['2px'],
                    markers: {
                         size: 2,
                         fill: ['#556b6b']
                    },
                    style: {
                         x: 100,
                         fontSize: '12.2px',
                         fontFamily: 'Helvetica, Arial, sans-serif',
                         // fontWeight: 'bold',
                         colors: ['none'],
                         borders: ['2px']
                    },
                    responsive: [
                         {
                              breakpoint: 1400,
                              options: {
                                   legend: {
                                        position: 'bottom'
                                   },
                                   with: "80%",
                              }
                         }
                    ]

               }

               prediction.resultList.forEach(element => {
                    options.xaxis.categories.push(this.formatDate(element.Prediction_date));
               });
               return options;
          },

          dataset(prediction) {
               const series = [{
                    name: 'safe',
                    data: []
               }]
               series[0].name = prediction.RiceCropInformation_name;
               prediction.resultList.forEach(element => {
                    series[0].data.push(element.Prediction_yield);

               });
               return series;
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

          goToRiceCropToPredict() {
               this.$router.push("/Predition");
          },

          goToRiceCropHarvested(){
               this.$router.push("/RiceCropHarvested");
          }
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

.predictiveDetailManagement .btnMoreInfor {
     position: relative !important;
     left: auto !important;
}

.predictiveDetailManagement .navigationBar .btnPrediction {
     display: block;
     width: 88%;
     font-size: 17px;
     background-color: #fff945;
     box-shadow: 4px 4px 2px rgba(0, 0, 0, 0.25);
     color: #5C5D22;
     border: none;
     font-family: 'Roboto';
     font-style: normal;
     border-radius: 14px;
}
</style>



<!-- <table class="tableResultPredict">
                                        <thead>
                                             <tr>
                                                  <th>Ngày dự đoán</th>
                                                  <th>Năng suất</th>
                                                  <th></th>
                                             </tr>
                                        </thead>
                                        <tbody>
                                             <tr v-for="(result, j) in resultPrediction.resultList" :key="j">
                                                  <td>{{ formatDateTime(result.Prediction_date) }}</td>
                                                  <td>{{ result.Prediction_yield }}</td>
                                                  <td>
                                                       <div class="btnMoreInfor">
                                                            <button type="button" class="btn-sm btnmore"
                                                                 data-toggle="dropdown" aria-haspopup="true"
                                                                 aria-expanded="false">
                                                                 <i class="fas fa-ellipsis-v"></i>

                                                                 <div class="dropdown-menu">
                                                                      <a class="dropdown-item action"
                                                                           @click="setRiceCropChosen(ricecrop), getWeather()">
                                                                           <span class="fas fa-lightbulb"
                                                                                style="font-size: 20px;"></span> Dự
                                                                           Đoán
                                                                      </a>
                                                                      <a class="dropdown-item" href="#"
                                                                           @click="setRiceCropChosen(ricecrop), goToRiceCropDetail()">
                                                                           <span class="fas fa-eye"></span>Xem Mùa Vụ

                                                                      </a>
                                                                 </div>
                                                            </button>
                                                       </div>
                                                  </td>
                                             </tr>
                                        </tbody>
                                   </table> -->