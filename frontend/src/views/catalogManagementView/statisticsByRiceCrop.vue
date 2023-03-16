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
                    <div class="row ml-4 pt-3 mb-5 pb-1 mr-2 topRight">
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
                    <div class="scroll" style="">
                         <div class="row mr-2 ml-2 statisticalBy" style="background-color: beige; height: 150px;">
                              <div class="leftStatistical">
                                   <label>Thống kê mùa vụ theo: </label>
                                   <select class="selection">
                                        <option> Tất cả</option>
                                        <option>Mẫu ruộng</option>
                                        <option>Vụ mùa</option>
                                        <option>Dịch bệnh</option>
                                        <option>Phân bón</option>
                                        <option>Giống lúa</option>
                                        <option>Thuốc điều trị bệnh dịch</option>
                                   </select>
                              </div>

                              <div class="rightStatistical">
                                   <div class="statisticsByArabeLand">
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
                                                  @click="searchByArableLand(arableLand.id_owner)">
                                                  {{ arableLand.id_owner }}</p>
                                        </div>
                                   </div>
                                   <div class="statisticsByCrop">
                                        <div v-for="crop in cropList" :key="crop.Crop_id">
                                             <input type="checkbox" :id="crop.Crop_id" :value="crop.Crop_name"
                                                  v-model="idToSearchByCrop" @change="searchByIDCrop()">
                                             <label for="vehicle1"> {{ crop.Crop_name }}</label><br>
                                        </div>
                                   </div>
                              </div>
                         </div>

                         <div class=" mt-3 row scrollStatisticalTable">
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
                              <apexchart v-if="nameToSearch!=''" type="bar" width="100%" height="350" :options="chartForArableLand.chartOptions" :series="chartForArableLand.series"></apexchart>
                         </div>
                    </div>
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import RiceCropInformationService from '@/services/riceCropInformation.service';
import ArableLandService from '@/services/arableLand.service';
import CropService from '@/services/crop.service';
import moment from 'moment';
import VueApexCharts from "vue3-apexcharts";

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
               cloneRiceCropList: [],
               riceCropListByMonitoring: [],
               riceCropListByFinish: [],
               arableLandList: [],
               cropList: [],
               idToSearchByCrop: [],
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
                                   borderRadius: 10,
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
                              text: 'Nangwsuat',
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

          filteredArableLandList() {
               return this.cloneArableLandList.filter(arableLand => {
                    return arableLand.id_owner.toLowerCase().includes(this.nameToSearch.toLowerCase())
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
          async retrieveCropList() {
               const [err, respone] = await this.handle(
                    CropService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.cropList = respone.data;
                    console.log(respone.data)
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
               this.riceCropList = [];
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
          },

          async searchByIDCrop() {
               console.log(this.cloneRiceCropList)
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
          this.retrieveArableLandList();
          this.retrieveCropList();
          this.initEmployeeState();
     },

}
</script>

<style>
@import url(../../assets/statisticalStyle.css);


@import url(../../assets/mainStyle.css);
</style>