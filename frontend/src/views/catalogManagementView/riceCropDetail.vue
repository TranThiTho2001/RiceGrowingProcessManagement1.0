<template>
     <div class="container-fluid riceCropDetail" style="background-color:#EAEAEA;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row riceCropDetailFrame" style="height: max-content;" v-if="!loading" :class="{ active: active }">
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

                    <div class="row weather-row" style="margin-top: 110px; margin-left:20px; margin-right:0px">
                         <div class="col-sm-6 weather-column">
                              <img :src="iconWeather" style="width: 49px;">
                              <span class="weather-value"> Nhiệt độ: {{ weatherInfor.temperature }}°C &nbsp; </span>
                              <span class="weather-value">Độ ẩm: {{ weatherInfor.humidity }}% &nbsp;</span>
                              <span class="weather-value">Tốc độ gió: {{ weatherInfor.windspeed }}Km/h &nbsp; </span>
                              <span class="weather-value">Bức xạ: {{ weatherInfor.solarradiation }}MJ/m²</span>
                         </div>
                         <div class="col-sm-6 text-right">
                              <button class="btn btnView" @click="isOpenUpdateRiceCrop = !isOpenUpdateRiceCrop, active = true">Xem
                                   Thông Tin Mùa Vụ</button>
                         </div>
                    </div>

                    <div class="row function-row" style="margin-left:-5px;margin-right: 10px ">
                         <div class="function-Component text-center" @click="gotoFertilizerTimes()">
                              <img src="../../images/BON-PHAN.jpg" class="img-fluid imageclass">
                              <h5 class="name-Component">BÓN PHÂN</h5>
                         </div>

                         <div class="function-Component text-center" @click="goToSprayingTimes()">
                              <img src="../../images/PHUN-THUOC.jpg" class="img-fluid imageclass">
                              <h5 class="name-Component">PHUN THUỐC</h5>

                         </div>
                         <div class="function-Component text-center" @click="goToImagesRiceCrop()">
                              <img src="../../images/image2.png" class="img-fluid imageclass">
                              <h5 class="name-Component">HÌNH ẢNH</h5>
                         </div>
                         <div class="function-Component text-center" @click="goToEpidemicTimes()">
                              <img src="../../images/saubenh.png" class="img-fluid imageclass">
                              <h5 class="name-Component">BỆNH DỊCH</h5>
                         </div>
                         <div class="function-Component text-center" @click="goToSupervisionRights()">
                              <img src="../../images/tham-dong.jpg" class="img-fluid imageclass">
                              <h5 class="name-Component">NGƯỜI THEO DÕI</h5>
                         </div>

                         <div class="function-Component text-center" @click="goToActivities()">
                              <img src="../../images/activities2.png" class="img-fluid imageclass">
                              <h5 class="name-Component">HOẠT ĐỘNG</h5>
                         </div>

                    </div>
               </div>
          </div>
          <UpdateRiceCropForm v-if="isOpenUpdateRiceCrop" :seedList="seedList" :newRiceCrop="newRiceCrop"
               :arableLandList="arableLandList" @updateRiceCrop-submit="updateRiceCrop" :message1="message1"
               :message2="message2" />
     </div>
</template>

<script >

import UpdateRiceCropForm from '@/components/catalogManagementComponents/updateRiceCropForm.vue';
import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import RiceCropService from '@/services/riceCropInformation.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import 'vue3-carousel/dist/carousel.css'
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import SeedService from '@/services/seed.service';
import ArableLandService from '@/services/arableLand.service';
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
               active: false,
               nameToSearch: "",
               activitiesList: [],
               newRiceCrop: {},
               cropList: [],
               seedList: [],
               arableLandList: [],
               developmentStageList: [],
               riceCropList: [],
               message1: "",
               message2: "",
               delete: "",
               isOpenConfirm: false,
               isOpenMessage: false,
               isOpenUpdateRiceCrop: false,
               message: "",
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               weatherInfor: {},
               iconWeather: "",
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

          async retrieveRiceCropList() {
               const [err, respone] = await this.handle(
                    RiceCropService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCropList = respone.data;
               }
          },

          async updateRiceCrop(data) {
               this.message1 = " ";
               this.message2 = " ";
               if (!data.close) {
                    this.isOpenUpdateRiceCrop = false;
                    this.active = false;
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
               if (data.RiceCropInformation_harvestDate != null && data.RiceCropInformation_harvestDate != "Invalid da") {
                    data.RiceCropInformation_harvestDate = (moment(String(data.RiceCropInformation_harvestDate)).format("YYYY-MM-DD")).slice(0, 10);
               }
               else {
                    data.RiceCropInformation_harvestDate = null;
               }

               var check = true;
               this.riceCropList.forEach(element => {
                    if (element.ArableLand_id == data.ArableLand_id && element.RiceCropInformation_id != data.RiceCropInformation_id) {
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
                    var weatherCode = data.current_weather.weathercode;

                    var date1 = new Date();
                    if (weatherCode == 0 && (date1.getHours() > 18 || date1.getHours() < 6)) {
                         this.iconWeather = require('@/images/weather/' + 'Clearsky_night.png');
                    }
                    else if (weatherCode == 0 && (date.getHours() < 18 || date.getHours() > 6)) {
                         this.iconWeather = require('@/images/weather/' + 'Clearsky_morning.png');
                    }
                    if (weatherCode == 3 || weatherCode == 1 || weatherCode == 2) {
                         this.iconWeather = require('@/images/weather/' + 'muanang.png');
                    }
                    else if (weatherCode == 45 || weatherCode == 48) {
                         this.iconWeather = require('@/images/weather/' + 'fog.png');
                    }
                    else if (weatherCode == 51 || weatherCode == 52 || weatherCode == 53) {
                         this.iconWeather = require('@/images/weather/' + 'rain.png');
                    }
                    else {
                         this.iconWeather = require('@/images/weather/' + 'Mainly_clear_partly_cloudy_overcast.png');
                    }
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
                    }, 1000);
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

          goToActivities() {
               this.$router.push({ name: 'Activities', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },
     },

     mounted() {
          this.initEmployeeState();
          this.retrieveArableLandList();
          this.retrieveNewRiceCrop();
          this.retrieveSeedList();

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