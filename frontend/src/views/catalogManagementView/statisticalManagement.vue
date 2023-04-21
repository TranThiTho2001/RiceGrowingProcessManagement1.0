<template>
     <div class="container-fluid StatisticalManagement pr-4" style="background-color: #EAEAEA; height: 100vmin;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
          <Preloader color="red" scale="0.4" /></div>
          <div class="row StatisticalManagementManagementFrame" style="height: 100vmin;" v-if="!loading">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>

               <div class="right rightStatisticalManagementManagement" :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="mb-5 pb-2 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Thống kê</h3>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row mr-2 ml-2 pr-1" style="margin-top: 145px; z-index: 4; width: 99%;">
                         <div class="col-sm-7">
                              <div class="row ml-1">
                                   <div class="statistical-Component text-center" @click="goToStatiticsByriceCrop()"
                                        id="statisticalRice1">

                                        <h5 class="nameComponent">MÙA VỤ</h5>
                                        <apexchart class="apexchart" type="pie" :options="chartDataForRiceCrop.chartOptions"
                                             :series="chartDataForRiceCrop.series">
                                        </apexchart>
                                   </div>

                                   <div class="statistical-Component text-center">
                                        <h5 class="nameComponent">MẪU RUỘNG</h5>
                                        <apexchart width="100%" type="pie" :options="chartDataForArableLand.chartOptions"
                                             :series="chartDataForArableLand.series">
                                        </apexchart>

                                   </div>

                                   <div class="statistical-Component text-center">
                                        <h5 class="nameComponent">HOẠT ĐỘNG</h5>
                                        <div class="cicle text-center">
                                             <h2 class="amountFertilizer">{{ otherActivitiesList.length }}</h2>
                                        </div>
                                   </div>

                                   <div class="statistical-Component text-center">
                                        <h5 class="nameComponent">PHÂN BÓN</h5>
                                        <div class="cicle text-center">
                                             <h2 class="amountFertilizer">{{ fertilizerList.length }}</h2>
                                        </div>
                                   </div>

                                   <div class="statistical-Component text-center">
                                        <h5 class="nameComponent">GIỐNG LÚA</h5>
                                        <div class="cicle text-center">
                                             <h2 class="amountFertilizer">{{ seedList.length }}</h2>
                                        </div>
                                   </div>

                                   <div class="statistical-Component text-center">
                                        <h5 class="nameComponent">BỆNH DỊCH</h5>
                                        <div class="cicle text-center">
                                             <h2 class="amountFertilizer">{{ epidemicList.length }}</h2>
                                        </div>
                                   </div>

                                   <div class="statistical-Component text-center">
                                        <h5 class="nameComponent">THUỐC TRỊ BỆNH DỊCH</h5>
                                        <div class="cicle text-center">
                                             <h2 class="amountFertilizer">{{ pesticideList.length }}</h2>
                                        </div>
                                   </div>
                              </div>
                         </div>
                         <div class="col-sm-5 text-center col-satisticByYield" v-if="loaded">
                              <div class="nameComponent">
                                   <h5>MÙA VỤ NĂNG SUẤT CAO</h5>
                              </div>
                              <div class="row row-satisticByYield" v-for="(riceCrop, i) in riceCropListByFinish" :key="i">
                                   <div class="left-statisticByYield align-self-center" style="width: 30%; vertical-align: middle;">
                                        <h4>{{ riceCrop.RiceCropInformation_yield }}</h4>
                                        <p  class="title">Tạ/ha</p>
                                   </div>
                                   <div class="right-statisticByYeild text-left" style="width: 70%;  ">
                                        <h5>{{ riceCrop.RiceCropInformation_name }}</h5>
                                        <div style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"><span class="title">Sử dụng giống lúa: </span><span class="value">{{ riceCrop.Seed_name }}</span></div>
                                        <div style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"><span class="title">Canh tác trên mẫu ruộng:  </span><span class="value">{{ riceCrop.ArableLand_owner }}</span></div>
                                        <div style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"><span class="title"></span> <span class="value">{{ riceCrop.Province_name }}</span></div>

                                   </div>
                              </div>
                         </div>
                    </div>
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>
</template>

<script type=”text/javascript”>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import RiceCropInformationService from '@/services/riceCropInformation.service';
import VueApexCharts from "vue3-apexcharts";
import ArableLandService from '@/services/arableLand.service';
import FertilizerService from '@/services/fertilizer.service';
import PesticideService from '@/services/pesticide.service';
import EpidemicService from '@/services/epidemic.service';
import SeedService from '@/services/seed.service';
import OtherActivitiesService from '@/services/otherActivities.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
export default {
     name: "ArableLandManagement",
     components: {
          Catalog,
          TopHeader,
          Preloader,
          apexchart: VueApexCharts,

     },


     data() {
          return {
               riceCropList: [],
               loading: true,
               riceCropListByMonitoring: [],
               riceCropListByFinish: [],
               arableLandList: [],
               fertilizerList: [],
               pesticideList: [],
               epidemicList: [],
               seedList: [],
               otherActivitiesList: [],
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               cloneArableLandList: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },

               active: {
                    rightActive: false,
                    leftnNoneActive: false,
               },
               chartDataForRiceCrop: {
                    series: [],
                    chartOptions: {
                         chart: {
                              width: 500,
                              type: 'pie',
                         },
                         labels: ["Đang theo dõi", "Đã kết thúc"],
                         colors: ['#ABD2C8', '#FFFD9F'],
                         fill: {
                              colors: ['#ABD2C8', '#FFFD9F'],
                              opacity: 0.9,
                              type: 'solid',
                         },
                         dataLabels: {
                              enabled: true,
                              textAnchor: 'end',
                              distributed: false,
                              offsetX: 0.5,
                              offsetY: 0.5,
                              style: {
                                   x: 100,
                                   fontSize: '12.2px',
                                   fontFamily: 'Helvetica, Arial, sans-serif',
                                   // fontWeight: 'bold',
                                   colors: ['none'],
                                   borders: ['none']
                              }, background: {
                                   enabled: true,
                                   foreColor: '#5C5D22',
                                   padding: 0,
                                   // opacity: 0.5,
                                   borderColor: 'none'
                              },
                              dropShadow: {
                                   enabled: false,
                                   top: 2,
                                   left: 1,
                                   color: '#5C5D22',
                              },

                         },
                         legend: {
                              show: true,
                              showForSingleSeries: false,
                              showForNullSeries: true,
                              showForZeroSeries: true,
                              position: 'bottom',
                              horizontalAlign: 'center',
                              fontSize: '14px',
                              fontFamily: 'Helvetica, Arial',
                              fontWeight: 400,
                         },
                         responsive: [
                              {
                                   breakpoint: 1600,
                                   options: {
                                        legend: {
                                             position: 'bottom'
                                        }
                                   }
                              }
                         ]
                    },
               },

               chartDataForArableLand: {
                    series: [0, 0],
                    chartOptions: {
                         chart: {
                              width: 500,
                              type: 'pie',
                         },
                         labels: ["Đang trong mùa vụ", "Đang để trống"],
                         colors: ['#ABD2C8', '#D0D1D6'],
                         fill: {
                              colors: ['#ABD2C8', '#D0D1D6'],
                              opacity: 0.9,
                              type: 'solid',
                         },
                         dataLabels: {
                              enabled: true,

                              style: {
                                   fontSize: '12px',
                                   fontFamily: 'Helvetica, Arial, sans-serif',
                                   fontWeight: 'bold',
                                   colors: ['none'],
                                   borders: ['none']
                              }, background: {
                                   borderColor: 'none',
                                   enabled: true,
                                   foreColor: '#5C5D22',
                              },
                              dropShadow: {
                                   enabled: false,
                                   top: 2,
                                   left: 1,
                                   color: '#5C5D22',
                              }
                         },
                         legend: {
                              show: true,
                              showForSingleSeries: false,
                              showForNullSeries: true,
                              showForZeroSeries: true,
                              position: 'bottom',
                              horizontalAlign: 'center',
                              fontSize: '14px',
                              fontFamily: 'Helvetica, Arial',
                              fontWeight: 400,
                         },
                         backgroundColors: ['#FFFD9F', '#FFFD9F'],
                         responsive: [
                              {
                                   breakpoint: 1600,
                                   options: {
                                        legend: {
                                             position: 'bottom'
                                        }
                                   }
                              }
                         ]
                    },
               },

               loaded: false,
               options: {
                    responsive: true,
                    maintainAspectRatio: false
               },
               styleComponent: {
                    width: 0,
                    height: 0,
               }
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
               return this.cloneArableLandList.filter(arableLand => {
                    return arableLand.ArableLand_owner.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
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
                    this.riceCropList = respone.data;
                    this.riceCropListByFinish = [];
                    this.riceCropListByMonitoring = [];
                    this.riceCropList.forEach(element => {
                         if (element.RiceCropInformation_harvestDate == null) {
                              this.riceCropListByMonitoring.push(element);
                         }
                         else {
                              this.riceCropListByFinish.push(element);
                         }
                    });
                    this.chartDataForRiceCrop.series = [];
                    this.chartDataForRiceCrop.series[0] = (this.riceCropListByMonitoring.length);
                    this.chartDataForRiceCrop.series[1] = (this.riceCropListByFinish.length);
                    this.bubbleSort();
                    this.loaded = true;

               }

               if(this.loading){
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
          },

          async retrieveArableLandList() {
               const [err, respone] = await this.handle(
                    ArableLandService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.arableLandList = respone.data;
                    this.arableLandList.forEach(element1 => {
                         var check = 0;
                         this.riceCropListByMonitoring.forEach(element2 => {
                              if (element1.ArableLand_id == element2.ArableLand_id) {
                                   this.chartDataForArableLand.series[0] += 1;
                                   check = 1;
                              }
                         });
                         if (!check) {
                              this.chartDataForArableLand.series[1] += 1;
                         }
                    });
               }
          },

          async retrieveFertilizerList() {
               const [err, respone] = await this.handle(
                    FertilizerService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.fertilizerList = respone.data;
                    this.getwidth()
               }
          },

          async retrieveEpidemicList() {
               const [err, respone] = await this.handle(
                    EpidemicService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.epidemicList = respone.data;
               }
          },

          async retrievePesticideList() {
               const [err, respone] = await this.handle(
                    PesticideService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.pesticideList = respone.data;
               }
          },


          async retrieveSeedList() {
               const [err, respone] = await this.handle(
                    SeedService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.seedList = respone.data;
               }
          },

          async retrieveotherActivitisList() {
               const [err, respone] = await this.handle(
                    OtherActivitiesService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.otherActivitiesList = respone.data;
               }
          },

          goToStatiticsByriceCrop() {
               this.$router.push("/Statistical/StatisticsByRiceCrop");
          },

          getwidth() {
               var width = document.getElementById("statisticalRice1").offsetWidth;
               var height = document.getElementById("statisticalRice1").offsetHeight;
               var list = document.getElementsByClassName("statisticalComponent");
               Array.from(list).forEach(element => {
                    element.style.width = width + "px";
                    element.style.height = height + "px";
               });
          },

          bubbleSort() {
               for (let i = 0; i < this.riceCropListByFinish.length - 1; i++) {
                    for (let j = this.riceCropListByFinish.length - 1; j > i; j--) {
                         if (this.riceCropListByFinish[i].RiceCropInformation_yield != null && this.riceCropListByFinish[j].RiceCropInformation_yield != null) {
                              if (this.riceCropListByFinish[j].RiceCropInformation_yield > this.riceCropListByFinish[j - 1].RiceCropInformation_yield) {
                                   let t = this.riceCropListByFinish[j];
                                   this.riceCropListByFinish[j] = this.riceCropListByFinish[j - 1];
                                   this.riceCropListByFinish[j - 1] = t;
                              }
                         }

                    }
               }
          },

     },

     created() {
          this.retrieveRiceCropList();
          this.retrieveArableLandList();
          this.initEmployeeState();
          this.retrieveFertilizerList();
          this.retrieveEpidemicList();
          this.retrievePesticideList();
          this.retrieveSeedList();
          this.retrieveotherActivitisList();
     },

}
</script>

<style>
@import url(../../assets/mainStyle.css);
@import url(../../assets/statisticalStyle.css);
</style>