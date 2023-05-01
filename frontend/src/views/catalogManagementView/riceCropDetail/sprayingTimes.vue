<template>
     <div class="container-fluid riceCropDetail">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row riceCropDetailFrame" style="height: max-content;" v-if="!loading" :class="{ active: active }">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>
               <div class="right rightRiceCropDetail" data-bs-spy="scroll">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Theo dõi mùa vụ</h3>
                         </div>
                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row row-inputSearch">
                         <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                              @click="retrievePesticideList(), isOpenInput1 = true"
                              @keyup.enter="searchName(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>

                         <div class="suggestion" :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="pesticide in filtered()" :key="pesticide.Pesticide_name"
                                   @click="searchName(pesticide.Pesticide_name), away()">
                                   {{ pesticide.Pesticide_name }}</p>
                         </div>
                         
                         <button class="btn btnCreate"
                              @click="isOpenCreateSprayingTimesForm = !isOpenCreateSprayingTimesForm, active = true">
                              <i class="fas fa-plus-circle" style="font-size: 15px;"></i> Thêm</button>
                    </div>
                    <div class="row mt-4 row-detail" style=" margin-left:20px;margin-right: 10px ">
                         <div class="detail-Component text-left" v-for="(sprayingtimes, i) in SprayingTimesList" :key="i">
                              <div class="btnMoreInfor"> <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                   </button>
                                   <div class="dropdown-menu">
                                        <a class="dropdown-item action"
                                             @click="setSprayingTimes(sprayingtimes), isOpenUpdateSprayingTimesForm = !isOpenUpdateSprayingTimesForm, active = true">
                                             <span class="fas fa-edit actionIcon"></span> Chỉnh
                                             sửa
                                        </a>
                                        <a class="dropdown-item" href="#"
                                             @click="setSprayingTimes(sprayingtimes), isOpenConfirm = !isOpenConfirm, active = true">
                                             <span class="fas fa-trash-alt actionIcon"></span>
                                             Xóa
                                        </a>

                                   </div>
                              </div>
                              <h5 class="function-name text-center">Lần {{ sprayingtimes.SprayingTimes_times }}</h5>
                              <span class="title-detail">Thuốc: 
                              <span class="value-name-detail">{{ sprayingtimes.Pesticide_name }}</span></span><br>
                              <span class="title-detail">Liều lượng: </span>
                              <span class="value-detail">{{ sprayingtimes.SprayingTimes_amount }} (ml/ha)</span><br>
                              <span class="title-detail">Từ ngày: </span>
                              <span class="value-detail">{{ formatDate(sprayingtimes.SprayingTimes_startDate) }}</span><br>
                              <span class="title-detail">Đến ngày: </span>
                              <span class="value-detail">{{ formatDate(sprayingtimes.SprayingTimes_endDate) }}</span><br>
                              <span class="title-detail">Nhân viên: </span>
                              <span class="value-detail">{{ sprayingtimes.Employee_name }}</span><br>
                         </div>


                    </div>


               </div>
          </div>
          <div class="overlay2" v-if="isOpenConfirm">
               <div class="confirmationDialog">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelConfirm">
                         <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                    </p>
                    <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                         @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteSprayingTimes()">Xóa</button>
                    <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenConfirm = !isOpenConfirm, active = false">Hủy</button>
               </div>
          </div>
          <div class="overlay2" v-if="isOpenMessage">
               <div class="messageDialog">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                         <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span>
                         {{
                              message
                         }}
                    </p>
                    <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenMessage = !isOpenMessage, active = false">OK</button>
               </div>
          </div>
          <div class="overlay2" v-if="isOpenCreateSprayingTimesForm">
               <CreateSprayingTimesForm :newSprayingTimes="newSprayingTimes" :pesticideList="pesticideList"
                    :developmentStageList="developmentStageList" :currentUser="currentUser" :riceCropChosen="newRiceCrop"
                    :arableLandList="arableLandList" @addSprayingTimes-submit="createNewSprayingTimes" :message1="message1"
                    :message2="message2" />
          </div>

          <div class="overlay2" v-if="isOpenUpdateSprayingTimesForm">
               <UpdateSprayingTimesForm :newSprayingTimes="sprayingTimesChosen" :pesticideList="pesticideList"
                    :developmentStageList="developmentStageList" :currentUser="currentUser" :riceCropChosen="newRiceCrop"
                    :arableLandList="arableLandList" @updateSprayingTimes-submit="updateSprayingTimes" :message1="message1"
                    :message2="message2" />
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script >

import moment from 'moment';
import 'vue3-carousel/dist/carousel.css'
import { mapGetters, mapMutations } from "vuex";
import SprayingTimesService from '@/services/sprayingTimes.service';
import RiceCropService from '@/services/riceCropInformation.service';
import PesticideService from '@/services/pesticide.service';
import DevelopmentStageService from '@/services/developmentStage.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import Catalog from '../../../components/catalogManagementComponents/catalog.vue';
import UpdateSprayingTimesForm from '@/components/catalogManagementComponents/updateSprayingTimesForm.vue';
import CreateSprayingTimesForm from '@/components/catalogManagementComponents/createNewSprayingTimesForm.vue';

export default {
     name: "sprayingTimes",

     props: ["id"],

     components: {
          Catalog,
          CreateSprayingTimesForm,
          UpdateSprayingTimesForm,
          TopHeader,
          Preloader,
     },

     data() {
          return {
               nameToSearch: "",
               newRiceCrop: {},
               employeeList: {},
               newSprayingTimes: {},
               SprayingTimesList: [],
               message1: "",
               message2: "",
               newImage: {},
               isOpenCreateSprayingTimesForm: false,
               isOpenUpdateSprayingTimesForm: false,
               sprayingTimesChosen: {},
               delete: "",
               isOpenConfirm: false,
               isOpenMessage: false,
               message: "",

               isOpenSearch: {
                    open: false,
                    close: true,
               },

               cloneSprayingTimesList: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               loading: true,
               developmentStageList: [],
               pesticideList: [],
          }
     },

     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },

     created() {
          this.newRiceCrop.RiceCropInformation_id = this.$route.params.id;
          this.initEmployeeState();
     },


     methods: {

          ...mapMutations([
               "initEmployeeState"
          ]),

          filtered() {
               return this.pesticideList.filter(pesticide => {
                    return pesticide.Pesticide_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          async loadData() {
               this.loading = true;
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
          },

          async retrieveDvelopmentStageList() {
               const [err, respone] = await this.handle(
                    DevelopmentStageService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.developmentStageList = respone.data;
               }
          },

          async retrieveSprayingTimesList() {
               const [err, respone] = await this.handle(
                    SprayingTimesService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần phun thuốc mới.") {
                         this.SprayingTimesList = respone.data;
                         this.cloneSprayingTimesList = respone.data;
                         this.newSprayingTimes.SprayingTimes_times = this.SprayingTimesList[this.SprayingTimesList.length - 1].SprayingTimes_times + 1;
                    }
                    else {
                         this.newSprayingTimes.SprayingTimes_times = 1;
                    }
                    var temp = {};
                    this.newSprayingTimes.Pesticide = [];
                    temp.Pesticide_name = "";
                    temp.Pesticide_amount = '0';
                    this.newSprayingTimes.Pesticide.push(temp);
               }
          },

          // SprayingTimes
          async setSprayingTimes(data) {
               this.sprayingTimesChosen = data;
          },

          async createNewSprayingTimes(data) {
               if (data.close == false) {
                    this.isOpenCreateSprayingTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
                    this.newSprayingTimes = {};
                    if (this.SprayingTimesList.length > 0) {
                         this.newSprayingTimes.SprayingTimes_times = this.SprayingTimesList[this.SprayingTimesList.length - 1].SprayingTimes_times + 1;

                    }
                    else {
                         this.newSprayingTimes.SprayingTimes_times = 1;
                    }
                    var temp = {};
                    this.newSprayingTimes.Pesticide = [];
                    temp.Pesticide_name = "";
                    temp.Pesticide_id = 0;
                    this.newSprayingTimes.Pesticide.push(temp);
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
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

                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
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
                    data.Pesticide.forEach(pesticide => {
                         if (pesticide.Pesticide_name != null) {
                              this.pesticideList.forEach(element => {
                                   if (element.Pesticide_name == pesticide.Pesticide_name) {
                                        pesticide.Pesticide_id = element.Pesticide_id;
                                   }
                              });
                              var newsprayingtimes = {};
                              newsprayingtimes = data;
                              newsprayingtimes.Pesticide_id = pesticide.Pesticide_id;
                              newsprayingtimes.SprayingTimes_amount = pesticide.Pesticide_amount;
                              this.createSprayingTimes(newsprayingtimes);
                         }
                    });
               }

          },

          async createSprayingTimes(data) {
               const [error, respone] = await this.handle(
                    SprayingTimesService.create(data)
               );
               if (error) {
                    console.log(error);
                    this.message1 = "Thêm không thành công.";
               } else if (respone.data == "Không thể tạo lần phun thuốc mới.") {
                    this.message1 = "Thêm không thành công.";
               } else {
                    this.message2 = "Thêm thành công.";
                    this.retrieveSprayingTimesList();
               }
          },

          async updateSprayingTimes(data) {
               if (data.close == false) {
                    this.isOpenUpdateSprayingTimesForm = false;
                    this.isOpenTable = true;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
                    this.newSprayingTimes = {};
                    this.newSprayingTimes.SprayingTimes_times = this.SprayingTimesList[this.SprayingTimesList.length - 1].SprayingTimes_times + 1;

               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
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

                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
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
                         SprayingTimesService.update(this.newRiceCrop.RiceCropInformation_id, data.Pesticide_id, data.SprayingTimes_times, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";

                    }

               }
               this.retrieveSprayingTimesList();

          },

          async deleteSprayingTimes() {
               const [error, respone] = await this.handle(
                    SprayingTimesService.delete(this.newRiceCrop.RiceCropInformation_id, this.sprayingTimesChosen.Pesticide_id, this.sprayingTimesChosen.SprayingTimes_times)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa lần phun thuốc không thành công."
               } else if (respone.data == "Lỗi trong quá trình xóa lần phun thuốc!!") {
                    this.message = "Xóa lần phun thuốc không thành công."
               } else {
                    this.message = "Xóa lần phun thuốc thành công.";
                    this.retrieveSprayingTimesList();
               }
               this.delete = "";
          },

          goToRiceCrop() {
               this.$router.push({ name: 'RiceCropDetail', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },

          async retrieveNewRiceCrop() {
               const [err, respone] = await this.handle(
                    RiceCropService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {

                    this.newRiceCrop.RiceCropInformation_id = respone.data.RiceCropInformation_id;
                    this.newRiceCrop.RiceCropInformation_name = respone.data.RiceCropInformation_name;
                    this.newRiceCrop.Seed_id = respone.data.Seed_id;
                    this.newRiceCrop.Seed_name = respone.data.Seed_name;
                    this.newRiceCrop.RiceCropInformation_sowingDate = respone.data.RiceCropInformation_sowingDate;
                    this.newRiceCrop.RiceCropInformation_harvestDate = (moment(String(respone.data.RiceCropInformation_harvestDate)).format("YYYY-MM-DD")).slice(0, 10);
                    this.newRiceCrop.RiceCropInformation_yield = respone.data.RiceCropInformation_yield;
                    this.newRiceCrop.Crop_id = respone.data.Crop_id;
                    this.newRiceCrop.Crop_name = respone.data.Crop_name;
                    this.newRiceCrop.ArableLand_id = respone.data.ArableLand_id;
                    this.newRiceCrop.ArableLand_location = respone.data.ArableLand_location;
                    this.newRiceCrop.ArableLand_owner = respone.data.ArableLand_owner;
                    this.newRiceCrop.ArableLand_latitude = respone.data.ArableLand_latitude;
                    this.newRiceCrop.ArableLand_longitude = respone.data.ArableLand_longitude;
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

          async searchName(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != "") {
                    this.SprayingTimesList = [];
                    this.cloneSprayingTimesList.forEach(element => {
                         if (element.Pesticide_name == data) {
                              this.SprayingTimesList.push(element);
                         }
                    });
                    if (this.SprayingTimesList.length == 0) {
                         const [err, respone] = await this.handle(
                              SprayingTimesService.getByName(this.nameToSearch, this.newRiceCrop.RiceCropInformation_id)
                         );
                         if (err) {
                              console.log(err)
                         }
                         else {
                              if (respone.data != "Không tìm thấy lần phun thuốc mới.") {
                                   this.SprayingTimesList = respone.data;
                              }
                              else this.SprayingTimesList = [];
                         }
                    }
               }
               else{
                    this.retrieveSprayingTimesList();
               }
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY")).slice(0, 10);
          },
     },

     mounted() {
          this.initEmployeeState();
          this.retrieveDvelopmentStageList();
          this.retrievePesticideList();
          this.retrieveSprayingTimesList();
          this.retrieveNewRiceCrop();
          this.loadData();
     }
};
</script>

<style>
@import url(../../../assets/mainStyle.css);
@import url(../../../assets/riceCropDetailStyle.css);

.btnAddimage {
     background-color: rgb(241, 248, 164);
     border-radius: 5px;
}
</style>


<!-- <nav aria-label="...">
     <ul class="pagination " aria-controls="my-table">
          <li class="page-item disabled" v-if="currentPage == 1">
               <a class="page-link" href="#" aria-controls="my-table">{{ previous }}</a>
          </li>
          <li class="page-item " v-if="currentPage > 1">
               <a class="page-link" href="#"
                    @click="change_page('-', fertilizerTimesList)"
                    aria-controls="my-table">{{
                         previous }}</a>
          </li>
          <li class="page-item"><a class="page-link" href="#"
                    @click="change_page(currentPage - 1, monitorList)"
                    v-if="currentPage > 1">{{
                         currentPage - 1 }}</a></li>
          <li class="page-item active">
               <a class="page-link"
                    style="background-color: #EEEA41; border-color: #EEEA41;" href="#">{{
                         currentPage }} <span class="sr-only">(current)</span></a>
          </li>
          <li class="page-item"><a class="page-link" href="#"
                    v-if="currentPage < num_pages(fertilizerTimesList)"
                    @click="change_page(currentPage + 1, fertilizerTimesList)">{{
                         currentPage + 1
                    }}</a></li>
          <li class="page-item">
               <a class="page-link" href="#"
                    @click="change_page('+', fertilizerTimesList)"
                    v-if="currentPage < num_pages(fertilizerTimesList)">{{
                         next }}</a>
          </li>
          <li class="page-item disabled">
               <a class="page-link" href="#"
                    v-if="currentPage >= num_pages(fertilizerTimesList)">{{
                         next }}</a>
          </li>
     </ul>
</nav> -->