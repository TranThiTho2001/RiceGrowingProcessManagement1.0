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
                              @click="retrieveOtherActivities(), isOpenInput1 = true"
                              @keyup.enter="searchName(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>

                         <div class="suggestion" :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="activity in filteredList()" :key="activity.OtherActivities_name"
                                   @click="searchName(activity.OtherActivities_name), away()">
                                   {{ activity.OtherActivities_name }}</p>
                         </div>

                         <button class="btn btnCreate" style="right:3.7%"
                              @click="isOpenCreateActivitiesDetail = !isOpenCreateActivitiesDetail, active = true"> <i
                                   class="fas fa-plus-circle" style="font-size: 15px;"></i> Thêm</button>
                    </div>
                    <div class="row mt-4 function-row" style=" margin-left:20px;margin-right: 10px ">
                         <div class="detail-Component text-left" v-for="(activity, i) in activitiesDetailList" :key="i">
                              <div class="btnMoreInfor"> <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                   </button>
                                   <div class="dropdown-menu">
                                        <a class="dropdown-item action"
                                             @click="setActivityChosen(activity), isOpenUpdateActivitiesDetail = !isOpenUpdateActivitiesDetail, active = true">
                                             <span class="fas fa-edit actionIcon"></span> Chỉnh
                                             sửa
                                        </a>
                                        <a class="dropdown-item" href="#"
                                             @click="setActivityChosen(activity), isOpenConfirm = !isOpenConfirm, active = true">
                                             <span class="fas fa-trash-alt actionIcon"></span>
                                             Xóa
                                        </a>

                                   </div>
                              </div>
                              <h5 class="function-name text-center">{{ activity.OtherActivities_name }} Lần {{
                                   activity.ActivityDetails_times }}</h5>
                              <span class="title-detail">Từ ngày: </span><span class="value-detail">{{
                                   formatDate(activity.ActivityDetails_startDate)
                              }}</span><br>
                              <span class="title-detail">Đến ngày: </span><span class="value-detail">{{
                                   formatDate(activity.ActivityDetails_endDate)
                              }}</span><br>
                              <span class="title-detail">Nhân viên: </span><span class="value-detail">{{
                                   activity.Employee_name }}</span><br>
                         </div>


                    </div>

               </div>

          </div>
          <div class="overlay2" v-if="isOpenConfirm">
               <div class="confirmationDialog" >
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelConfirm">
                         <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                    </p>
                    <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                         @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteActivitiesDetail()">Xóa</button>
                    <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenConfirm = !isOpenConfirm, active = false">Hủy</button>
               </div>
          </div>
          <div class="overlay2" v-if="isOpenMessage">
               <div class="messageDialog" >
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
          <div class="overlay2" v-if="isOpenCreateActivitiesDetail">
               <CreateActivitiiesDetailForm :newActivityDetail="newActivityDetail" :currentUser="currentUser"
                    :developmentStageList="developmentStageList" :riceCropChosen="newRiceCrop"
                    @addOtherActivityTimes-submit="createNewActivitiesDetail" :message1="message1" :message2="message2" />
          </div>
          <div class="overlay2" v-if="isOpenUpdateActivitiesDetail">
               <UpadteActivitiiesDetailForm :newActivityDetail="activitiesDetailChosen" :currentUser="currentUser"
                    :developmentStageList="developmentStageList" :riceCropChosen="newRiceCrop"
                    @updateActivitiesDetail-submit="updateActivitiesDetail" :message1="message1" :message2="message2" />
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script >
import moment from 'moment';
import 'vue3-carousel/dist/carousel.css';
import { mapGetters, mapMutations } from "vuex";
import RiceCropService from '@/services/riceCropInformation.service';
import DevelopmentStageService from '@/services/developmentStage.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue'
import Catalog from '../../../components/catalogManagementComponents/catalog.vue';
import ActivityDetailsService from '@/services/activityDetails.service';
import otherActivitiesService from '@/services/otherActivities.service';
import UpadteActivitiiesDetailForm from '@/components/catalogManagementComponents/updateActivitiesDetailForm.vue'
import CreateActivitiiesDetailForm from '@/components/catalogManagementComponents/createNewOtherActivityTimesForm.vue';
export default {
     name: "epidemicTimes",

     props: ["id"],

     components: {
          Catalog,
          TopHeader,
          Preloader,
          UpadteActivitiiesDetailForm,
          CreateActivitiiesDetailForm,
     },

     data() {
          return {
               nameToSearch: "",
               active: false,
               newRiceCrop: {},
               message1: "",
               message2: "",
               delete: "",
               isOpenConfirm: false,
               isOpenMessage: false,
               message: "",
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               weatherInfor: {},
               loading: true,
               activitiesDetailList: [],
               cloneActivityDetailList: [],
               developmentStageList: [],
               otherActivitiesList: [],
               newActivityDetail: {},
               isOpenUpdateActivitiesDetail: false,
               isOpenCreateActivitiesDetail: false,
               activitiesDetailChosen: {},
               isOpenSearch: {
                    open: false,
                    close: true,
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

          filteredList() {
               return this.otherActivitiesList.filter(activity => {
                    return activity.OtherActivities_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
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
          setActivityChosen(activity) {
               this.activitiesDetailChosen = activity;
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

          async retrieveActivitiesDetail() {
               const [err, respone] = await this.handle(
                    ActivityDetailsService.findByIdRiceCrop(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy chi tiết hoạt động.") {
                         this.activitiesDetailList = respone.data;
                         this.cloneActivityDetailList = respone.data
                    }
                    else {
                         this.newActivityDetail.ActivityDetails_times = 1;
                    }
               }
          },

          async createNewActivitiesDetail(data) {
               this.message1 = "";
               this.message2 = "";
               if (!data.close) {
                    this.isOpenCreateActivitiesDetail = false;
                    this.active = false;
                    this.newActivityDetail = {};
                    this.retrieveActivitiesDetail();
               }
               else {
                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;
                    this.otherActivitiesList.forEach(element => {
                         if (data.OtherActivities_name == element.OtherActivities_name) {
                              data.OtherActivities_id = element.OtherActivities_id;
                         }
                    });
                    this.developmentStageList.forEach(element => {
                         if (data.DevelopmentStage_name == element.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });
                    if (data.ActivityDetails_endDate != null) {
                         data.ActivityDetails_endDate = (moment(String(data.ActivityDetails_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.ActivityDetails_endDate = null;
                    }
                    if (data.ActivityDetails_startDate != null) {
                         data.ActivityDetails_startDate = (moment(String(data.ActivityDetails_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.ActivityDetails_startDate = null;
                    }
                    const [error, response] = await this.handle(
                         ActivityDetailsService.create(data)
                    );

                    if (response.data == error) {
                         this.message1 = "Thêm không thành công.";
                    }
                    else if (response.data == "Không thể tạo chi tiết hoạt động mới.") {
                         this.message1 = "Thêm không thành công.";
                    }
                    else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveActivitiesDetail();
                    }

               }
          },

          async updateActivitiesDetail(data) {
               this.message1 = "";
               this.message2 = "";
               if (!data.close) {
                    this.isOpenUpdateActivitiesDetail = false;
                    this.active = false;
                    this.newActivityDetail = {};
                    this.retrieveActivitiesDetail();
               }
               else {
                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;
                    this.otherActivitiesList.forEach(element => {
                         if (data.OtherActivities_name == element.OtherActivities_name) {
                              data.OtherActivities_id = element.OtherActivities_id;
                         }
                    });
                    this.developmentStageList.forEach(element => {
                         if (data.DevelopmentStage_name == element.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });
                    if (data.ActivityDetails_endDate != null) {
                         data.ActivityDetails_endDate = (moment(String(data.ActivityDetails_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.ActivityDetails_endDate = null;
                    }
                    if (data.ActivityDetails_startDate != null) {
                         data.ActivityDetails_startDate = (moment(String(data.ActivityDetails_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.ActivityDetails_startDate = null;
                    }
                    //Ipdate
                    const [error, response] = await this.handle(
                         ActivityDetailsService.update(this.newRiceCrop.RiceCropInformation_id, data.OtherActivities_id, data.ActivityDetails_times, data)
                    );

                    if (response.data == error) {
                         this.message1 = "Cập nhật không thành công.";
                    }
                    else if (response.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công.";
                    }
                    else {
                         this.message2 = "Cập nhật thành công.";
                    }
                    this.retrieveActivitiesDetail()
               }
          },

          async deleteActivitiesDetail() {
               const [error, respone] = await this.handle(
                    ActivityDetailsService.delete(this.newRiceCrop.RiceCropInformation_id, this.activitiesDetailChosen.OtherActivities_id, this.activitiesDetailChosen.ActivityDetails_times)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa lần thực hiện hoạt động không thành công"
               } else if (respone.data == "Lỗi trong quá trình lần bón phân!!") {
                    this.message = "Xóa lần thực hiện hoạt động không thành công"
               } else {
                    this.message = "Xóa lần thực hiện hoạt động thành công";
                    this.retrieveActivitiesDetail()
               }
               this.delete = "";
          },

          async retrieveOtherActivities() {
               const [err, respone] = await this.handle(
                    otherActivitiesService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.otherActivitiesList = respone.data;
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


          async searchName(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != "") {
                    const [err, respone] = await this.handle(
                         ActivityDetailsService.getByName(this.nameToSearch, this.newRiceCrop.RiceCropInformation_id)
                    );
                    if (err) {
                         console.log(err)
                    }
                    else {
                         this.activitiesDetailList = respone.data;
                    }
               }
               else {
                    this.retrieveActivitiesDetail()
               }
          },

          goToRiceCrop() {
               this.$router.push({ name: 'RiceCropDetail', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY")).slice(0, 10);
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
          this.retrieveDvelopmentStageList();
          this.retrieveNewRiceCrop();
          this.retrieveActivitiesDetail();
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

