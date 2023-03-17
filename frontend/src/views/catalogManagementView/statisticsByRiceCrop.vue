<template>
     <div class="container-fluid statisticsByRiceCrop pr-4" style="background-color: #EAEAEA;">
          <div class="row statisticsByRiceCropFrame" style="min-height: 100vmin;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true"></button>
               <div class="" :class="{ menubar: openMenu.openMenu }" v-if="openMenu.openMenu">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>
               <div class="left">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>
               <div class="right statisticsByRiceCropscroll">
                    <div class="row ml-4 pt-3 mb-4 pb-1 mr-2 topRight">
                         <div class="col-md-2">
                              <h3 class="name">Mẫu ruộng</h3>
                         </div>
                         <div class="col-md-8">

                         </div>

                         <div class="col-md-2 text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row mr-2 ml-2  statisticalBy" style=" background-color: beige; height: 165px;">
                         <div class="leftStatistical ">
                              <label style="overflow: hidden; white-space: nowrap;text-overflow: ellipsis;  ">Thống kê
                                   mùa vụ theo: </label><br>
                              <div class="scrollChoose row">
                                   <div class="col-lg-6">
                                        <input type="radio" id="arableLand" name="all" value="all"
                                             v-model="chooseSatisticsBy" checked="true"
                                             @click="retrieveCropList, nameToSearch = ''">
                                        <label for="all">Tất cả</label><br>
                                        <input type="radio" id="arableLand" name="statisticsby" value="arableLand"
                                             v-model="chooseSatisticsBy" @click="retrieveArableLandList()">
                                        <label for="arableLand">Mẫu ruộng</label><br>
                                        <input type="radio" id="crop" name="statisticsby" value="crop"
                                             v-model="chooseSatisticsBy" @click="deleteRiceCropList(), retrieveCropList()">
                                        <label for="crop">Vụ mùa</label><br>
                                        <input type="radio" id="seed" name="statisticsby" value="seed"
                                             v-model="chooseSatisticsBy" @click="deleteRiceCropList(), retrieveSeedList()">
                                        <label for="seed">Giống lúa</label><br>
                                   </div>
                                   <div class="col-lg-6">
                                        <input type="radio" id="epidemic" name="statisticsby" value="epidemic"
                                             v-model="chooseSatisticsBy">
                                        <label for="epidemic">Dịch bệnh gây hại</label><br>
                                        <input type="radio" id="fertilizer" name="statisticsby" value="fertilizer"
                                             v-model="chooseSatisticsBy">
                                        <label for="fertilizer">Phân bón</label><br>
                                        <input type="radio" id="pesticide" name="statisticsby" value="pesticide"
                                             v-model="chooseSatisticsBy">
                                        <label for="pesticide">Thuốc trị bệnh dịch</label>
                                   </div>
                              </div>
                         </div>

                         <div class="rightStatistical">
                              <div class="statisticsByArabeLand" v-if="chooseSatisticsBy == 'arableLand'">
                                   <input type="text" class="form-control inputSearch4" placeholder="Tìm"
                                        v-model="nameToSearch" @click="retrieveRiceCropList"
                                        @keyup.enter="searchByArableLand(nameToSearch)"
                                        @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                                   <button class="btnSearch4" @click="searchByArableLand(nameToSearch)"
                                        v-if="nameToSearch == '' && !isOpenSearch.open">
                                        <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                                   </button>
                                   <div :class="{ openSearch4: isOpenSearch.open, closeSearch4: isOpenSearch.close }">
                                        <p class="item" v-for="arableLand in filteredArableLandList()"
                                             :key="arableLand.ArableLand_id"
                                             @click="searchByArableLand(arableLand.id_owner), isOpenSearch.open = false, isOpenSearch.close = true">
                                             {{ arableLand.id_owner }}</p>
                                   </div>
                                   <div class="arablelandScroll">
                                        <p class="arablename" v-for="arableLand in cloneArableLandList"
                                             :key="arableLand.ArableLand_id" :id="arableLand.ArableLand_id"
                                             @click="searchByArableLand(arableLand.id_owner)">
                                             {{ arableLand.id_owner }}</p>
                                   </div>
                              </div>

                              <div class="statisticsByCrop" v-if="chooseSatisticsBy == 'crop'">
                                   <h6>Chọn vụ mùa</h6>
                                   <div v-for="crop in cropList" :key="crop.Crop_id">
                                        <input type="checkbox" :id="crop.Crop_id" :value="crop.Crop_name"
                                             v-model="idToSearchByCrop" @change="searchByIDCrop()">
                                        <label for=""> {{ crop.Crop_name }}</label><br>
                                   </div>
                              </div>

                              <div class="statisticsBySeedList" v-if="chooseSatisticsBy == 'seed'">
                                   <input type="text" class="form-control inputSearch4" placeholder="Tìm"
                                        v-model="nameToSearch" @click="retrieveSeedList"
                                        @keyup.enter="searchBySeed(nameToSearch)"
                                        @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                                   <button class="btnSearch4" @click="searchBySeed(nameToSearch)"
                                        v-if="nameToSearch == '' && !isOpenSearch.open">
                                        <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                                   </button>
                                   <div :class="{ openSearch4: isOpenSearch.open, closeSearch4: isOpenSearch.close }">
                                        <p class="item" v-for="seed in filteredSeedList()" :key="seed.Seed_id"
                                             @click="searchBySeed(seed.Seed_id), isOpenSearch.open = false, isOpenSearch.close = true">
                                             {{ seed.Seed_id_name }}</p>
                                   </div>
                                   <div class="arablelandScroll">
                                        <p class="arablename" v-for="seed in seedList" :key="seed.Seed_id" :id="seed.Seed_id"
                                             @click="searchBySeed(seed.Seed_id_name), isOpenSearch.open = false, isOpenSearch.close = true">
                                             {{ seed.Seed_id_name }}</p>
                                   </div>
                              </div>
                         </div>
                    </div>
                    <div class="scroll" style="">
                         <div class="row scrollStatisticalTable">
                              <div class="col-sm-12"><button @click="generateReport()" class="btn btnDowload">Tải
                                        xuống</button></div>
                              <div>
                                   <vue3html2pdf :show-layout="false" :float-layout="true" :enable-download="false"
                                        :preview-modal="true" :paginate-elements-by-height="1400"
                                        filename="nightprogrammerpdf" :pdf-quality="2" :manual-pagination="false"
                                        pdf-format="a4" :pdf-margin="10" pdf-orientation="portrait"
                                        pdf-content-width="1000px" ref="html2Pdf">
                                        <template v-slot:pdf-content>
                                             <riceCropReport :riceCropList="riceCropList" />
                                        </template>
                                   </vue3html2pdf>
                              </div>
                              <div class="col-sm-12 justify-content-center">
                                   <table class="table">
                                        <thead>
                                             <tr>
                                                  <th class="text-center" style=" padding-right: 2px;">STT</th>
                                                  <th class="text-center">Mã</th>
                                                  <th>Tên</th>
                                                  <th>Giống lúa</th>
                                                  <th>Vụ mùa</th>
                                                  <th>Mẫu ruộng</th>
                                                  <th>Ngày gieo xạ</th>
                                                  <th>Ngày thu hoạch</th>
                                                  <th>Năng suất</th>
                                             </tr>
                                        </thead>
                                        <tbody>
                                             <tr v-for="(riceCrop, i ) in riceCropList" :key="i">
                                                  <td class="text-center">{{ i + 1 }}</td>
                                                  <td class="text-center">{{ riceCrop.RiceCropInformation_id }}</td>
                                                  <td>{{ riceCrop.RiceCropInformation_name }}</td>
                                                  <td>{{ riceCrop.Seed_name }}</td>
                                                  <td>{{ riceCrop.Crop_name }}</td>
                                                  <td>{{ riceCrop.ArableLand_owner }}</td>
                                                  <td>{{ formatDate(riceCrop.RiceCropInformation_sowingDate) }}</td>
                                                  <td>{{ formatDate(riceCrop.RiceCropInformation_harvestDate) }}</td>
                                                  <td>{{ formatYield(riceCrop.RiceCropInformation_yield) }}</td>

                                             </tr>
                                        </tbody>
                                   </table>

                              </div>
                         </div>
                         <div style="width: 30%;">
                              <apexchart
                                   v-if="nameToSearch != '' && riceCropList.length >= 2 && chooseSatisticsBy == 'arableLand'"
                                   type="bar" width="100%" height="350" :options="chartForArableLand.chartOptions"
                                   :series="chartForArableLand.series">
                              </apexchart>
                         </div>
                    </div>

               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>
</template>

<script type="text/javascript">

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import RiceCropInformationService from '@/services/riceCropInformation.service';
import ArableLandService from '@/services/arableLand.service';
import CropService from '@/services/crop.service';
import SeedService from '@/services/seed.service';
import moment from 'moment';
import VueApexCharts from "vue3-apexcharts";
import vue3html2pdf from 'vue3-html2pdf'
import riceCropReport from '@/components/report/RiceCropReport.vue'
export default {
     name: "ArableLandManagement",
     components: {
          Catalog,
          TopHeader,
          apexchart: VueApexCharts,
          vue3html2pdf,
          riceCropReport,
     },



     data() {
          return {
               riceCropList: [],
               cloneRiceCropList: [],
               riceCropListByMonitoring: [],
               riceCropListByFinish: [],
               arableLandList: [],
               cropList: [],
               idToSearchByCrop: [],
               seedList: [],
               cloneSeedList: [],
               chooseSatisticsBy: "",
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
               nameToSearch: "",
               chartForArableLand: {
                    series: [{
                         name: 'Inflation',
                         data: []
                    }],
                    chartOptions: {
                         chart: {
                              height: 350,
                              type: 'bar',
                         },
                         plotOptions: {
                              bar: {
                                   borderRadius: 0,
                                   dataLabels: {
                                        position: 'top', // top, center, bottom
                                   },
                              }
                         },
                         dataLabels: {
                              enabled: true,
                              offsetY: -20,
                              style: {
                                   fontSize: '12px',
                                   colors: ["#304758"]
                              }
                         },

                         xaxis: {
                              categories: [],
                              position: 'bottom',
                              axisBorder: {
                                   show: false
                              },
                              axisTicks: {
                                   show: false
                              },
                              crosshairs: {
                                   fill: {
                                        type: 'gradient',
                                        gradient: {
                                             colorFrom: '#D8E3F0',
                                             colorTo: '#BED1E6',
                                             stops: [0, 100],
                                             opacityFrom: 0.4,
                                             opacityTo: 0.5,
                                        }
                                   }
                              },

                         },
                         title: {
                              text: 'Năng suất mùa vụ',
                              floating: true,
                              offsetY: 330,
                              align: 'center',
                              style: {
                                   color: '#444'
                              }
                         }
                    }
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

          generateReport() {
               this.$refs.html2Pdf.generatePdf()
          },

          filteredArableLandList() {
               return this.cloneArableLandList.filter(arableLand => {
                    return arableLand.id_owner.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },
          filteredSeedList() {
               return this.cloneSeedList.filter(seed => {
                    return seed.Seed_id_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
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
               const [err, respone] = await this.handle(
                    RiceCropInformationService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCropList = respone.data;
                    this.cloneRiceCropList = respone.data;
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
               }
          },

          async deleteRiceCropList() {
               this.riceCropList = [];
          },

          async retrieveCropList() {
               const [err, respone] = await this.handle(
                    CropService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.cropList = respone.data;
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
                    
                    this.cloneSeedList = respone.data;
                    this.cloneSeedList.forEach(element => {
                         element.Seed_id_name = String(element.Seed_id).concat(" - " + element.Seed_name)
                         this.seedList.push(element);
                    });
                    console.log(this.cloneSeedList)
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

                    this.cloneArableLandList = respone.data;
                    this.cloneArableLandList.forEach(element => {
                         element.id_owner = String(element.ArableLand_id).concat(" - " + element.ArableLand_owner);
                    });
               }
          },

          async searchByArableLand(data) {
               this.nameToSearch = data;
               var list = document.getElementsByClassName("arablename");
               Array.from(list).forEach(element => {
                    element.style.backgroundColor = '#FFFFFF'
               });
               document.getElementById(String(data).substring(0, String(data).indexOf('-') - 1)).style.backgroundColor = '#cbcccf';

               this.riceCropList = [];
               this.chartForArableLand.series[0].data = [];
               this.chartForArableLand.chartOptions.xaxis.categories = [];
               console.log(data)
               if (this.nameToSearch != '') {
                    this.cloneRiceCropList.forEach(element => {
                         var temp = String(element.ArableLand_id).concat(" - " + element.ArableLand_owner);
                         if (temp == data) {
                              this.riceCropList.push(element);
                              console.log(element)
                              this.chartForArableLand.series[0].data.push(element.RiceCropInformation_yield)
                              this.chartForArableLand.chartOptions.xaxis.categories.push(element.RiceCropInformation_name)
                              console.log(this.chartForArableLand)
                         }
                    });
                    if (this.riceCropList.length == 0) {
                         console.log('a')
                    }
               }
               console.log(this.riceCropList)
          },

          async searchByIDCrop() {
               this.riceCropList = [];
               this.cloneRiceCropList.forEach(element1 => {
                    this.idToSearchByCrop.forEach(element2 => {
                         if (element1.Crop_name == element2) {
                              this.riceCropList.push(element1);
                              console.log(element1)
                         }
                    });
               });
          },
          async searchBySeed(data) {
               this.nameToSearch = data;
               var list = document.getElementsByClassName("arablename");
               Array.from(list).forEach(element => {
                    element.style.backgroundColor = '#FFFFFF'
               });
               document.getElementById(data.substring(0, data.indexOf('-')-1)).style.backgroundColor = '#cbcccf';

               this.riceCropList = [];
               if (data != '') {
                    this.cloneRiceCropList.forEach(element1 => {
                         if (element1.Seed_id == String(data.substring(0, data.indexOf('-')-1))) {
                              this.riceCropList.push(element1);
                         }
                    });
               }
               else{
                    this.retrieveCropList();
               }

          },
          formatDate(data) {
               if (data != null)
                    return (moment(String(data)).format("DD-MM-YYYY")).slice(0, 10);
               return "...";
          },

          formatYield(data) {
               if (data != null) {
                    return data;
               }
               return "...";
          }
     },

     created() {
          this.retrieveRiceCropList();
          this.initEmployeeState();
     },

}
</script>

<style>
@import url(../../assets/statisticalStyle.css);
@import url(../../assets/mainStyle.css);

.statisticsByArabeLand {}

.arablelandScroll {
     max-height: 128px;
     overflow: auto;
     margin-top: 2px;
     word-wrap: none;
     width: 50%;
     margin-left: 0.5%;
}

.arablename {
     background-color: none;
     cursor: pointer;
     bottom: 0.1px;
     color: black;
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 500;
     font-size: 16px;
     padding: 0.1px;
     margin: 0.2px;
     width: 99%;
     background-color: #FFFFFF;
}

.arablename:hover {
     background: #cbcccf;
}
</style>