<template>
     <div class="container-fluid riceCropDetail">
          <div class="row riceCropDetailFrame">
               <div class="col-sm-2">
                    <Catalog :currentUserid="currentUser.Employee_id" />
               </div>
               <div class="col-md-10 rightRiceCropDetail">
                    <div class="row mr-2 mt-2 mb-5">
                         <div class="col-md-10 pr-5">
                              <div class="row">
                                   <input type="text" class="form-control col-md-10 inputSearch" placeholder="Tìm theo tên"
                                        style="border-radius:10px" v-model="nameToSearch" @keyup.enter="searchName" />
                                   <button class="btn btnTimKiem mb-2" type="button" style="border:none; width: 10%"
                                        @click="searchName">
                                        <span class="fa fa-search" style="font-size:18px"></span>
                                   </button>
                              </div>
                         </div>
                         <div class="col-md-2 pl-5">
                              <div class="row">
                                   <TopHeader :currentUserid="currentUser.Employee_id" />
                              </div>
                         </div>
                    </div>
                    <div class="row updateRiceCrop">
                         <UpdateRiceCropForm :seedList="seedList" :newRiceCrop="newRiceCrop" :arableLandList="arableLandList"
                              @updateRiceCrop-submit="updateRiceCrop" :message1="message1" :message2="message2" />
                    </div>

                    <div class="row activitiesList">

                    </div>
               </div>
          </div>
     </div>
</template>

<script>

import UpdateRiceCropForm from '@/components/catalogManagementComponents/updateRiceCropForm.vue';
import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import CropService from '@/services/crop.service';
import SeedService from '@/services/seed.service';
import ArableLandService from '@/services/arableLand.service';
import RiceCropService from '@/services/riceCropInformation.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import fertilizerService from '@/services/fertilizer.service';
import MonitorService from '@/services/monitor.service';
import developmentStageService from '@/services/developmentStage.service';
// import CreateFertilizerTimesForm from '@/components/catalogManagementComponents/createNewFertilizerTimesForm.vue';
import PesticideService from '@/services/pesticide.service';
// import CreateSprayingTimesForm from '@/components/catalogManagementComponents/createNewSprayingTimesForm.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import FertilizerTimesService from '@/services/fertilizerTimes.service';
import SprayingTimesService from '@/services/sprayingTimes.service';


export default {
     name: "riceCropDetail",

     props: ["riceCrop"],

     components: {
          UpdateRiceCropForm,
          Catalog,
          // UpdateRiceCropForm,
          // CreateFertilizerTimesForm,
          // CreateSprayingTimesForm,
          TopHeader,
     },

     data() {
          return {
               activitiesList: [],
               newRiceCrop: {},
               employeeList: {},
               newMonitor: {},
               newOtherActivities: {},
               newFertilizerTimes: {},
               newSprayingTimes: {},
               newOtherActivitiesTimes: {},
               monitorList: [],
               cropList: [],
               seedList: [],
               pesticideList: [],
               arableLandList: [],
               developmentStageList: [],
               fertiliserTimesList: [],
               SprayingTimesList: [],
               message1: "",
               message2: "",
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
          this.retrieveCropList();
          this.retrieveSeedList();
          this.retrieveNewRiceCrop();
     },


     methods: {

          ...mapMutations([
               "initEmployeeState"
          ]),

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

          async retrieveFertilizerTimesList() {
               const [err, respone] = await this.handle(
                    FertilizerTimesService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.fertiliserTimesList = respone.data;
                    console.log(respone.data);
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
                    this.SprayingTimesList = respone.data;
                    console.log(respone.data);
               }
          },

          async retrieveMonitorList() {
               const [err, respone] = await this.handle(
                    MonitorService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.monitorList = respone.data;
                    console.log(respone.data);
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
                    this.seedList.forEach(element => {
                         if (element.Seed_id == this.newRiceCrop.Seed_id) {
                              this.newRiceCrop.Seed_id = element.Seed_name;
                         }
                    });
                    this.newRiceCrop.RiceCropInformation_sowingDate = respone.data.RiceCropInformation_sowingDate;
                    this.newRiceCrop.RiceCropInformation_harvestDate = respone.data.RiceCropInformation_harvestDate;
                    this.newRiceCrop.RiceCropInformation_yield = respone.data.RiceCropInformation_yield;
                    this.newRiceCrop.Crop_id = respone.data.Crop_id;
                    this.cropList.forEach(element => {
                         if (element.Crop_id == this.newRiceCrop.Crop_id) {
                              this.newRiceCrop.Crop_id = element.Crop_name;
                         }
                    });
                    this.newRiceCrop.ArableLand_id = respone.data.ArableLand_id;
                    console.log(respone.data);
               }
          },

          async updateRiceCrop(data) {
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
          },


},

mounted() {
     this.retrieveArableLandList();
     this.retrieveCropList();
     this.retrieveDvelopmentStageList();
     this.retrieveFertilizerList();
     this.retrievePesticideList();
     this.retrieveSeedList();
     this.retrieveFertilizerTimesList();
     this.retrieveSprayingTimesList();
     this.retrieveMonitorList();
     this.retrieveNewRiceCrop();
}
};
</script>

<style></style>