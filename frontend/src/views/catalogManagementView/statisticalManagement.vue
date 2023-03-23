<template>
     <div class="container-fluid StatisticalManagement pr-4" style="background-color: #EAEAEA; height: 100vmin;">
          <div class="row StatisticalManagementManagementFrame" style="height: 100vmin;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
                    <div  class="left" :class=" {navbarresponsive: openMenu.openMenu }" >
                         <Catalog />
               </div>

               <div class="rightStatisticalManagementManagement right" :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="row ml-4 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{name2: isOpenInput2}"  style="font">Thống kê</h3>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row mr-2 ml-2">
                         <div class="statisticalComponent text-center" @click="goToStatiticsByriceCrop()"
                              id="statisticalRice1">
                              <div class="nameComponent">
                                   <h2>Mùa Vụ</h2>
                              </div>
                              <apexchart width="100%" type="pie" :options="chartDataForRiceCrop.chartOptions"
                                   :series="chartDataForRiceCrop.series">
                              </apexchart>
                         </div>

                         <div class="statisticalComponent text-center">
                              <div class="nameComponent">
                                   <h2>Mẫu Ruộng</h2>
                              </div>
                              <apexchart width="100%" type="pie" :options="chartDataForArableLand.chartOptions"
                                   :series="chartDataForArableLand.series">
                              </apexchart>

                         </div>

                         <div class="statisticalComponent text-center" >
                              <div class="nameComponent">
                                   <h2>Các Hoạt Động</h2>
                              </div>
                              <div class="cicle text-center">
                                   <h2 class="amountFertilizer">{{ otherActivitiesList.length }}</h2>
                              </div>
                         </div>

                         <div class="statisticalComponent text-center" >
                              <div class="nameComponent">
                                   <h2>Phân Bón</h2>
                              </div>
                              <div class="cicle text-center">
                                   <h2 class="amountFertilizer">{{ fertilizerList.length }}</h2>
                              </div>
                         </div>

                         <div class="statisticalComponent text-center">
                              <div class="nameComponent">
                                   <h2>Giống Lúa</h2>
                              </div>
                              <div class="cicle text-center">
                                   <h2 class="amountFertilizer">{{ seedList.length }}</h2>
                              </div>
                         </div>

                         <div class="statisticalComponent text-center">
                              <div class="nameComponent">
                                   <h2>Dịch Bệnh</h2>
                              </div>
                              <div class="cicle text-center">
                                   <h2 class="amountFertilizer">{{ epidemicList.length }}</h2>
                              </div>
                         </div>

                         <div class="statisticalComponent text-center">
                              <div class="nameComponent">
                                   <h2>Thuốc Trị Dịch Bệnh</h2>
                              </div>
                              <div class="cicle text-center">
                                   <h2 class="amountFertilizer">{{ pesticideList.length }}</h2>
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
export default {
     name: "ArableLandManagement",
     components: {
          Catalog,
          TopHeader,
          apexchart: VueApexCharts,

     },


     data() {
          return {
               riceCropList: [],
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
                         colors: ['#98f3c1', '#EEEA41'],
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
                         colors: ['#98f3c1', 'rgb(175, 173, 171)'],
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
                    height:0,
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

          getWidth() {
               console.log(document.body.clientWidth)
               var width = document.body.clientWidth;
               if (width > 1300 && width < 1600) {
                    return true;
               }
               else {
                    return false;
               }
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
                    this.loaded = true;
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
                    console.log(this.chartDataForArableLand.series)
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
                    element.style.width = width+"px";
                    element.style.height = height+"px";
               });
          }

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
@import url(../../assets/statisticalStyle.css);


nav {
     position: absolute;
     display: inline !important;
}

nav .pagination .active .page-link {
     background: #ABD2C8 !important;
     border: 1px solid #FAFAFC !important;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25) !important;
     border-radius: 15px !important;
     margin-left: 10px !important;
     margin-right: 10px !important;
     color: #FFFED8 !important;

     text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     /* width: 40px !important; */
}

nav .pagination .page-item .page-link {
     color: #6D6E73;
     border: none;
     text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 700;
     background-color: #EAEAEA;
     font-size: 20px;
}

@import url(../../assets/mainStyle.css);
</style>