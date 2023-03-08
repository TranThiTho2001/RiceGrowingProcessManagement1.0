<template>
     <div class="container-fluid riceCropManagement" style="background-color:  #EAEAEA;">
          <div class="row riceCropManagemenFrame">
               <div class="col-md-2 col-sm-12 leftRiceCropManagement">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>
               <div class="col-md-10 rightRiceCropManagement">
                    <div class="row ml-2 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="col-md-7" v-if="!isOpenSearch">
                              <h3 class="name">Theo dõi mùa vụ</h3>
                         </div>
                         <div class="col-md-3" v-if="isOpenSearch">
                              <h3 class="name">Theo dõi mùa vụ</h3>
                         </div>
                         <div class="col-md-3 text-right" v-if="!isOpenSearch">
                              <input type="text" class="form-control col-sm-8 inputSearch1" placeholder="Tìm"
                                    v-model="nameToSearch" @keyup.enter="searchName"
                                   @click="isOpenSearch = !isOpenSearch" />
                              <button class="btnSearch1" @click="searchName">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>
                         </div>
                         <div class="col-md-7 " v-if="isOpenSearch">
                              <input type="text" class="form-control inputSearch2" placeholder=""
                                   v-model="nameToSearch" @keyup.enter="searchName" />
                              <button class="btnSearch2" @click="searchName">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>
                         </div>

                         <div class="col-md-2 text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row ml-3  pt-4 pb-3 pr-3 ">
                         <div class="col-sm-10"></div>
                         <div class="col-sm-2 text-right">
                              <button class="btn btnCreate" @click="openCreate = !openCreate"><i class="fas fa-plus-circle"
                                        style="font-size: 15px;"></i> Thêm Mùa Vụ</button>
                         </div>
                    </div>
                    <div class=" row riceCropList ml-2 mr-2 text-left">
                         <carousel :settings="settings" :breakpoints="breakpoints" style="width:100%">
                              <slide v-for="(riceCrop, i) in riceCropListByMonitoring" :key="i">
                                   <RiceCropComponent :riceCrop="riceCrop"></RiceCropComponent>
                              </slide>
                              <template #addons>
                                   <navigation v-if="riceCropListByMonitoring.length > getWidth()" />
                                   <!-- <pagination style="color: #00BA13;" /> -->
                              </template>
                         </carousel>
                    </div>
                    <div class="row riceCropList pt-1 ml-2 mr-4 text-left">
                         <carousel :settings="settings" :breakpoints="breakpoints" style="width:100%">
                              <slide v-for="(riceCrop, i) in riceCropListByFinish" :key="i">
                                   <RiceCropComponent :riceCrop="riceCrop"></RiceCropComponent>

                              </slide>
                              <template #addons>
                                   <navigation v-if="riceCropListByFinish.length > getWidth" />
                                   <!-- <pagination v-if="riceCropListByFinish.length > 4" style="color: #00BA13;" /> -->
                              </template>
                         </carousel>
                    </div>

                    <div class="confirmationDialog" v-if="isOpenConfirm">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteRiceCrop(riceCropChoosen.RiceCropInformation_id)">Xóa</button>
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
                    <UpdateRiceCropForm v-if="isOpenUpdateRiceCrop" :seedList="seedList" :newRiceCrop="riceCropChoosen"
                         :arableLandList="arableLandList" @updateRiceCrop-submit="updateRiceCrop" :message1="message1"
                         :message2="message2" />
                    <CreateFertilizerTimesForm v-if="isOpenCreateFertilizerTimes" :newFertilizerTimes="newFertilizerTimes"
                         :fertilizerList="fertilizerList" :developmentStageList="developmentStageList"
                         :currentUser="currentUser" :riceCropChoosen="riceCropChoosen" :arableLandList="arableLandList"
                         @addFertilizerTimes-submit="createFertilizerTimes" :message1="message1" :message2="message2" />
                    <CreateSprayingTimesForm v-if="isOpenCreateSprayingTimes" :newSprayingTimes="newSprayingTimes"
                         :pesticideList="pesticideList" :developmentStageList="developmentStageList"
                         :currentUser="currentUser" :riceCropChoosen="riceCropChoosen" :arableLandList="arableLandList"
                         @addSprayingTimes-submit="createSprayingTimes" :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
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
import { Carousel, Slide, Navigation } from 'vue3-carousel';
// import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel';

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
          Carousel,
          Slide,
          Navigation,
     },

     data() {
          return {
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
               riceCropChoosen: {},
               isOpenUpdateRiceCrop: false,
               isOpenCreateFertilizerTimes: false,
               nameToSearch: "",
               message: "",
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               fullListRiceCrop: [],
               isOpenSearch: false,
               settings: {
                    itemsToShow: 1,
                    snapAlign: 'center',

               },
               breakpoints: {
                    500: {
                         itemsToShow: 2,
                         snapAlign: 'left',
                    },
                    800: {
                         itemsToShow: 3,
                         snapAlign: 'left',
                    },

                    // 700px and up
                    1000: {
                         itemsToShow: 4.5,
                         snapAlign: 'left',
                    },
                    1200: {
                         itemsToShow: 5,
                         snapAlign: 'left',
                    },
                    // 1024 and up
                    1400: {
                         itemsToShow: 5.5,
                         snapAlign: 'start',
                    },
                    1500: {
                         itemsToShow: 6,
                         snapAlign: 'start',
                    },
                    1600: {
                         itemsToShow: 8,
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
          getWidth() {
               var width = document.body.clientWidth;
               if (width > 500 && width < 800) {
                    return 2
               }
               else if (width >= 800 && width < 1000) {
                    return 3;
               }
               else if (width >= 100 && width < 1200) {
                    return 4.5;
               }
               else if (width >= 1200 && width < 1400) {
                    return 5;
               }
               else if (width >= 1400 & width < 1500) {
                    return 5.5;
               }
               else if (width >= 1500 && width < 1600) {
                    return 6;
               }
               else if (width >= 1600) {
                    return 8;
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
                    console.log(temp)
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
                         this.riceCropList[position].Images_link = require('@/images/' + "Rice1.png");
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
                    console.log(this.riceCropList)
                    console.log(this.riceCropListByFinish)
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

          async setRiceCropChoosen(data) {
               this.riceCropChoosen = data;
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

                    data.RiceCropInformation_id = this.riceCropChoosen.RiceCropInformation_id;
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

                    data.RiceCropInformation_id = this.riceCropChoosen.RiceCropInformation_id;
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

          async searchName() {
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
                              console.log(response.data);
                              this.riceCropList = response.data;
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
                         else {
                              console.log(response.data)
                         }

                    }
               }

          },


          formatDate(data) {
               return (moment(String(data)).format("YYYY-MM-DD")).slice(0, 10);
          },
          get_rows(list) {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return list.slice(start, end);

          },

          // So trang cua danh sach danh muc
          num_pages(list) {
               return Math.ceil(list.length / this.elementsPerPage);
          },

          async change_page(page, list) {
               if (page == '-' && this.currentPage > 1) {
                    this.currentPage -= 1;
                    this.get_rows(list);
               }
               else if (page == '+' && this.currentPage < this.num_pages(list)) {
                    this.currentPage += 1;
                    this.get_rows(list);
               }
               else {
                    this.currentPage = page;
                    this.get_rows(list);
               }
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

.carousel__prev,
.carousel__next {
     box-sizing: content-box;
     color: rgb(32, 97, 97);
     background-color: rgb(206, 202, 202);
     box-shadow: 4px;
}

.riceCropManagement {
     height: 100vmin;
}
</style>