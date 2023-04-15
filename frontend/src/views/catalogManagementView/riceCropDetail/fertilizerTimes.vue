<template>
     <div class="container-fluid riceCropDetail">
          <div class="row riceCropDetailFrame" style="height: max-content;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
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

                    <div class="row" style="margin-top: 130px; margin-left:20px; margin-right:0px">

                         <button class="btn btnCome-back" @click="goToRiceCrop()">Trở về</button>
                         <button class="btn btnCreate"
                              @click="isOpenCreateFertilizerTimesForm = !isOpenCreateFertilizerTimesForm">Thêm</button>
                    </div>
                    <div class="row mt-4 function-row" style=" margin-left:20px;margin-right: 10px ">
                         <div class="detail-Component text-center" v-for="(fertilizertimes, i) in fertilizerTimesList"
                              :key="i">
                              <div class="btnMoreInfor"> <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                   </button>
                                   <div class="dropdown-menu">
                                        <a class="dropdown-item action"
                                             @click="setFertilizerChosen(fertilizertimes), isOpenUpdateFertilizerTimesForm = !isOpenUpdateFertilizerTimesForm, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">
                                             <span class="fas fa-edit actionIcon"></span> Chỉnh
                                             sửa
                                        </a>
                                        <a class="dropdown-item" href="#"
                                             @click="setFertilizerChosen(fertilizertimes), setDelete('FertilizerTimes'), isOpenConfirm = !isOpenConfirm">
                                             <span class="fas fa-trash-alt actionIcon"></span>
                                             Xóa
                                        </a>

                                   </div>
                              </div>
                              <h5 class="nameComponent text-center">Lần {{ fertilizertimes.FertilizerTimes_times }}</h5>
                              <span>Phân: </span><span>{{ fertilizertimes.Fertilizer_name }}</span><br>
                              <span>Số lượng: </span><span>{{ fertilizertimes.FertilizerTimes_amount }} (kg/ha)</span><br>
                              <span>Bón ngày: </span><span>{{ formatDate(fertilizertimes.FertilizerTimes_startDate)
                              }}</span><br>
                              <span>Đến ngày: </span><span>{{ formatDate(fertilizertimes.FertilizerTimes_endDate)
                              }}</span><br>
                              <span>Nhân viên: </span><span>{{ fertilizertimes.Employee_name }}</span><br>
                         </div>


                    </div>

                    <div class="confirmationDialog" v-if="isOpenConfirm">
                                   <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                                        class="labelConfirm">
                                        <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                                   </p>
                                   <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                                        @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, choosenDelete()">Xóa</button>
                                   <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                                        @click="isOpenConfirm = !isOpenConfirm">Hủy</button>
                              </div>

                              <div class="messageDialog" v-if="isOpenMessage">
                                   <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                                        class="labelThongBao">
                                        <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span>
                                        {{
                                             message
                                        }}
                                   </p>
                                   <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                                        @click="isOpenMessage = !isOpenMessage">OK</button>
                              </div>

                    <CreateFertilizerTimesForm v-if="isOpenCreateFertilizerTimesForm" :weather="weatherInfor"
                         :newFertilizerTimes="newFertilizerTimes" :fertilizerList="fertilizerList"
                         :developmentStageList="developmentStageList" :currentUser="currentUser"
                         :riceCropChosen="newRiceCrop" :arableLandList="arableLandList"
                         @addFertilizerTimes-submit="createFertilizerTimes" :message1="message1" :message2="message2" />
                    <UpdateFertilizerTimesForm v-if="isOpenUpdateFertilizerTimesForm"
                         :newFertilizerTimes="fertilizerTimesChosen" :fertilizerList="fertilizerList"
                         :developmentStageList="developmentStageList" :currentUser="currentUser"
                         :riceCropChosen="newRiceCrop" :arableLandList="arableLandList"
                         @updateFertilizerTimes-submit="updateFertilizerTimes" :message1="message1" :message2="message2" />
               </div>

          </div>
     </div>

</template>

<script >

import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import RiceCropService from '@/services/riceCropInformation.service';
import Catalog from '../../../components/catalogManagementComponents/catalog.vue';
import CreateFertilizerTimesForm from '@/components/catalogManagementComponents/createNewFertilizerTimesForm.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import FertilizerTimesService from '@/services/fertilizerTimes.service';
import UpdateFertilizerTimesForm from '@/components/catalogManagementComponents/updateFertilizerTimesForm.vue';
import 'vue3-carousel/dist/carousel.css'

export default {
     name: "fertilizerTimes",

     props: ["id"],

     components: {
          Catalog,
          CreateFertilizerTimesForm,
          UpdateFertilizerTimesForm,
          TopHeader,
     },

     data() {
          return {
               nameToSearch: "",
               newRiceCrop: {},
               newFertilizerTimes: {},
               fertilizerTimesList: [],
               message1: "",
               message2: "",
               isOpenCreateFertilizerTimesForm: false,
               isOpenUpdateFertilizerTimesForm: false,
               delete: "",
               isOpenConfirm: false,
               isOpenMessage: false,
               message: "",

               isOpenSearch: {
                    open: false,
                    close: true,
               },

               cloneFertilizerTimesList: [],
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

     created() {
          this.newRiceCrop.RiceCropInformation_id = this.$route.params.id;
          this.initEmployeeState();
     },


     methods: {

          ...mapMutations([
               "initEmployeeState"
          ]),

          filteredFerilizerTimesList() {
               return this.cloneFertilizerTimesList.filter(fertilizerTimes => {
                    return fertilizerTimes.Fertilizer_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },


          async retrieveFertilizerTimesList() {
               const [err, respone] = await this.handle(
                    FertilizerTimesService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần bón phân.") {
                         this.fertilizerTimesList = respone.data;
                         this.cloneFertilizerTimesList = respone.data;
                         this.newFertilizerTimes.FertilizerTimes_times = this.fertilizerTimesList[this.fertilizerTimesList.length - 1].FertilizerTimes_times + 1;
                         this.newFertilizerTimes.Fertilizer = [];
                         var fertilizerInfor = {};
                         fertilizerInfor.Fertilizer_name = "";
                         fertilizerInfor.FertilizerTimes_amount = 0;
                         this.newFertilizerTimes.Fertilizer.push(fertilizerInfor)
                    }
                    else {
                         this.newFertilizerTimes.FertilizerTimes_times = 1;
                    }
                    console.log(this.fertilizerTimesList)
               }
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



          async setFertilizerChosen(data) {
               this.fertilizerTimesChosen = data;
               this.fertilizerTimesChosen.Fertilizer_id = data.Fertilizer_id;
               this.developmentStageList.forEach(element => {
                    if (data.DevelopmentStage_id == element.DevelopmentStage_id) {
                         data.DevelopmentStage_name = element.DevelopmentStage_name;
                    }
               });
          },

          // FertilizerTime
          async createFertilizerTimes(data) {
               if (data.close == false) {
                    this.isOpenCreateFertilizerTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newFertilizerTimes = {};
                    this.newFertilizerTimes.FertilizerTimes_times = this.fertilizerTimesList[this.fertilizerTimesList.length - 1].FertilizerTimes_times + 1;
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newFertilizerTimes.Fertilizer = [];
                    var fertilizerInfor = {};
                    fertilizerInfor.Fertilizer_name = "";
                    fertilizerInfor.FertilizerTimes_amount = 0;
                    this.newFertilizerTimes.Fertilizer.push(fertilizerInfor)
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.fertilizerList.forEach(element => {
                         data.Fertilizer.forEach(fertilizerInformation => {
                              if (element.Fertilizer_name == fertilizerInformation.Fertilizer_name) {
                                   fertilizerInformation.Fertilizer_id = element.Fertilizer_id;
                              }
                         });

                    });

                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
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
                    data.Fertilizer.forEach(element => {
                         if (element.Fertilizer_id != null) {
                              var fertilisertimes = {};
                              fertilisertimes = data;
                              fertilisertimes.Fertilizer_id = element.Fertilizer_id;
                              fertilisertimes.FertilizerTimes_amount = element.FertilizerTimes_amount;
                              this.createNewFertilizerTimes(fertilisertimes);
                         }

                    });

               }

          },

          async createNewFertilizerTimes(data) {
               const [error, respone] = await this.handle(
                    FertilizerTimesService.create(data)
               );
               if (error) {
                    console.log(error);
                    this.message1 = "Thêm không thành công."
               } else if (respone.data == "Không thể tạo lần bón phân mới.") {
                    this.message1 = "Thêm không thành công."
               } else {
                    this.message2 = "Thêm thành công.";
                    this.retrieveFertilizerTimesList();
               }
          },

          async updateFertilizerTimes(data) {
               if (data.close == false) {
                    this.isOpenTable = true;
                    this.isOpenUpdateFertilizerTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newFertilizerTimes = {};
                    this.newFertilizerTimes.FertilizerTimes_times = this.fertilizerTimesList[this.fertilizerTimesList.length - 1].FertilizerTimes_times + 1;
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newFertilizerTimes.Fertilizer = [];
                    var fertilizerInfor = {};
                    fertilizerInfor.Fertilizer_name = "";
                    fertilizerInfor.FertilizerTimes_amount = 0;
                    this.newFertilizerTimes.Fertilizer.push(fertilizerInfor)
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
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
                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
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
                         FertilizerTimesService.update(this.newRiceCrop.RiceCropInformation_id, data.Fertilizer_id, data.FertilizerTimes_times, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveFertilizerTimesList();
                    }

               }

          },


          async deleteFertilizerTimes() {
               const [error, respone] = await this.handle(
                    FertilizerTimesService.delete(this.newRiceCrop.RiceCropInformation_id, this.fertilizerTimesChosen.Fertilizer_id, this.fertilizerTimesChosen.FertilizerTimes_times)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa lần bón phân không thành công"
               } else if (respone.data == "Lỗi trong quá trình lần bón phân!!") {
                    this.message = "Xóa lần bón phân không thành công"
               } else {
                    this.message = "Xóa lần bón phân thành công";

               }
               this.delete = "";
               this.retrieveFertilizerTimesList();
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY")).slice(0, 10);
          },




          goToRiceCrop() {
               this.$router.push({ name: 'RiceCropDetail', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },
     },

     mounted() {
          this.initEmployeeState();
          this.retrieveSprayingTimesList();
          this.retrieveNewRiceCrop();
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