<template>
     <div class="container-fluid riceCropDetail" scale="0.6" style="height: 100vh;">
          <Preloader color="red" scale="0.4" v-if="loading" />
          <div v-if="!loading" class="row riceCropDetailFrame" style="height: max-content;">
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
                              @click="isOpenCreateMonitorForm = !isOpenCreateMonitorForm">Thêm</button>
                    </div>
                    <div class="mt-4 function-row row" style=" margin-left:20px;margin-right: 10px ">
                         <div class="account-Component text-center" v-for="(monitor, i) in monitorList" :key="i">
                              <div class="btnMoreInfor-Employee"> <button type="button" class="btn-sm btnmore" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                   </button>
                                   <div class="dropdown-menu">
                                        <a class="dropdown-item" href="#"
                                             @click="setMonitorChosen(monitor), isOpenConfirm = !isOpenConfirm">
                                             <span class="fas fa-trash-alt actionIcon"></span>
                                             Xóa
                                        </a>
                                   </div>
                              </div>

                              <div class="fas fa-user-circle iconAccountExpert" v-if="monitor.Role_id == '02'"></div>
                              <div class="fas fa-user-circle iconAccountEmployee" v-if="monitor.Role_id == '03'"></div>
                              <h5 class="nameEmloyee text-center">{{ monitor.Employee_name }}</h5>
                              <button v-if="monitor.Role_id == '03'" class="btnEmployee">{{ monitor.Role_name }}</button>
                              <button v-if="monitor.Role_id == '02'" class="btnExpert">{{ monitor.Role_name }}</button>
                         </div>
                    </div>

                    <div class="confirmationDialog" v-if="isOpenConfirm">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteMonitor()">Xóa</button>
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
                    <CreateMonitorForm v-if="isOpenCreateMonitorForm" :newMonitor="newMonitor" :employeeList="employeeList"
                         :newRiceCrop="newRiceCrop" @addMonitor-submit="createNewMonitor" :message1="message1"
                         :message2="message2" />
               </div>

          </div>
     </div>
</template>

<script >

import moment from 'moment';
import 'vue3-carousel/dist/carousel.css'
import { mapGetters, mapMutations } from "vuex";
import MonitorService from '@/services/monitor.service';
import RiceCropService from '@/services/riceCropInformation.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue'
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import EmployeeService from '@/services/employee.service';
import Catalog from '../../../components/catalogManagementComponents/catalog.vue';
import CreateMonitorForm from '@/components/catalogManagementComponents/createNewMonitorForm.vue';

export default {
     name: "fertilizerTimes",

     props: ["id"],

     components: {
          Catalog,
          TopHeader,
          CreateMonitorForm,
          Preloader,
     },

     data() {
          return {
               nameToSearch: "",
               newRiceCrop: {},
               newMonitor: {},
               cloneMonitorList: [],
               monitorList: [],
               message1: "",
               message2: "",
               employeeList: [],
               delete: "",
               isOpenCreateMonitorForm: false,
               isOpenConfirm: false,
               isOpenMessage: false,
               message: "",
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               loading: true,
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

          filteredMonitorList() {
               return this.cloneMonitorList.filter(monitor => {
                    return monitor.Employee_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          async retrieveMonitorList() {
               this.loading = true;
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
                    this.cloneMonitorList = this.monitorList;
                    if (this.loading == true) {
                         setTimeout(() => {
                              this.loading = false;
                         }, 2000);
                    }
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

          async setMonitorChosen(data) {
               this.monitorChosen = data;
          },

          async createNewMonitor(data) {
               if (data.close == false) {
                    this.isOpenCreateMonitorForm = false;
                    this.retrieveMonitorList();
               }
          },

          async deleteMonitor() {
               const [error, response] = await this.handle(
                    MonitorService.delete(this.newRiceCrop.RiceCropInformation_id, this.monitorChosen.Employee_id)
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         this.message = "Xóa không thành công.";
                    }
                    else if (response.data == "Lỗi trong quá trình xóa quyền giám sát!!") {
                         this.message = "Xóa không thành công";
                    }
                    else {
                         this.message = "Xóa thành công.";
                         this.retrieveMonitorList();
                    }
               }
               this.delete = "";
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
          this.retrieveMonitorList();
          this.retrieveNewRiceCrop();
          this.retrieveEmpoyeeList();
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

.iconAccount {
     color: #5C5D22;
     padding-top: 10px;
     font-size: 50px;
}

.iconAccountExpert {
     color: #EEEA41;
     text-shadow: 4px 4px 4px rgba(0, 0, 0, 0.25);
     font-size: 80px;
     padding-bottom: 20px !important;
     padding-top: 20px !important;
}

.nameEmloyee {
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 700;
     font-size: 20px;
     line-height: 23px;
     color: #5C5D22;
     text-transform: uppercase;
     padding-top: 10px !important;
     padding-bottom: 20px !important;
}

.iconAccountEmployee {
     color: #51AEB0;
     ;
     text-shadow: 4px 4px 4px rgba(0, 0, 0, 0.25);
     font-size: 80px;
     padding-bottom: 20px !important;
     padding-top: 20px !important;
}

.riceCropDetail .btnEmployee {
     background: #ABD2C8;
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     border-radius: 20px;
     border: 0px;
     color: #6D6E73;
     font-family: 'Roboto';
     font-style: normal;
     font-size: 18px;
     text-transform: capitalize;
     margin-bottom: 20px;
}

.riceCropDetail .btnExpert {
     background: #FFFED8;
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     border-radius: 20px;
     border: 0px;
     color: #6D6E73;
     font-family: 'Roboto';
     font-style: normal;
     font-size: 18px;
     text-transform: capitalize;
     margin-bottom: 20px;
}

.btnMoreInfor-Employee{
     position: absolute;
     top:3%;
     left: 88%;
     border: 0px;
    background: none;
}

.btnmore{
     border: 0px;
    background: none;
}

.btnmore:hover{
     background: #cbcbcb;
}
</style>

