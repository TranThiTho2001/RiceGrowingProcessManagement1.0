<template>
     <div class="container-fluid riceCropDetail" style="background-color: #EAEAEA;">
          <div class="row riceCropDetailFrame">
               <div class="col-md-2">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10 rightRiceCropDetail">
                    <div class="row mr-1 mt-2 mb-5 ml-2">
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
                         <div class="col-md-2 text-right">
                              <div class="row">
                                   <TopHeader :currentUserid="currentUser.Employee_id" />
                              </div>
                         </div>
                    </div>
                    <div class="row updateRiceCrop mr-2 ml-2">
                         <UpdateRiceCropForm :seedList="seedList" :newRiceCrop="newRiceCrop" :arableLandList="arableLandList"
                              @updateRiceCrop-submit="updateRiceCrop" :message1="message1" :message2="message2" />
                    </div>
                    <div class="row functionName mt-1 ml-2">
                         <div class=" btn btn-midle text-center btnFertilizerTimes" v-if="!isOpenTableFertilizerTimes"
                              @click="setTable('btnFertilizerTimes')">Bón phân</div>
                         <div class=" btn btn-midle text-center btnFertilizerTimes" v-if="isOpenTableFertilizerTimes"
                              style="background-color: bisque;">Bón phân</div>
                         <div class=" btn btn-midle text-center btnSprayingTimes" v-if="isOpenTableSprayingTimes"
                              style="background-color: bisque;">Phun thuốc</div>
                         <div class=" btn btn-midle text-center btnSprayingTimes" v-if="!isOpenTableSprayingTimes"
                              @click="setTable('btnSprayingTimes')">Phun thuốc</div>
                         <div class=" btn btn-midle text-center btnActivities" v-if="isOpenTableOtherActivitiesTimes"
                              style="background-color: bisque;">Hoạt động khác</div>
                         <div class=" btn btn-midle text-center btnActivities" @click="setTable('btnActivities')"
                              v-if="!isOpenTableOtherActivitiesTimes">Hoạt động khác</div>
                         <div class=" btn btn-midle text-center btnEpidemic" v-if="isOpenTableEpidemicTimes"
                              style="background-color: bisque;">Tình bệnh dịch</div>
                         <div class=" btn btn-midle text-center btnEpidemic" v-if="!isOpenTableEpidemicTimes"
                              @click="setTable('btnEpidemic')">Tình bệnh dịch</div>
                         <div class=" btn btn-midle text-center btnAttendee" v-if="isOpenTableMonitor"
                              style="background-color: bisque;">Người theo dõi</div>
                         <div class=" btn btn-midle text-center btnAttendee" v-if="!isOpenTableMonitor"
                              @click="setTable('btnAttendee')">Người theo dõi</div>

                    </div>
                    <!-- ----------------------FertilizerTimes Tab-------------- -->
                    <div class="row activitiesList ml-2 mr-2" v-if="isOpenTableFertilizerTimes">
                         <button class="btn mt-3" style="background-color: gold;"
                              @click="isOpenCreateFertilizerTimesForm = !isOpenCreateFertilizerTimesForm">Thêm</button>
                         <table class="table">
                              <thead>
                                   <tr>
                                        <th class="text-center ">Mã</th>
                                        <th>Tên phân bón</th>
                                        <th class="text-center ">Số lượng (kg/ha)</th>
                                        <th class="text-center ">Ngày bất đầu</th>
                                        <th class="text-center ">Ngày kết thúc</th>
                                        <th class="">Nhân viên</th>
                                        <th class="">Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(fertilizer, i ) in fertilizerTimesList" :key="i">
                                        <td class="text-center ">{{ fertilizer.FertilizerTimes_times }}</td>
                                        <td class="">{{ fertilizer.Fertilizer_name }}</td>
                                        <td class="text-center ">{{ fertilizer.FertilizerTimes_amount }}</td>
                                        <td class="text-center ">{{ formatDate(fertilizer.FertilizerTimes_startDate)
                                        }}</td>
                                        <td class="text-center ">{{ formatDate(fertilizer.FertilizerTimes_endDate) }}
                                        </td>
                                        <td class="">{{ fertilizer.Employee_name }}</td>
                                        <td style="border-top: none;" class="">
                                             <span class="action" style="border-top: none;"
                                                  @click="setFertilizerChoosen(fertilizer), isOpenUpdateFertilizerTimesForm = !isOpenUpdateFertilizerTimesForm">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class="action pl-4" style="border-top: none;"
                                                  @click="setFertilizerChoosen(fertilizer), isOpenConfirm = !isOpenConfirm">
                                                  <span class="fas fa-trash-alt actionIcon"></span>
                                             </span>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>

                    <!-- ----------------------SprayingTimes Tab-------------- -->
                    <div class="row activitiesList ml-2 mr-2" v-if="isOpenTableSprayingTimes">
                         <button class="btn mt-3" style="background-color: gold;"
                              @click="isOpenCreateSprayingTimesForm = !isOpenCreateSprayingTimesForm">Thêm</button>
                         <table class="table">
                              <thead>
                                   <tr>
                                        <th class="text-center ">Mã</th>
                                        <th>Tên thuốc</th>
                                        <th class="text-center ">Số lượng (kg/ha)</th>
                                        <th class="text-center ">Ngày bất đầu</th>
                                        <th class="text-center ">Ngày kết thúc</th>
                                        <th class="">Nhân viên</th>
                                        <th class="">Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(sprayingTimes, i ) in SprayingTimesList" :key="i">
                                        <td class="text-center ">{{ sprayingTimes.SprayingTimes_times }}</td>
                                        <td class="">{{ sprayingTimes.Pesticide_name }}</td>
                                        <td class="text-center ">{{ sprayingTimes.SprayingTimes_amount }}</td>
                                        <td class="text-center ">{{ formatDate(sprayingTimes.SprayingTimes_startDate)
                                        }}</td>
                                        <td class="text-center ">{{ formatDate(sprayingTimes.SprayingTimes_endDate) }}
                                        </td>
                                        <td class="">{{ sprayingTimes.Employee_name }}</td>
                                        <td style="border-top: none;" class="">
                                             <span class="action" style="border-top: none;"
                                                  @click="setSprayingTimes(sprayingTimes), isOpenUpdateSprayingTimesForm = !isOpenUpdateSprayingTimesForm">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class="action pl-4" style="border-top: none;"
                                                  @click="setSprayingTimes(sprayingTimes), isOpenConfirm = !isOpenConfirm">
                                                  <span class="fas fa-trash-alt actionIcon"></span>
                                             </span>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>

                    <!-- ----------------------EpidemicTimes Tab-------------- -->
                    <div class="row activitiesList ml-2 mr-2" v-if="isOpenTableEpidemicTimes">
                         <button class="btn mt-3" style="background-color: gold;"
                              @click="isOpenCreateEpidemicTimesForm = !isOpenCreateEpidemicTimesForm">Thêm</button>
                         <table class="table">
                              <thead>
                                   <tr>
                                        <th class="text-center ">Lần</th>
                                        <th>Tên bệnh dịch</th>
                                        <th class="text-center ">Ngày bất đầu</th>
                                        <th class="text-center ">Ngày kết thúc</th>
                                        <th class="">Nhân viên</th>
                                        <th class="">Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(epidemic, i ) in epidemicTimesList" :key="i">
                                        <td class="text-center ">{{ epidemic.EpidemicTimes_times }}</td>
                                        <td class="">{{ epidemic.Epidemic_name }}</td>
                                        <td class="text-center ">{{ formatDate(epidemic.EpidemicTimes_startDate)
                                        }}</td>
                                        <td class="text-center ">{{ formatDate(epidemic.EpidemicTimes_endDate) }}
                                        </td>
                                        <td class="">{{ epidemic.Employee_name }}</td>
                                        <td style="border-top: none;" class="">
                                             <span class="action" style="border-top: none;"
                                                  @click="setEpidemicChoosen(epidemic), isOpenUpdateEpidemicTimesForm = !isOpenUpdateEpidemicTimesForm">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class="action pl-4" style="border-top: none;"
                                                  @click="setEpidemicChoosen(epidemic), isOpenConfirm = !isOpenConfirm">
                                                  <span class="fas fa-trash-alt actionIcon"></span>
                                             </span>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>

                    <!-- ----------------------Monitor Tab-------------- -->
                    <div class="row activitiesList ml-2 mr-2" v-if="isOpenTableMonitor">
                         <button class="btn mt-3" style="background-color: gold;"
                              @click="isOpenCreateEpidemicTimesForm = !isOpenCreateEpidemicTimesForm">Thêm</button>
                         <table class="table">
                              <thead>
                                   <tr>
                                        <th class="text-center ">STT</th>
                                        <th class="text-center ">Mã</th>
                                        <th>Họ và Tên</th>
                                        <th>Chuyên môn</th>
                                        <th class="">Vai trò</th>
                                        <th class="">Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(monitor, i ) in monitorList" :key="i">
                                        <td class="text-center">{{ i }}</td>
                                        <td class="text-center">{{ monitor.Employee_id }}</td>
                                        <td>{{ monitor.Employee_name }}</td>
                                        <td>{{ monitor.Employee_major }}
                                        </td>
                                        <td class="">{{ monitor.Role_name }}</td>
                                        <td style="border-top: none;" class="">
                                             <span class="action" style="border-top: none;"
                                                  @click="setEpidemicChoosen(monitor), isOpenUpdateEpidemicTimesForm = !isOpenUpdateEpidemicTimesForm">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class="action pl-4" style="border-top: none;"
                                                  @click="setEpidemicChoosen(monitor), isOpenConfirm = !isOpenConfirm">
                                                  <span class="fas fa-trash-alt actionIcon"></span>
                                             </span>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>

                    <CreateFertilizerTimesForm v-if="isOpenCreateFertilizerTimesForm"
                         :newFertilizerTimes="newFertilizerTimes" :fertilizerList="fertilizerList"
                         :developmentStageList="developmentStageList" :currentUser="currentUser"
                         :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
                         @addFertilizerTimes-submit="createFertilizerTimes" :message1="message1" :message2="message2" />
                    <UpdateFertilizerTimesForm v-if="isOpenUpdateFertilizerTimesForm"
                         :newFertilizerTimes="fertilizerTimesChoosen" :fertilizerList="fertilizerList"
                         :developmentStageList="developmentStageList" :currentUser="currentUser"
                         :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
                         @updateFertilizerTimes-submit="updateFertilizerTimes" :message1="message1" :message2="message2" />

                    <CreateSprayingTimesForm v-if="isOpenCreateSprayingTimesForm" :newSprayingTimes="newSprayingTimes"
                         :pesticideList="pesticideList" :developmentStageList="developmentStageList"
                         :currentUser="currentUser" :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
                         @addSprayingTimes-submit="createNewSprayingTimes" :message1="message1" :message2="message2" />

                    <UpdateSprayingTimesForm v-if="isOpenUpdateSprayingTimesForm" :newSprayingTimes="sprayingTimesChoosen"
                         :pesticideList="pesticideList" :developmentStageList="developmentStageList"
                         :currentUser="currentUser" :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
                         @updateSprayingTimes-submit="updateSprayingTimes" :message1="message1" :message2="message2" />
                    <CreateEpidemicTimesForm v-if="isOpenCreateEpidemicTimesForm" :newEpidemicTimes="newEpidemicTimes"
                         :epidemicList="epidemicList" :developmentStageList="developmentStageList" :currentUser="currentUser"
                         :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
                         @addEpidemicTimes-submit="createEpidemicTimes" :message1="message1" :message2="message2" />

                    <UpdateEpidemicTimesForm v-if="isOpenUpdateEpidemicTimesForm" :newEpidemicTimes="epidemicTimesChoosen"
                         :epidemicList="epidemicList" :developmentStageList="developmentStageList" :currentUser="currentUser"
                         :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
                         @updateEpidemicTimes-submit="updateEpidemicTimes" :message1="message1" :message2="message2" />
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
import CreateFertilizerTimesForm from '@/components/catalogManagementComponents/createNewFertilizerTimesForm.vue';
import PesticideService from '@/services/pesticide.service';
import EpidemicService from '@/services/epidemic.service';
import EpidemicTimesService from '@/services/epidemicTimes.service';
import CreateSprayingTimesForm from '@/components/catalogManagementComponents/createNewSprayingTimesForm.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import FertilizerTimesService from '@/services/fertilizerTimes.service';
import SprayingTimesService from '@/services/sprayingTimes.service';
import UpdateFertilizerTimesForm from '@/components/catalogManagementComponents/updateFertilizerTimesForm.vue';
import UpdateSprayingTimesForm from '@/components/catalogManagementComponents/updateSprayingTimesForm.vue';
import CreateEpidemicTimesForm from '@/components/catalogManagementComponents/createNewEpidemicTimesForm.vue';
import UpdateEpidemicTimesForm from '@/components/catalogManagementComponents/updateEpidemicTimesForm.vue';

export default {
     name: "riceCropDetail",

     props: ["riceCrop"],

     components: {
          UpdateRiceCropForm,
          Catalog,
          // UpdateRiceCropForm,
          CreateFertilizerTimesForm,
          UpdateFertilizerTimesForm,
          CreateSprayingTimesForm,
          UpdateSprayingTimesForm,
          CreateEpidemicTimesForm,
          UpdateEpidemicTimesForm,
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
               message1: "",
               message2: "",
               isOpenTableFertilizerTimes: false,
               isOpenTableSprayingTimes: false,
               isOpenTableOtherActivitiesTimes: false,
               isOpenTableEpidemicTimes: false,
               isOpenTableMonitor: false,
               isOpenCreateFertilizerTimesForm: false,
               isOpenUpdateFertilizerTimesForm: false,
               fertilizerTimesChoosen: {},
               isOpenCreateSprayingTimesForm: false,
               isOpenUpdateSprayingTimesForm: false,
               sprayingTimesChoosen: {},
               isOpenCreateEpidemicTimesForm: false,
               isOpenUpdateEpidemicTimesForm: false,
               epidemicTimesChoosen: {},
               isOpenCreateMonitorForm: false,
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

          async retrieveEpidemicList() {
               const [err, respone] = await this.handle(
                    EpidemicService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.epidemicList = respone.data;
                    console.log(respone.data);
               }
          },

          async retrieveEpidemicTimesList() {
               const [err, respone] = await this.handle(
                    EpidemicTimesService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần bị dịch bệnh.") {
                         this.epidemicTimesList = respone.data;
                         console.log(respone.data);
                         this.newEpidemicTimes.EpidemicTimes_times = this.epidemicTimesList[this.epidemicTimesList.length - 1].EpidemicTimes_times + 1;
                    }
                    else {
                         this.newEpidemicTimes.EpidemicTimes_times = 1;

                    }

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
          async retrieveRiceCropList() {
               const [err, respone] = await this.handle(
                    RiceCropService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCropList = respone.data;
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
                    if (respone.data != "Không tìm thấy lần bón phân.") {
                         this.fertilizerTimesList = respone.data;
                         console.log(respone.data);
                         this.newFertilizerTimes.FertilizerTimes_times = this.fertilizerTimesList[this.fertilizerTimesList.length - 1].FertilizerTimes_times + 1;

                    }

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
                    if (respone.data != "Không tìm thấy lần phun thuuốc mới.") {
                         this.SprayingTimesList = respone.data;
                         console.log(respone.data);
                         this.newSprayingTimes.SprayingTimes_times = this.SprayingTimesList[this.SprayingTimesList.length - 1].SprayingTimes_times + 1;
                    }
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
                    this.monitorList.forEach(element => {
                         if (element.Role_id == '01') {
                              element.Role_name = "Quản trị viên";
                         }
                         else if (element.Role_id == '02') {
                              element.Role_name = "Chuyên gia";
                         }
                         else {
                              element.Role_name = "Nhân viên"
                         }
                    });
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
                    this.newRiceCrop.Seed_name = respone.data.Seed_name;
                    this.newRiceCrop.RiceCropInformation_sowingDate = respone.data.RiceCropInformation_sowingDate;
                    this.newRiceCrop.RiceCropInformation_harvestDate = respone.data.RiceCropInformation_harvestDate;
                    this.newRiceCrop.RiceCropInformation_yield = respone.data.RiceCropInformation_yield;
                    this.newRiceCrop.Crop_id = respone.data.Crop_id;
                    this.newRiceCrop.Crop_name = respone.data.Crop_name;
                    this.newRiceCrop.ArableLand_id = respone.data.ArableLand_id;
                    console.log(respone.data);
               }
          },

          async updateRiceCrop(data) {
               this.message1 = " ";
               this.message2 = " ";
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
                              console.log("alo" + check);
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

          async setFertilizerChoosen(data) {
               this.fertilizerTimesChoosen = data;
               this.fertilizerTimesChoosen.Fertilizer_id = data.Fertilizer_id;
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

               }

          },

          async updateFertilizerTimes(data) {
               if (data.close == false) {
                    this.isOpenUpdateFertilizerTimesForm = false;
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

          async setSprayingTimes(data) {
               this.sprayingTimesChoosen = data;
          },

          async createNewSprayingTimes(data) {
               if (data.close == false) {
                    this.isOpenCreateSprayingTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newSprayingTimes = {};
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
                         SprayingTimesService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo lần phun thuuốc mới.") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveSprayingTimesList();
                    }

               }

          },

          async updateSprayingTimes(data) {
               if (data.close == false) {
                    this.isOpenUpdateSprayingTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newSprayingTimes = {};
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
                         this.retrieveSprayingTimesList();
                    }

               }

          },

          async setEpidemicChoosen(data) {
               this.epidemicTimesChoosen = data;
          },

          async createEpidemicTimes(data) {
               if (data.close == false) {
                    this.isOpenCreateEpidemicTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newSprayingTimes = {};
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
                    this.isOpenUpdateEpidemicTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newSprayingTimes = {};
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

                    this.epidemicList.forEach(element => {
                         if (element.Epidemic_name == data.Epidemic_name) {
                              data.Epidemic_id = element.Epidemic_id;
                         }
                    });

                    console.log("tên " + data.Epidemic_name + "id " + data.Epidemic_id)
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


          formatDate(data) {
               if (data == null) return "";
               return (moment(String(data)).format("YYYY-MM-DD")).slice(0, 10);
          },

          async setTable(data) {
               this.isOpenTableEpidemicTimes = false;
               this.isOpenTableFertilizerTimes = false;
               this.isOpenTableMonitor = false;
               this.isOpenTableOtherActivitiesTimes = false
               this.isOpenTableSprayingTimes = false;
               if (data == "btnFertilizerTimes") {
                    this.retrieveFertilizerTimesList();
                    this.isOpenTableFertilizerTimes = true;

               }
               else if (data == "btnSprayingTimes") {
                    this.retrieveSprayingTimesList();
                    this.isOpenTableSprayingTimes = true;
               }
               else if (data == "btnActivities") {

                    this.isOpenTableOtherActivitiesTimes = true;
               }
               else if (data == "btnEpidemic") {
                    this.retrieveEpidemicTimesList();
                    this.isOpenTableEpidemicTimes = true;
               }
               else {
                    this.isOpenTableMonitor = true;
               }
          },


     },

     mounted() {
          this.initEmployeeState();
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
          this.initEmployeeState();
          this.retrieveEpidemicList();
          this.retrieveEpidemicTimesList();
          this.retrieveRiceCropList();
     }
};
</script>

<style>
@import url(../../assets/riceCropDetailStyle.css);
</style>