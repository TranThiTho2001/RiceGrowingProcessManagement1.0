<template>
     <div class="container-fluid riceCropDetail">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
          <Preloader color="red" scale="0.4" /></div>
          <div class="row riceCropDetailFrame" style="height: max-content;" v-if="!loading">
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
                              @click="isOpenCreateEpidemicTimesForm = !isOpenCreateEpidemicTimesForm">Thêm</button>
                    </div>
                    <div class="row mt-4 row-detail" style=" margin-left:20px;margin-right: 10px ">
                         <div class="detail-Component text-center" v-for="(epidemictimes, i) in epidemicTimesList" :key="i">
                              <div class="btnMoreInfor"> <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                   </button>
                                   <div class="dropdown-menu">
                                        <a class="dropdown-item action"
                                             @click="setEpidemicChosen(epidemictimes), isOpenUpdateEpidemicTimesForm = !isOpenUpdateEpidemicTimesForm">
                                             <span class="fas fa-edit actionIcon"></span> Chỉnh
                                             sửa
                                        </a>
                                        <a class="dropdown-item" href="#"
                                             @click="setEpidemicChosen(epidemictimes), setDelete('EpidemicTimes'), isOpenConfirm = !isOpenConfirm">
                                             <span class="fas fa-trash-alt actionIcon"></span>
                                             Xóa
                                        </a>

                                   </div>
                              </div>
                              <h5 class="function-name text-center">Lần {{ epidemictimes.EpidemicTimes_times }}</h5>
                              <span class="title-detail">Tên: </span>
                              <span class="value-name-detail">{{ epidemictimes.Epidemic_name }}</span><br>
                              <span class="title-detail">Từ ngày: </span>
                              <span class="value-detail">{{ formatDate(epidemictimes.EpidemicTimes_startDate)}}</span><br>
                              <span class="title-detail">Đến ngày: </span>
                              <span class="value-detail">{{ formatDate(epidemictimes.EpidemicTimes_endDate)}}</span><br>
                              <span class="title-detail">Nhân viên: </span><span class="value-detail">{{ epidemictimes.Employee_name }}</span><br>
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
                    <CreateEpidemicTimesForm v-if="isOpenCreateEpidemicTimesForm" :newEpidemicTimes="newEpidemicTimes"
                         :epidemicList="epidemicList" :developmentStageList="developmentStageList" :currentUser="currentUser"
                         :riceCropChosen="newRiceCrop" :arableLandList="arableLandList"
                         @addEpidemicTimes-submit="createEpidemicTimes" :message1="message1" :message2="message2" />

                    <UpdateEpidemicTimesForm v-if="isOpenUpdateEpidemicTimesForm" :newEpidemicTimes="epidemicTimesChosen"
                         :epidemicList="epidemicList" :developmentStageList="developmentStageList" :currentUser="currentUser"
                         :riceCropChosen="newRiceCrop" :arableLandList="arableLandList"
                         @updateEpidemicTimes-submit="updateEpidemicTimes" :message1="message1" :message2="message2" />
               </div>

          </div>
     </div>
</template>

<script >

import moment from 'moment';
import 'vue3-carousel/dist/carousel.css'
import { mapGetters, mapMutations } from "vuex";
import EpidemicService from '@/services/epidemic.service';
import EmployeeService from '@/services/employee.service';
import TreatmentService from '@/services/treatment.service';
import EpidemicTimesService from '@/services/epidemicTimes.service';
import RiceCropService from '@/services/riceCropInformation.service';
import DevelopmentStageService from '@/services/developmentStage.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import Catalog from '../../../components/catalogManagementComponents/catalog.vue';
import CreateEpidemicTimesForm from '@/components/catalogManagementComponents/createNewEpidemicTimesForm.vue';
import UpdateEpidemicTimesForm from '@/components/catalogManagementComponents/updateEpidemicTimesForm.vue';

export default {
     name: "epidemicTimes",

     props: ["id"],

     components: {
          Catalog,
          CreateEpidemicTimesForm,
          UpdateEpidemicTimesForm,
          TopHeader,
          Preloader,
     },

     data() {
          return {
               nameToSearch: "",
               newRiceCrop: {},
               newEpidemicTimes: {},
               cropList: [],
               epidemicTimesList: [],
               message1: "",
               message2: "",
               isOpenCreateEpidemicTimesForm: false,
               isOpenUpdateEpidemicTimesForm: false,
               epidemicTimesChosen: {},
               delete: "",
               isOpenConfirm: false,
               isOpenMessage: false,
               message: "",
               cloneEpidemicTimesList: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               weatherInfor: {},
               loading: true,
               developmentStageList: [],
               epidemicList: [],
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

          filteredEpidemicTimesList() {
               return this.cloneEpidemicTimesList.filter(epidemic => {
                    return epidemic.Epidemic_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
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

          async retrieveEmpoyeeList() {
               const [err, respone] = await this.handle(
                    EmployeeService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.employeeList = respone.data;
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

          async retrieveEpidemicTimesList() {
               this.loading = true;
               const [err, respone] = await this.handle(
                    EpidemicTimesService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần bị dịch bệnh.") {
                         this.epidemicTimesList = respone.data;
                         this.cloneEpidemicTimesList = respone.data;
                         this.newEpidemicTimes.EpidemicTimes_times = this.epidemicTimesList[this.epidemicTimesList.length - 1].EpidemicTimes_times + 1;
                         var i = 0;
                         this.epidemicTimesList.forEach(element => {
                              element.Treatment = [];
                              this.getTreatment(element.Epidemic_id, i);
                              i++
                         });
                    }
                    else {
                         this.newEpidemicTimes.EpidemicTimes_times = 1;
                    }

               } if (this.loading == true) {
                    setTimeout(() => {
                         this.loading = false;
                         console.log(this.loading)
                    }, 900);
               }
          },

          async getTreatment(epidemicid, i) {
               const [error, response] = await this.handle(
                    TreatmentService.findByEpidemicId(epidemicid)
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         console.log(error)
                    }
                    else {
                         var temp = [];
                         temp = response.data;
                         if (temp.length > 0) {
                              this.epidemicTimesList[i].Treatment = [];
                              temp.forEach(element => {
                                   this.epidemicTimesList[i].Treatment.push(element.Pesticide_name);
                              });
                         }
                    }
               }
          },

          async setDelete(data) {
               this.delete = data;
          },

          async choosenDelete() {
               if (this.delete == "FertilizerTimes") {
                    this.deleteFertilizerTimes();
               }
               else if (this.delete == "SprayingTimes") {
                    this.deleteSprayingTimes();
               }
               else if (this.delete == "EpidemicTimes") {
                    this.deleteEpidemicTimes();
               }
               else if (this.delete == "Monitor") {
                    this.deleteMonitor();
               }
               else if (this.delete == "ActivitiseDetail") {
                    this.deleteActivitiesDetail();
               }
          },

          async setEpidemicChosen(data) {
               this.epidemicTimesChosen = data;
          },

          async createEpidemicTimes(data) {
               if (data.close == false) {
                    this.isOpenCreateEpidemicTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newEpidemicTimes = {};
                    if (this.epidemicTimesList.length > 0) {
                         this.newEpidemicTimes.EpidemicTimes_times = this.epidemicTimesList[this.epidemicTimesList.length - 1].EpidemicTimes_times + 1;
                    }
                    else {
                         this.newEpidemicTimes.EpidemicTimes_times = this.epidemicTimesList[this.epidemicTimesList.length - 1].EpidemicTimes_times + 1;
                    }
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.epidemicList.forEach(element => {
                         if (element.Epidemic_name == data.Epidemic_name) {
                              data.Epidemic_id = element.Epidemic_id;
                         }
                    });

                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;


                    if (data.EpidemicTimes_startDate != null) {
                         data.EpidemicTimes_startDate = (moment(String(data.EpidemicTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.EpidemicTimes_startDate = null;
                    }
                    if (data.EpidemicTimes_endDate != null) {
                         data.EpidemicTimes_endDate = (moment(String(data.EpidemicTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.EpidemicTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         EpidemicTimesService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo lần bị dịch bệnh mới.") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveEpidemicTimesList();
                    }
               }
          },

          async updateEpidemicTimes(data) {
               if (data.close == false) {
                    this.isOpenTable = true;
                    this.isOpenUpdateEpidemicTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newSprayingTimes = {};
                    this.newEpidemicTimes.EpidemicTimes_times = this.epidemicTimesList[this.epidemicTimesList.length - 1].EpidemicTimes_times + 1;
                    this.stylebac.none = false;
                    this.stylebac.active = true;
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.epidemicList.forEach(element => {
                         if (element.Epidemic_name == data.Epidemic_name) {
                              data.Epidemic_id = element.Epidemic_id;
                         }
                    });

                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;

                    if (data.EpidemicTimes_startDate != null) {
                         data.EpidemicTimes_startDate = (moment(String(data.EpidemicTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.EpidemicTimes_startDate = null;
                    }
                    if (data.EpidemicTimes_endDate != null) {
                         data.EpidemicTimes_endDate = (moment(String(data.EpidemicTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.EpidemicTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         EpidemicTimesService.update(this.newRiceCrop.RiceCropInformation_id, data.Epidemic_id, data.EpidemicTimes_times, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         console.log(respone.data);
                         this.retrieveEpidemicTimesList();
                    }
               }
          },

          async deleteEpidemicTimes() {
               const [error, respone] = await this.handle(
                    EpidemicTimesService.delete(this.newRiceCrop.RiceCropInformation_id, this.epidemicTimesChosen.Epidemic_id, this.epidemicTimesChosen.EpidemicTimes_times)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa lần bị bệnh dịch không thành công"
               } else if (respone.data == "Lỗi trong quá trình xóa lần bị dịch bệnh!!") {
                    this.message = "Xóa lần bị bệnh dịch không không thành công"
               } else {
                    this.message = "Xóa lần bị bệnh dịch không thành công";
                    console.log(respone.data);
                    this.retrieveEpidemicTimesList();
               }
               this.delete = "";
          },
          
          async searchNameEpidemic(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != "") {
                    this.epidemicTimesList = [];
                    this.cloneEpidemicTimesList.forEach(element => {
                         if (element.Epidemic_name == data) {
                              this.epidemicTimesList.push(element);
                         }
                    });
                    if (this.epidemicTimesList.length == 0) {

                         const [err, respone] = await this.handle(
                              EpidemicTimesService.getByName(this.nameToSearch, this.newRiceCrop.RiceCropInformation_id)
                         );
                         if (err) {
                              console.log(err)
                         }
                         else {
                              if (respone.data != "Không tìm thấy lần bị dịch bệnh.") {
                                   this.epidemicTimesList = respone.data;
                              }
                              else this.epidemicTimesList = [];
                         }
                    }
               }
               else {
                    this.retrieveEpidemicTimesList();
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
                    // this.getWeather();
               }
          },

          goToRiceCrop() {
               this.$router.push({ name: 'RiceCropDetail', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY")).slice(0, 10);
          },
     },

     mounted() {
          this.initEmployeeState();
          this.retrieveNewRiceCrop();
          this.retrieveEpidemicList();
          this.retrieveEpidemicList();
          this.retrieveDvelopmentStageList();
          this.retrieveEpidemicTimesList();
          
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

