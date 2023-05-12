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

                    <div class="row row-inputSearch" >
                         <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                              @click="retrieveFertilizerList(), isOpenInput1 = true"
                              @keyup.enter="searchName(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>

                         <div class="suggestion" :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="fertilizer in filteredList()" :key="fertilizer.Fertilizer_name"
                                   @click="searchName(fertilizer.Fertilizer_name), away()">
                                   {{ fertilizer.Fertilizer_name }}</p>
                         </div>

                         <button class="btn btnCreate" style="right:3.7%"
                              @click="isOpenCreateFertilizerTimesForm = !isOpenCreateFertilizerTimesForm, active = true"> 
                              <i class="fas fa-plus-circle" style="font-size: 15px;"></i> Thêm</button>
                    </div>

                    <div class="row mt-3 pt-1 function-row" style=" margin-left:20px;margin-right: 10px ">
                         <div class="detail-Component text-left" v-for="(fertilizertimes, i) in fertilizerTimesList"
                              :key="i">
                              <div class="btnMoreInfor"> <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                   </button>
                                   <div class="dropdown-menu">
                                        <a class="dropdown-item action"
                                             @click="setFertilizerChosen(fertilizertimes), isOpenUpdateFertilizerTimesForm = !isOpenUpdateFertilizerTimesForm, active = true">
                                             <span class="fas fa-edit actionIcon"></span> Chỉnh
                                             sửa
                                        </a>
                                        <a class="dropdown-item" href="#"
                                             @click="setFertilizerChosen(fertilizertimes),  isOpenConfirm = !isOpenConfirm, active = true">
                                             <span class="fas fa-trash-alt actionIcon"></span>
                                             Xóa
                                        </a>
                                   </div>
                              </div>

                              <h5 class="function-name text-center">Lần {{ fertilizertimes.FertilizerTimes_times }}</h5>
                              <span class="title-detail">Phân: </span>
                              <span class="value-name-detail">{{ fertilizertimes.Fertilizer_name }}</span><br>
                              <span class="title-detail">Số lượng: </span>
                              <span class="value-detail">{{ fertilizertimes.FertilizerTimes_amount }} (kg/ha)</span><br>
                              <span class="title-detail">Bón ngày: </span>
                              <span class="value-detail">{{
                                   formatDate(fertilizertimes.FertilizerTimes_startDate) }}</span><br>
                              <span class="title-detail">Đến ngày: </span>
                              <span class="value-detail">{{ formatDate(fertilizertimes.FertilizerTimes_endDate) }}</span><br>
                              <span class="title-detail">Nhân viên: </span>
                              <span class="value-detail">{{ fertilizertimes.Employee_name }}</span><br>
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
                         @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteFertilizerTimes()">Xóa</button>
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

          <div class="overlay2" v-if="isOpenCreateFertilizerTimesForm">
               <CreateFertilizerTimesForm :weather="weatherInfor" :newFertilizerTimes="newFertilizerTimes"
                    :fertilizerList="fertilizerList" :developmentStageList="developmentStageList" :currentUser="currentUser"
                    :riceCropChosen="newRiceCrop" :arableLandList="arableLandList"
                    @addFertilizerTimes-submit="createFertilizerTimes" :message1="message1" :message2="message2" />
          </div>

          <div class="overlay2" v-if="isOpenUpdateFertilizerTimesForm">
               <UpdateFertilizerTimesForm :newFertilizerTimes="fertilizerTimesChosen" :fertilizerList="fertilizerList"
                    :developmentStageList="developmentStageList" :currentUser="currentUser" :riceCropChosen="newRiceCrop"
                    :arableLandList="arableLandList" @updateFertilizerTimes-submit="updateFertilizerTimes"
                    :message1="message1" :message2="message2" />
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script >

import moment from 'moment';
import 'vue3-carousel/dist/carousel.css'
import { mapGetters, mapMutations } from "vuex";

import RiceCropService from '@/services/riceCropInformation.service';
import FertilizerService from '@/services/fertilizer.service';
import FertilizerTimesService from '@/services/fertilizerTimes.service';
import developmentStageService from '@/services/developmentStage.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import Catalog from '../../../components/catalogManagementComponents/catalog.vue';
import UpdateFertilizerTimesForm from '@/components/catalogManagementComponents/updateFertilizerTimesForm.vue';
import CreateFertilizerTimesForm from '@/components/catalogManagementComponents/createNewFertilizerTimesForm.vue';

export default {
     name: "fertilizerTimes",

     props: ["id"],

     components: {
          Catalog,
          CreateFertilizerTimesForm,
          UpdateFertilizerTimesForm,
          TopHeader,
          Preloader,
     },

     data() {
          return {
               nameToSearch: "",
               newRiceCrop: {},
               newFertilizerTimes: {},
               fertilizerTimesList: [],
               fertilizerList: [],
               developmentStageList: [],
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
               loading: true,
               active: false,
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

          filteredList() {
               return this.fertilizerList.filter(fertilizer => {
                    return fertilizer.Fertilizer_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
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
                    } else {
                         this.newFertilizerTimes.FertilizerTimes_times = 1;
                    }
                    this.newFertilizerTimes.Fertilizer = [];
                    var fertilizerInfor = {};
                    fertilizerInfor.Fertilizer_name = "";
                    fertilizerInfor.FertilizerTimes_amount = 0;
                    this.newFertilizerTimes.Fertilizer.push(fertilizerInfor)
               }
          },

          async retrieveNewRiceCrop() {
               const [err, respone] = await this.handle(
                    RiceCropService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               } else {
                    this.newRiceCrop = respone.data;
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

          async createFertilizerTimes(data) {
               if (data.close == false) {
                    this.isOpenCreateFertilizerTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
                    this.newFertilizerTimes = {};
                    this.newFertilizerTimes.FertilizerTimes_times = this.fertilizerTimesList[this.fertilizerTimesList.length - 1].FertilizerTimes_times + 1;
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
                    } else {
                         data.FertilizerTimes_startDate = null;
                    }

                    if (data.FertilizerTimes_endDate != null) {
                         data.FertilizerTimes_endDate = (moment(String(data.FertilizerTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    } else {
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
                    this.isOpenUpdateFertilizerTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
                    this.newFertilizerTimes = {};
                    this.newFertilizerTimes.FertilizerTimes_times = this.fertilizerTimesList[this.fertilizerTimesList.length - 1].FertilizerTimes_times + 1;
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
                    } else {
                         data.FertilizerTimes_startDate = null;
                    }

                    if (data.FertilizerTimes_endDate != null) {
                         data.FertilizerTimes_endDate = (moment(String(data.FertilizerTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    } else {
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

          async retrieveDvelopmentStageList() {
               const [err, respone] = await this.handle(
                    developmentStageService.getAll()
               );
               if (err) {
                    console.log(err)
               } else {
                    this.developmentStageList = respone.data;
               }
          },

          async retrieveFertilizerList() {
               const [err, respone] = await this.handle(
                    FertilizerService.getAll()
               );
               if (err) {
                    console.log(err)
               } else {
                    this.fertilizerList = respone.data;
               }
          },

          async searchName(data) {
               this.nameToSearch = data;
               this.fertilizerTimesList = [];
               if (this.nameToSearch != "") {
                    this.cloneFertilizerTimesList.forEach(element => {
                         if (this.nameToSearch == element.Fertilizer_name) {
                              this.fertilizerTimesList.push(element)
                         }
                    });
                    if (this.fertilizerTimesList.length == 0) {
                         const [err, respone] = await this.handle(
                              FertilizerTimesService.getByName(this.nameToSearch, this.newRiceCrop.RiceCropInformation_id)
                         );
                         if (err) {
                              console.log(err)
                         } else {
                              if (respone.data != "Không tìm thấy lần bón phân.") {
                                   this.fertilizerTimesList = respone.data;
                              }
                              else this.fertilizerTimesList = [];
                         }
                    }
               }
               else {
                    this.retrieveFertilizerTimesList();
               }
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY")).slice(0, 10);
          },

          goToRiceCrop() {
               this.$router.push({ name: 'RiceCropDetail', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },
     },

     mounted() {
          this.initEmployeeState();
          this.retrieveNewRiceCrop();
          this.retrieveFertilizerList();
          this.retrieveDvelopmentStageList();
          this.retrieveFertilizerTimesList();
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
