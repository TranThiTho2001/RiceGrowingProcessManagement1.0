<template>
     <div class="EmployeeManagerFrame1 container-fluid pr-4" style="background-color: #EAEAEA;height: max-content;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>

          <div v-if="!loading" class="row EmployeeManager" style="height: 100vmin;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = FontFaceSetLoadEvent"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>

               <div class="right rightEmployeeManager">
                    <div class="mb-4  pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Sao lưu dữ liệu</h3>
                         </div>

                         <div class="text-right mt-3">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row row-inputSearch">
                         <button class="btn btnCreate" @click="backup()">
                              <i class="fas fa-cloud" style="font-size: 15px;"></i> Sao lưu
                         </button>
                    </div>

                    <div class="scrollTable " style="margin-top: 50px ;">
                         <div class="scrollTable-content">
                              <table class="table employeeList">
                                   <thead>
                                        <tr>
                                             <th class="text-center">STT</th>
                                             <th>Ngày sao lưu</th>
                                             <th>Tập tin sao lưu</th>
                                             <th>Tùy chọn</th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(databackup, i ) in (dataBackupList)" :key="i">
                                             <td class="text-center">{{ i }}</td>
                                             <td>{{ formatDate(databackup.Backup_date) }}</td>
                                             <td>{{ databackup.Backup_link }}</td>
                                             <td>
                                                  <button class="btnDowloadSQL" @click="DowloadFile(databackup)"><i
                                                            class="fas fa-arrow-alt-circle-down"></i></button>
                                                  <button class="btnDowloadSQL"
                                                       @click="setDateBackupChosen(databackup), isOpenConfirm = !isOpenConfirm"><span
                                                            class="fas fa-trash-alt"></span></button>
                                             </td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>
                    </div>
               </div>
          </div>

          <!-- -----------------------------confirm ----------------------------- -->

          <div class="overlay2" v-if="isOpenConfirm">
               <div class="confirmationDialog">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelConfirm">
                         <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                    </p>
                    <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                         @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteDataBackup(dataBackupChoosen)">Xóa</button>
                    <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenConfirm = !isOpenConfirm, active = false;">Hủy</button>
               </div>
          </div>

          <div class="overlay2" v-if="isOpenMessage">
               <div class="messageDialog" v-if="isOpenMessage">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                         <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{
                              message
                         }}
                    </p>
                    <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click=" isOpenMessage = !isOpenMessage, active = false;">OK</button>
               </div>
          </div>

          <div class="overlay2" v-if="processing">
               <div class="waitingDialog">
                    <div>
                         <p class="labelConfirm mt-4 pt-4">Đang sao lưu dữ liệu...</p>
                    </div>
                    <span v-show="processing" class="spinner-border spinner-border-sm"></span>
               </div>
          </div>

          <div class="overlay2" v-if="processed">
               <div class="resultDialog text-center">
                    <p style="color:#515151; text-align:center; margin-top: 30px; font-size: 25px;" class="labelConfirm">{{
                         message }}
                    </p>
                    <button class="btnOK btn btn-sm btn-outline-secondary ml-3 mt-4"
                         @click=" processed = !processed, active = false">OK</button>
               </div>
          </div>
     </div>
</template>
   
<script>

import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import backupServices from '@/services/backup.services';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue'

export default {
     name: 'EmployeeManager',
     components: {
          Catalog,
          TopHeader,
          Preloader,
     },
     data() {
          return {
               dataBackupList: [],
               isOpenXacNhan: false,
               isOpenThongBao: false,
               message: "",
               dataBackupChoosen: {},
               active: false,
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               loading: false,
               isOpenConfirm: false,
               isOpenMessage: false,
               processed: false,
               processing: false,
          }
     },

     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },

     created() {
          this.initEmployeeState();
     },

     methods: {
          ...mapMutations([
               "initEmployeeState"
          ]),

          filteredList() {
               return this.cloneEmployeeList.filter(employee => {
                    return employee.Employee_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          async backup() {
               this.message = "";
               this.processing = true;
               const [err, respone] = await this.handle(
                    backupServices.create()
               );
               if (err) {
                    console.log(err)
                    this.message = "Đã xảy ra lỗi trong qá trình sao lưu"
               }
               else {
                    console.log(respone.data);
                    this.retrieveDataBackupList();
                    this.message = "Sao lưu thành công"
               }
               setTimeout(() => {
                    this.processing = false;
                    this.processed = true;
               }, 3000);
          },

          async retrieveDataBackupList() {
               const [err, respone] = await this.handle(
                    backupServices.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.dataBackupList = respone.data;
               }
          },

          async deleteDataBackup() {
               const [err, respone] = await this.handle(
                    backupServices.delete(this.dataBackupChoosen.Backup_id, this.dataBackupChoosen.Backup_link)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    console.log(respone.data);
                    this.retrieveDataBackupList();
               }
          },

          async setDateBackupChosen(data) {
               this.dataBackupChoosen = data;
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY h:mm:ss A"));
          },

          async DowloadFile(data) {
               console.log(data)
               const [err, respone] = await this.handle(
                    backupServices.get(data.Backup_link)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    console.log(respone.data);
                    var csvFile;
                    var downloadLink;
                    csvFile = new Blob(["\uFEFF" + respone.data], { type: "text/sql" });

                    // Download link
                    downloadLink = document.createElement("a");

                    // File name
                    downloadLink.download = "backup.sql";

                    // We have to create a link to the file
                    downloadLink.href = window.URL.createObjectURL(csvFile);

                    // Make sure that the link is not displayed
                    downloadLink.style.display = "none";

                    // Add the link to your DOM
                    document.body.appendChild(downloadLink);

                    // Lanzamos
                    downloadLink.click();
               }
          },
     },

     mounted() {
          this.retrieveDataBackupList();
     },
}
</script>
   
<style>
@import url(../../assets/employeeStyle.css);
@import url(../../assets/mainStyle.css);

.EmployeeManagerFrame1 .dropdown-item:focus,
.EmployeeManagerFrame1 .dropdown-item:hover {
     background-color: #ABD2C8;
}

.EmployeeManagerFrame1 .waitingDialog {
     background: #F7FFD9;
     border: 1px solid rgb(62, 77, 77);
     border-radius: 10px;
     position: absolute;
     top: calc(300px);
     left: 42%;
     border-radius: 16px;
     display: block;
     width: 404px;
     height: 187px;
     border-radius: 15px;
     text-align: center;
     z-index: 5;
}

.EmployeeManagerFrame1 .btnOK {
     width: 100px;
     font-size: 18px;
     background-color: #beb928;
     color: #444415;
     border: none;
     font-family: 'Roboto';
     font-style: normal;
     border-radius: 14px;
     text-align: center;
}

.EmployeeManagerFrame1 .resultDialog {
     background: #F7FFD9;
     border: 1px solid rgb(62, 77, 77);
     border-radius: 10px;
     position: absolute;
     top: calc(300px);
     left: 42%;
     border-radius: 16px;
     display: block;
     width: 404px;
     height: 187px;
     border-radius: 15px;
     text-align: center;
     z-index: 5;
}

.EmployeeManagerFrame1 .navigationBar .btnBackup {
     display: block;
     width: 88%;
     font-size: 17px;
     background: #FFFA37;
     box-shadow: 4px 4px 2px rgba(0, 0, 0, 0.25);
     border-radius: 20px;
     color: #5C5D22;
     border: none;
     font-family: 'Roboto';
     font-style: normal;
     border-radius: 14px;
}

.EmployeeManagerFrame1 {
     transition: all 5s ease-in-out;
}
</style>
   

