<template>
     <div class="container-fluid riceCropManagement" style="background-color:  #EAEAEA; height: max-content;">
          <div class="row riceCropManagemenFrame" style="height: max-content;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2" 
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div  class="left" :class=" {navbarresponsive: openMenu.openMenu }" >
                         <Catalog />
               </div>
               <div class="right rightRiceCropManagement" :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{name2: isOpenInput2}"  style="font">Theo dõi mùa vụ</h3>
                         </div>
     
                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row row-inputSearch">
                         <div class="col-sm-10">
                              <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                                   @click="retrieveRiceCropList, isOpenInput1 = true" @keyup.enter="searchName(nameToSearch), away()"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>
                              
                              <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                   <p class="item" v-for="riceCrop in filteredList()"
                                        :key="riceCrop.RiceCropInformation_name"
                                        @click="searchName(riceCrop.RiceCropInformation_name), away()">
                                        {{ riceCrop.RiceCropInformation_name }}</p>
                              </div>
                         </div>
                         <div class="col-sm-2 text-right">
                              <button class="btn btnCreate" @click="openCreate = !openCreate"><i class="fas fa-plus-circle"
                                        style="font-size: 15px;"></i> Thêm Mùa Vụ</button>
                         </div>
                    </div>
                    <!-- <div class=" row riceCropList ml-4 mr-4 pr-2 mt-1 text-left" v-if="riceCropListByMonitoring.length > 0"> -->
                         <!-- <carousel v-if="riceCropListByMonitoring.length > getWidth()" :settings="settings"
                              :breakpoints="breakpoints" style="width:100%" :autoplay="2000" :wrap-around="true">
                              <slide v-for="(riceCrop, i) in riceCropListByMonitoring" :key="i">
                                   <div class="carousel__item">
                                        <RiceCropComponent :riceCrop="riceCrop"></RiceCropComponent>
                                   </div>
                              </slide>
                              <template #addons>
                                   <navigation  />
                              </template>
                         </carousel>
                         <carousel v-if="riceCropListByMonitoring.length <= getWidth()" :settings="settings"
                              :breakpoints="breakpoints" style="width:100%">
                              <slide v-for="(riceCrop, i) in riceCropListByMonitoring" :key="i">
                                   <div class="carousel__item">
                                        <RiceCropComponent :riceCrop="riceCrop"></RiceCropComponent>
                                   </div>
                              </slide>
                              <template #addons>
                                   <navigation v-if="riceCropListByMonitoring.length > getWidth()" /> 
                              </template>
                         </carousel> -->
                    <!-- </div> -->
                    <div class="row riceCropList mt-3" style="max-height: 98%; width: 98%;">
                         <div class="col-lg-3 col-md-4 col-sm-6 text-center" v-for="(riceCrop, i) in riceCropList" :key="i" style=" margin-left: 0px !important; margin-right: 0px !important; margin-bottom: 5px;">
                              <RiceCropComponent :riceCrop="riceCrop"></RiceCropComponent>
                         </div>
                         <!-- <carousel v-if="riceCropListByFinish.length > getWidth" :settings="settings"
                              :breakpoints="breakpoints" style="width:100%" :autoplay="2000" :wrap-around="true">
                              <div class="carousel__item">
                              <slide v-for="(riceCrop, i) in riceCropListByFinish" :key="i">
                                   <RiceCropComponent :riceCrop="riceCrop"></RiceCropComponent>

                              </slide></div>
                              <template #addons>
                                   <navigation v-if="riceCropListByFinish.length > getWidth" />
                              </template>
                         </carousel>
                         <carousel v-else :settings="settings" :breakpoints="breakpoints" style="width:100%">
                              <slide v-for="(riceCrop, i) in riceCropListByFinish" :key="i">
                                   <RiceCropComponent :riceCrop="riceCrop"></RiceCropComponent>

                              </slide>
                              <template #addons>
                                   <navigation v-if="riceCropListByFinish.length > getWidth" />
                              </template>
                         </carousel> -->
                    </div>

                    <div class="confirmationDialog" v-if="isOpenConfirm">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteRiceCrop(riceCropChosen.RiceCropInformation_id)">Xóa</button>
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

                    <CreateRiceCropForm v-if="openCreate" :newRiceCrop="newRiceCrop" :seedList="seedList"
                         :arableLandList="arableLandList" @addRiceCrop-submit="createRiceCrop" :message1="message1"
                         :message2="message2" />
                    <UpdateRiceCropForm v-if="isOpenUpdateRiceCrop" :seedList="seedList" :newRiceCrop="riceCropChosen"
                         :arableLandList="arableLandList" @updateRiceCrop-submit="updateRiceCrop" :message1="message1"
                         :message2="message2" />
                    <CreateFertilizerTimesForm v-if="isOpenCreateFertilizerTimes" :newFertilizerTimes="newFertilizerTimes"
                         :fertilizerList="fertilizerList" :developmentStageList="developmentStageList"
                         :currentUser="currentUser" :riceCropChosen="riceCropChosen" :arableLandList="arableLandList"
                         @addFertilizerTimes-submit="createFertilizerTimes" :message1="message1" :message2="message2" />
                    <CreateSprayingTimesForm v-if="isOpenCreateSprayingTimes" :newSprayingTimes="newSprayingTimes"
                         :pesticideList="pesticideList" :developmentStageList="developmentStageList"
                         :currentUser="currentUser" :riceCropChosen="riceCropChosen" :arableLandList="arableLandList"
                         @addSprayingTimes-submit="createSprayingTimes" :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click="away()"></div>
</template>

<script type=”text/javascript”>
import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import CropService from '@/services/crop.service';
import SeedService from '@/services/seed.service';
import ArableLandService from '@/services/arableLand.service';
import RiceCropService from '@/services/riceCropInformation.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import CreateRiceCropForm from '@/components/catalogManagementComponents/createNewRiceCropForm.vue';
import UpdateRiceCropForm from '@/components/catalogManagementComponents/updateRiceCropForm.vue';
import fertilizerService from '@/services/fertilizer.service';
import MonitorService from '@/services/monitor.service';
import developmentStageService from '@/services/developmentStage.service';
import CreateFertilizerTimesForm from '@/components/catalogManagementComponents/createNewFertilizerTimesForm.vue';
import fertilizerTimesService from '@/services/fertilizerTimes.service';
import PesticideService from '@/services/pesticide.service';
import SprayingTimesService from '@/services/sprayingTimes.service';
import CreateSprayingTimesForm from '@/components/catalogManagementComponents/createNewSprayingTimesForm.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import RiceCropComponent from '@/components/catalogManagementComponents/riceCropComponent.vue';
import ImagesService from '@/services/images.service';
import 'vue3-carousel/dist/carousel.css'
// import { Carousel, Slide, Navigation } from 'vue3-carousel';
// import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel';

class RiceCrop {
     constructor(riceCrop) {
          this.RiceCropInformation_id = riceCrop.RiceCropInformation_id
          this.RiceCropInformation_name = riceCrop.RiceCropInformation_name;
     }
}
export default {
     name: "HomePage",
     components: {
          Catalog,
          CreateRiceCropForm,
          UpdateRiceCropForm,
          CreateFertilizerTimesForm,
          CreateSprayingTimesForm,
          TopHeader,
          RiceCropComponent,
          // Carousel,
          // Slide,
          // Navigation,
     },

     data() {
          return {
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },

               active: {
                    rightActive: false,
                    leftnNoneActive: false,
               },

               number: 0,
               riceCropList: [],
               cropList: [],
               seedList: [],
               arableLandList: [],
               fertilizerList: [],
               developmentStageList: [],
               pesticideList: [],
               riceCropListByMonitoring: [],
               riceCropListByFinish: [],
               openCreate: false,
               newSprayingTimes: {},
               newRiceCrop: {},
               newFertilizerTimes: {},
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               isOpenCreateSprayingTimes: false,
               riceCropChosen: {},
               isOpenUpdateRiceCrop: false,
               isOpenCreateFertilizerTimes: false,
               nameToSearch: "",
               message: "",
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               fullListRiceCrop: [],
               settings: {
                    itemsToShow: 1,
                    snapAlign: 'center',

               },
               isOpenInput2: false,
               isOpenInput1: true,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               cloneRiceCropList: [],
               breakpoints: {
                    300: {
                         itemsToShow: 1.5,
                         snapAlign: 'start',
                    },
                    450: {
                         itemsToShow: 2,
                         snapAlign: 'start',
                    },
                    600: {
                         itemsToShow: 2.5,
                         snapAlign: 'start',
                    },
                    800: {
                         itemsToShow: 3,
                         snapAlign: 'start',
                    },
                    900: {
                         itemsToShow: 3.5,
                         snapAlign: 'start',
                    },
                    // 700px and up
                    1000: {
                         itemsToShow: 4,
                         snapAlign: 'start',
                    },
                    1200: {
                         itemsToShow: 4.5,
                         snapAlign: 'start',
                    },
                    // 1024 and up
                    1400: {
                         itemsToShow: 5,
                         snapAlign: 'start',
                    },
                    1500: {
                         itemsToShow: 5.5,
                         snapAlign: 'start',
                    },
                    1600: {
                         itemsToShow: 7.5,
                         snapAlign: 'start',
                    },

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
               return this.cloneRiceCropList.filter(riceCrop => {
                    return riceCrop.RiceCropInformation_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput2 = false;
               console.log(this.isOpenInput2)
               this.isOpenInput1 = false;
          },

          getWidth() {
               var width = document.body.clientWidth;
               if (width > 300 && width < 450) {
                    return 1.5
               }
               else if (width >= 450 && width < 600) {
                    return 2
               }
               else if (width >= 600 && width < 800) {
                    return 2.5
               }
               else if (width >= 800 && width < 900) {
                    return 3;
               }
               else if (width >= 900 && width < 1000) {
                    return 3.5;
               }
               else if (width >= 1000 && width < 1200) {
                    return 4;
               }
               else if (width >= 1200 & width < 1400) {
                    return 4.5;
               }
               else if (width >= 1400 && width < 1500) {
                    return 5;
               }
               else if (width >= 1500) {
                    return 5.5;
               }
          },

          async retrieveFullRiceCropList() {
               const [err, respone] = await this.handle(
                    RiceCropService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {

                    this.fullListRiceCrop = respone.data;
                    var temp = (String(this.fullListRiceCrop[this.fullListRiceCrop.length - 1].RiceCropInformation_id)).split("");
                    console.log("jhj"+temp)
                    var id = "";
                    for (let index = 0; index < temp.length; index++) {
                         const element = temp[index];
                         if (element != "R" && element != "C" && element != "I" & element != "0") {
                              for (let i = index; i < temp.length; i++) {
                                   id = id.concat(temp[i]);
                              }
                              break;
                         }
                    }
                    console.log(id);

                    if (id < 9) {
                         this.newRiceCrop.RiceCropInformation_id = "RCI000000" + String(Number(id) + 1);
                    }
                    else if (id > 8 && id < 99) {
                         this.newRiceCrop.RiceCropInformation_id = "RCI00000" + String(Number(id) + 1);
                    }
                    else if (id > 98 && id < 999) {
                         this.newRiceCrop.RiceCropInformation_id = "RCI0000" + String(Number(id) + 1);
                    }
                    else {
                         this.newRiceCrop.RiceCropInformation_id = "RCI00" + String(Number(id) + 1);
                    }

               }
          },

          async getURL(position) {
               const [err, response] = await this.handle(
                    ImagesService.findByName(this.riceCropList[position].RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    const temp = response.data;
                    console.log(temp)
                    if (temp.length > 0) {

                         this.riceCropList[position].Images_link = require('@/images/' + temp[temp.length - 1].Image_link);
                         console.log(this.urlImage);
                    }
                    else {
                         this.riceCropList[position].Images_link = require('@/images/' + "Rice14.jpg");
                    }
               }
          },

          async retrieveRiceCropList() {
               const [err, respone] = await this.handle(
                    MonitorService.findByName(this.currentUser.Employee_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCropList = respone.data;
                    this.cloneRiceCropList = respone.data;
                    this.cloneRiceCropList.forEach(element => {
                         new RiceCrop(element);
                    });
                    this.riceCropListByFinish = [];
                    this.riceCropListByMonitoring = [];
                    var i = 0;
                    this.riceCropList.forEach(element => {
                         this.getURL(i);
                         if (element.RiceCropInformation_harvestDate == null) {
                              this.riceCropListByMonitoring.push(element);
                         }
                         else {
                              this.riceCropListByFinish.push(element);
                         }
                         i++;
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
                    console.log(respone.data);
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
                    console.log(respone.data);
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
                    console.log(respone.data);
               }
          },

          async retrieveFertilizerList() {
               const [err, respone] = await this.handle(
                    fertilizerService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.fertilizerList = respone.data;
                    console.log(respone.data);
               }
          },

          async retrieveDvelopmentStageList() {
               const [err, respone] = await this.handle(
                    developmentStageService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.developmentStageList = respone.data;
                    console.log(respone.data);
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
                    console.log(respone.data);
               }
          },

          async setRiceCropChosen(data) {
               this.riceCropChosen = data;
               this.seedList.forEach(element => {
                    if (data.Seed_id == element.Seed_id) {
                         data.Seed_id = element.Seed_name;
                    }
               });

               this.cropList.forEach(element => {
                    if (data.Crop_id == element.Crop_id) {
                         data.Crop_id = element.Crop_name;
                    }
               });
          },

          async createRiceCrop(data) {
               this.retrieveFullRiceCropList();
               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newRiceCrop = {};
                    this.retrieveRiceCropList();
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    this.seedList.forEach(element => {
                         if (data.Seed_id == element.Seed_name) {
                              data.Seed_id = element.Seed_id;
                         }
                    });

                    this.cropList.forEach(element => {
                         if (data.Crop_id == element.Crop_name) {
                              data.Crop_id = element.Crop_id;
                         }
                    });


                    if (data.RiceCropInformation_sowingDate != null) {
                         data.RiceCropInformation_sowingDate = (moment(String(data.RiceCropInformation_sowingDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.RiceCropInformation_sowingDate = null;
                    }
                    if (data.RiceCropInformation_harvestDate != null) {
                         data.RiceCropInformation_harvestDate = (moment(String(data.RiceCropInformation_harvestDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.RiceCropInformation_harvestDate = null;
                    }
                    var check = true;
                    this.riceCropList.forEach(element => {
                         if (element.ArableLand_id == data.ArableLand_id) {
                              if (element.RiceCropInformation_harvestDate == null) {
                                   check = false;
                                   console.log("alo" + check);
                              }
                         }
                    });
                    if (check == true) {
                         const [error, respone] = await this.handle(
                              RiceCropService.create(data)
                         );
                         if (error) {
                              console.log(error);
                              this.message1 = "Thêm không thành công."
                         } else if (respone.data == "Không thể tạo vụ mùa lúa mới.") {
                              this.message1 = "Thêm không thành công."
                         } else {
                              this.message2 = "Thêm thành công.";
                              const monitor = {};
                              monitor.Employee_id = this.currentUser.Employee_id;
                              monitor.RiceCropInformation_id = data.RiceCropInformation_id;
                              const [error, respone] = await this.handle(
                                   MonitorService.create(monitor)
                              );
                              if (error) {
                                   console.log(error);
                                   this.message1 = "Thêm không thành công."
                              } else if (respone.data == "Cập nhật thể tạo vụ mùa lúa mới.") {
                                   this.message1 = "Thêm không thành công."
                              } else {
                                   this.message2 = "Thêm thành công.";
                                   this.retrieveRiceCropList();
                                   this.retrieveFullRiceCropList();
                              }
                              this.retrieveRiceCropList();
                              this.retrieveFullRiceCropList();
                         }
                    }
                    else {
                         this.message1 = "Thêm không thành công.";
                    }

               }
          },

          async updateRiceCrop(data) {
               this.retrieveFullRiceCropList();
               if (data.close == false) {
                    this.isOpenUpdateRiceCrop = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newRiceCrop = {};
                    this.retrieveRiceCropList();
                    if (data.openFertilizerTime == true) {
                         this.isOpenCreateFertilizerTimes = true;
                    }
                    if (data.isOpenCreateSprayingTimes == true) {
                         this.isOpenCreateSprayingTimes = true;
                    }
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    this.seedList.forEach(element => {
                         if (data.Seed_id == element.Seed_name) {
                              data.Seed_id = element.Seed_id;
                         }
                    });

                    this.cropList.forEach(element => {
                         if (data.Crop_id == element.Crop_name) {
                              data.Crop_id = element.Crop_id;
                         }
                    });


                    if (data.RiceCropInformation_sowingDate != null) {
                         data.RiceCropInformation_sowingDate = (moment(String(data.RiceCropInformation_sowingDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.RiceCropInformation_sowingDate = null;
                    }
                    if (data.RiceCropInformation_harvestDate != null) {
                         data.RiceCropInformation_harvestDate = (moment(String(data.RiceCropInformation_harvestDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.RiceCropInformation_harvestDate = null;
                    }
                    var check = true;
                    this.riceCropList.forEach(element => {
                         if (element.ArableLand_id == data.ArableLand_id) {
                              if (element.RiceCropInformation_harvestDate == null) {
                                   check = false;
                              }
                         }
                    });
                    if (check == true) {
                         const [error, respone] = await this.handle(
                              RiceCropService.update(data.RiceCropInformation_id, data)
                         );
                         if (error) {
                              console.log(error);
                              this.message1 = "Cập nhật không thành công."
                         } else if (respone.data == "Cập nhật thể tạo vụ mùa lúa mới.") {
                              this.message1 = "Cập nhật không thành công."
                         } else {
                              this.message2 = "Cập nhật thành công.";
                              this.retrieveRiceCropList();
                              this.retrieveFullRiceCropList();
                         }
                    }
                    else {
                         this.message1 = "Cập nhật không thành công.";
                    }

               }
          },

          async deleteRiceCrop(data) {
               const [error, response] = await this.handle(
                    RiceCropService.delete(data)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrieveFullRiceCropList();
                    this.retrieveRiceCropList();
                    console.log(response.data);
                    this.message = "Xóa phân bón thành công"

               }
          },


          async createFertilizerTimes(data) {
               this.retrieveFullRiceCropList();
               if (data.close == false) {
                    this.isOpenCreateFertilizerTimes = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newFertilizerTimes = {};
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    // console.log("development "+data.DevelopmentStage_id);
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.fertilizerList.forEach(element => {
                         if (element.Fertilizer_name == data.Fertilizer_name) {
                              data.Fertilizer_id = element.Fertilizer_id;
                         }
                    });

                    data.RiceCropInformation_id = this.riceCropChosen.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;


                    if (data.FertilizerTimes_startDate != null) {
                         data.FertilizerTimes_startDate = (moment(String(data.FertilizerTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.FertilizerTimes_startDate = null;
                    }
                    if (data.FertilizerTimes_endDate != null) {
                         data.FertilizerTimes_endDate = (moment(String(data.FertilizerTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.FertilizerTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         fertilizerTimesService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo lần bón phân mới.") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveRiceCropList();
                    }

               }

          },

          async createSprayingTimes(data) {
               this.retrieveFullRiceCropList();
               if (data.close == false) {
                    this.isOpenCreateSprayingTimes = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newSrpayingTimes = {};
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    // console.log("development "+data.DevelopmentStage_id);
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.pesticideList.forEach(element => {
                         if (element.Pesticide_name == data.Pesticide_name) {
                              data.Pesticide_id = element.Pesticide_id;
                         }
                    });

                    data.RiceCropInformation_id = this.riceCropChosen.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;


                    if (data.SprayingTimes_startDate != null) {
                         data.SprayingTimes_startDate = (moment(String(data.SprayingTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.SprayingTimes_startDate = null;
                    }
                    if (data.SprayingTimes_endDate != null) {
                         data.SprayingTimes_endDate = (moment(String(data.SprayingTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.SprayingTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         SprayingTimesService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo lần phun thuuốc mới.") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveRiceCropList();
                    }

               }

          },

          async searchName(data) {
               this.nameToSearch = data;
               
               if (this.nameToSearch == "") {
                    this.retrieveRiceCropList();
               }
               else {
                    const [error, response] = await this.handle(
                         RiceCropService.findByEmployeeAndRiceCropName(this.nameToSearch, this.currentUser.Employee_id)
                    );
                    if (error) {
                         console.log(error);
                    } else {
                         if (response.data != null) {
                              this.riceCropList = [];
                              this.riceCropList = response.data;
                              this.riceCropListByFinish = [];
                              this.riceCropListByMonitoring = [];
                              var i = 0;
                              this.riceCropList.forEach(element => {
                                   this.getURL(i);
                                   if (element.RiceCropInformation_harvestDate == null) {
                                        this.riceCropListByMonitoring.push(element);
                                   }
                                   else {
                                        this.riceCropListByFinish.push(element);
                                   }
                                   i++;
                              });
                         }
                         else {
                              console.log(response.data)
                         }

                    }
               }

          },

          getResponsive(){
               var width = document.body.clientWidth;
               return width;
          },

          formatDate(data) {
               return (moment(String(data)).format("YYYY-MM-DD")).slice(0, 10);
          },

     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveRiceCropList();
          this.retrieveCropList();
          this.retrieveSeedList();
          this.retrieveArableLandList();
          this.retrieveDvelopmentStageList();
          this.retrieveFertilizerList();
          this.retrieveFullRiceCropList();
          this.retrievePesticideList();
          this.newFertilizerTimes.Employee_id = this.currentUser.Employee_id;
     }
}


</script>

<style>
@import url(../../assets/riceCropStyle.css);
@import url(../../assets/mainStyle.css);

.carousel__prev,
.carousel__next {
     box-sizing: content-box;
     color: rgb(32, 97, 97);
     background-color: rgb(206, 202, 202);
     box-shadow: 4px;
}

.riceCropManagement {
     height: 100vmin;
}</style>