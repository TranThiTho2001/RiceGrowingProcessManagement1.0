<template>
     <div class="container-fluid riceCropDetail">
          <Preloader color="red" scale="0.4" v-if="loading" />
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
                         <div class="col-sm-12 text-right">
                              <button class="btn btnView"
                                   @click="isOpenUpdateRiceCrop = !isOpenUpdateRiceCrop, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">Xem
                                   thông tin mùa vụ</button>
                         </div>
                    </div>
                    <div class="row function-row" style=" margin-left:20px;margin-right: 10px ">
                         <div class="function-Component text-center" @click="gotoFertilizerTimes()">
                              <img src="../../images/BON-PHAN.jpg" class="img-fluid imageclass">
                              <h5 class="nameComponent">BÓN PHÂN</h5>
                              <!-- <div class="cicle text-center">
                                   <h2 class="amountFertilizer">{{ fertilizerTimesList.length }}</h2>
                              </div> -->
                         </div>

                         <div class="function-Component text-center" @click="goToSprayingTimes()">
                              <img src="../../images/PHUN-THUOC.jpg" class="img-fluid imageclass">
                              <h5 class="nameComponent">PHUN THUỐC</h5>

                         </div>
                         <div class="function-Component text-center" @click="goToImagesRiceCrop()">
                              <img src="../../images/image2.png" class="img-fluid imageclass">
                              <h5 class="nameComponent">HÌNH ẢNH</h5>
                         </div>
                         <div class="function-Component text-center" @click="goToEpidemicTimes()">
                              <img src="../../images/saubenh.png" class="img-fluid">
                              <h5 class="nameComponent">BỆNH DỊCH</h5>
                         </div>
                         <div class="function-Component text-center" @click="goToSupervisionRights()">
                              <img src="../../images/tham-dong.jpg" class="img-fluid imageclass">
                              <h5 class="nameComponent">NGƯỜI THEO DÕI</h5>
                         </div>

                         <div class="function-Component text-center" @click="goToEpidemicTimes()">
                              <img src="../../images/activities2.png" class="img-fluid imageclass">
                              <h5 class="nameComponent">HOẠT ĐỘNG</h5>
                         </div>
                    </div>


                    <UpdateRiceCropForm v-if="isOpenUpdateRiceCrop" :seedList="seedList" :newRiceCrop="newRiceCrop"
                         :arableLandList="arableLandList" @updateRiceCrop-submit="updateRiceCrop" :message1="message1"
                         :message2="message2" />


               </div>

          </div>
     </div>

     <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>
</template>

<script >

import UpdateRiceCropForm from '@/components/catalogManagementComponents/updateRiceCropForm.vue';
import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import RiceCropService from '@/services/riceCropInformation.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import 'vue3-carousel/dist/carousel.css'
import Preloader from '@/components/catalogManagementComponents/Preloader.vue'
export default {
     name: "riceCropDetail",

     props: ["riceCrop"],

     components: {
          UpdateRiceCropForm,
          Catalog,
          TopHeader,
          Preloader,
     },

     data() {
          return {
               loading: true,
               nameToSearch: "",
               activitiesList: [],
               newRiceCrop: {},
               employeeList: {},
               newMonitor: {},
               newOtherActivities: {},
               newFertilizerTimes: {},
               newSprayingTimes: {},
               newEpidemicTimes: {},
               newOtherActivitiesTimes: {},
               monitorList: [],
               cropList: [],
               seedList: [],
               pesticideList: [],
               arableLandList: [],
               developmentStageList: [],
               fertilizerTimesList: [],
               SprayingTimesList: [],
               epidemicList: [],
               epidemicTimesList: [],
               riceCropList: [],
               imagesList: [],
               otherActivitiesList: [],
               activitiesDetailList: [],
               message1: "",
               message2: "",
               isOpenTableFertilizerTimes: true,
               isOpenTableSprayingTimes: false,
               isOpenTableOtherActivitiesTimes: false,
               isOpenTableEpidemicTimes: false,
               isOpenTableMonitor: false,
               isOpenImage: false,
               isOpenCreateImage: false,
               newImage: {},
               isOpenCreateFertilizerTimesForm: false,
               isOpenUpdateFertilizerTimesForm: false,
               fertilizerTimesChosen: {},
               isOpenCreateSprayingTimesForm: false,
               isOpenUpdateSprayingTimesForm: false,
               sprayingTimesChosen: {},
               isOpenCreateEpidemicTimesForm: false,
               isOpenUpdateEpidemicTimesForm: false,
               epidemicTimesChosen: {},
               isOpenCreateMonitorForm: false,
               newActivityDetail: {},
               isOpenCreateActivitiesDetail: false,
               isOpenUpdateActivitiesDetail: false,
               activitiesDetailChosen: {},
               delete: "",
               isOpenConfirm: false,
               isOpenMessage: false,
               isOpenUpdateRiceCrop: false,
               message: "",
               monitorChosen: {},
               idImage: 0,
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
                         itemsToShow: 4,
                         snapAlign: 'start',
                    },
                    1600: {
                         itemsToShow: 8,
                         snapAlign: 'start',
                    },

               },

               stylebac: {
                    active: true,
                    none: false,
               },

               isOpenSearch: {
                    open: false,
                    close: true,
               },

               cloneFertilizerTimesList: [],
               cloneSprayingTimesList: [],
               cloneEpidemicTimesList: [],
               cloneMonitorList: [],
               cloneActivityDetailList: [],
               cloneImageList: [],
               treatmentList: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               weatherInfor: {},
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

          async updateRiceCrop(data) {
               this.message1 = " ";
               this.message2 = " ";
               if (!data.close) {
                    this.isOpenUpdateRiceCrop = false;
                    this.stylebac.none = false;
                    this.stylebac.active = true;
               }

               this.seedList.forEach(element => {
                    if (data.Seed_name == element.Seed_name) {
                         data.Seed_id = element.Seed_id;
                    }
               });

               this.cropList.forEach(element => {
                    if (data.Crop_name == element.Crop_name) {
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
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveNewRiceCrop();
                    }
               }
               else {
                    this.message1 = "Cập nhật không thành công.";
               }
          },

          async getWeather() {
               let urlAPI = `https://api.open-meteo.com/v1/forecast?latitude=${this.newRiceCrop.ArableLand_latitude}&longitude=${this.newRiceCrop.ArableLand_longitude}&current_weather=true&forecast_days=1&daily=shortwave_radiation_sum&timezone=auto&daily=precipitation_sum&hourly=relativehumidity_2m`;
               let data = await fetch(urlAPI).then(res => res.json())
               if (data.error != true) {
                    this.weatherInfor.temperature = data.current_weather.temperature;
                    this.weatherInfor.windspeed = data.current_weather.windspeed;
                    this.weatherInfor.precipitation = data.daily.precipitation_sum[0];
                    this.weatherInfor.solarradiation = data.daily.shortwave_radiation_sum[0];
                    let date = new Date();
                    date = moment(date).format("YYYY-MM-DDTHH:00")
                    var i = 0;
                    data.hourly.time.forEach(element => {
                         if (element == date) {
                              this.weatherInfor.humidity = data.hourly.relativehumidity_2m[i]
                         }
                         i++;
                    });
               }
               else {
                    this.weatherInfor.temperature = "";
                    this.weatherInfor.windspeed = "";
                    this.weatherInfor.precipitation = "";
                    this.weatherInfor.solarradiation = "";
                    this.weatherInfor.humidity = "";
               }
          },
          
          async retrieveNewRiceCrop() {
               this.loading = true;
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
                    this.getWeather();
               }
               if (this.loading == true) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 2000);
               }
          },


          gotoFertilizerTimes() {
               this.$router.push({ name: 'FertilizerTimes', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },

          goToSprayingTimes() {
               this.$router.push({ name: 'SprayingTimes', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },

          goToEpidemicTimes() {
               this.$router.push({ name: 'EpidemicTimes', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },

          goToSupervisionRights() {
               this.$router.push({ name: 'SupervisionRights', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },

          goToImagesRiceCrop() {
               this.$router.push({ name: 'ImagesRiceCrop', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },
     },

     mounted() {
          this.initEmployeeState();
          this.retrieveNewRiceCrop();
     }
};
</script>

<style>
@import url(../../assets/mainStyle.css);
@import url(../../assets/riceCropDetailStyle.css);

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