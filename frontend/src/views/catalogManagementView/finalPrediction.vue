<template>
     <div class="container-fluid predictiveDetailManagement pr-4" style="background-color: #EAEAEA;height:max-content;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
          <Preloader color="red" scale="0.4" /></div>
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

                         <button class="btn btnFinal" @click="goToRiceCropToPredict()">Mùa Vụ Đã Kết Thúc</button>
                         <button class="btn btnPredict1" @click="goToRiceCropToPredict()">Dự Đoán</button>
                    </div>

                    <div class="row resultPrediction-row" style="margin-left:20px;margin-right: 10px ; margin-top:20px">
                         <div class="result-Component" v-for="(resultPrediction, i) in riceCropHarvestedList"
                              :key="i">
                              <div class="row" style="width: 96%; margin-left: 10px;">
                                   <h5 class="name-Component" style="display: block;">{{
                                        resultPrediction.RiceCropInformation_name
                                   }}</h5>
                              </div>
                              <div class="row" style="width: 100%; margin-left: 10px;">
                                   <apexchart style="width: 95%;" type="column" :options="data(resultPrediction)"
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
import PredictionService from '../../services/prediction.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import RiceCropInformationService from '../../services/riceCropInformation.service';
import VueApexCharts from "vue3-apexcharts";

export default {
     name: "predictiveManagement",
     components: {
          Catalog,
          TopHeader,
          Preloader,
          apexchart: VueApexCharts,
     },

     data() {
          return {
               loading: true,
               predictionList: [],
               riceCropList: [],
               message1: " ",
               message2: " ",
               isOpenPredictionHistory: false,
               isOpenMessage: false,
               isOpenConfirm: false,
               predictionChosen: {},
               nameToSearch: "",
               message: "",
               isOpenInput2: false,
               isOpenInput1: false,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               clonePredictionListByRiceCrop: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: false,
                    isCloseMenu: false,
               },

               active: {
                    rightActive: false,
                    leftnNoneActive: false,
               },
               predictionListByRiceCrop: [],
               riceCropHarvestedList: [],
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

          async findPrediction(id, position) {
               this.loaded = false;
               const [err, response] = await this.handle(
                    PredictionService.findByRiceCropInformation(id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCropHarvestedList[position].resultPredictions = [];
                    var temp = [];
                    temp = response.data;
                    if (temp.length > 0) {
                         temp.forEach(result => {
                              this.riceCropHarvestedList[position].resultPredictions.push(result);
                         });
                    }
               }

          },


          async retrieveRiceCropList() {
               this.loading = true;
               const [err, respone] = await this.handle(
                    RiceCropInformationService.findRiceCropHarvested()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCropHarvestedList = respone.data;
                    for (let index = 0; index < this.riceCropHarvestedList.length; index++) {
                         const element = this.riceCropHarvestedList[index];
                         this.findPrediction(element.RiceCropInformation_id, index);
                    }
               }
               if(this.loading){
                    setTimeout(() => {
                         this.loading = false;
                    }, 600);
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
                    colors: ['#FFFD9F'],
                    borders: ['2px'],
                    markers: {
                         size: 2,
                         fill: ['#FFFD9F']
                    },
                    style: {
                         x: 100,
                         fontSize: '12.2px',
                         fontFamily: 'Helvetica, Arial, sans-serif',
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
               options.xaxis.categories.push(prediction.RiceCropInformation_name)
               return options;
          },

          dataset(prediction) {
               const series = [
                    {
                         data: [
                         ]
                    },
                    {
                         name: 'safe',
                         data: []
                    }
               ]
               series[0].name = prediction.RiceCropInformation_name;
               var newdata = {};
               newdata.x = prediction.RiceCropInformation_name;
               newdata.y = prediction.resultPredictions[0].Prediction_yield
              series[0].data.push(newdata);
              series[1].data.push(newdata);
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
          }
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveRiceCropList()
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