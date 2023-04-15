<template>
     <div class="container-fluid riceCropDetail">
          <Preloader color="red" scale="0.4" v-if="loading"/>
          <div class="row riceCropDetailFrame" style="height: max-content;"  v-if="!loading" >
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
                         <div class="detail-Component text-center" v-for="(activity, i) in activitiesDetailList" :key="i">
                              <div class="btnMoreInfor"> <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                   </button>
                                   <div class="dropdown-menu">
                                        <a class="dropdown-item action"
                                             @click="setEpidemicChosen(activity), isOpenUpdateEpidemicTimesForm= !isOpenUpdateEpidemicTimesForm">
                                             <span class="fas fa-edit actionIcon"></span> Chỉnh
                                             sửa
                                        </a>
                                        <a class="dropdown-item" href="#"
                                             @click="setEpidemicChosen(activity), setDelete('EpidemicTimes'), isOpenConfirm = !isOpenConfirm">
                                             <span class="fas fa-trash-alt actionIcon"></span>
                                             Xóa
                                        </a>

                                   </div>
                              </div>
                              <h5 class="nameComponent text-center">Lần {{ activity.ActivityDetails_times }}</h5>
                              <span>Tên: </span><span>{{ activity.OtherActivities_name }}</span><br>
                              <span>Từ ngày: </span><span>{{ formatDate(activity.ActivityDetails_startDate)
                              }}</span><br>
                              <span>Đến ngày: </span><span>{{ formatDate(activity.ActivityDetails_endDate)
                              }}</span><br>
                              <span>Nhân viên: </span><span>{{ activity.Employee_name }}</span><br>
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

               </div>

          </div>
     </div>
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

export default {
     name: "epidemicTimes",

     props: ["id"],

     components: {
          Catalog,
          TopHeader,
          Preloader,
     },

     data() {
          return {
               nameToSearch: "",
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

