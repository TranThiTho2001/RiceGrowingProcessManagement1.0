<template>
     <div class="EmployeeManagerFrame container-fluid pr-4" style="background-color: #EAEAEA;height: max-content;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div v-if="!loading" class="row EmployeeManager" style="height: 100vmin;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
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
                         <!-- <div class="selection-component1">
                              <label class="labelRole">Vị trí</label>
                              <select class="selectRole" v-model="filter.role" @change="searchByRole()">
                                   <option class="optionRole" v-for="role in roles" :value="role" :key="role">{{ role }}
                                   </option>
                              </select>


                              <label class="labelSex">Giới tính</label>
                              <select class="selectSex" v-model="filter.sex" @change="searchBySex()">
                                   <option class="optionSex" value="Tất cả" selected="true">Tất cả</option>
                                   <option class="optionSex" value="Nữ">Nữ</option>
                                   <option class="optionSex" value="Nam">Nam</option>
                              </select>
                         </div> -->
                         <!-- isOpenCreateEmployeeForm = !isOpenCreateEmployeeForm, retrieveRoleList() -->
                         <button class="btn btnCreate" @click="backup()">
                              <i class="fas fa-cloud" style="font-size: 15px;"></i> Sao lưu</button>

                    </div>


                    <div class="scrollTable " style="margin-top: 50px ;">
                         <div class="scrollTable-content">
                              <table class="table employeeList">
                                   <thead>
                                        <tr>
                                             <th class="text-center">STT</th>
                                             <th class="text-center">Ngày sao lưu</th>
                                             <th>Tập tin sao lưu</th>
                                             <th>dowload</th>
                                             <th></th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(databackup, i ) in (dataBackupList)" :key="i">
                                             <td class="text-center">{{ i }}</td>
                                             <td class="text-center">{{ formatDate(databackup.Backup_date) }}</td>
                                             <!-- <td>{{ databackup.Backup_link }}</td>
                                            :href="`/../../../backup/${databackup.Backup_link}`" <a :href="'../../assets/Giong-lua-ST25.png'" target="_blank" >Dowload</a> -->
                                             <td><a :href="databackup.Link"  download="ewe" -->
                                                      >{{ databackup.Link }}</a></td>
                                             <td class="">
                                                  <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown"
                                                       aria-haspopup="true" aria-expanded="false">
                                                       <i class="fas fa-ellipsis-v"></i>
                                                  </button>
                                                  <div class="dropdown-menu">
                                                       <a class="dropdown-item" href="#"
                                                            @click="setDateBackupChosen(databackup), isOpenConfirm = !isOpenConfirm">
                                                            <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                       </a>
                                                  </div>
                                             </td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>
                    </div>
                    <div class="overlay2" v-if="isOpenCreateEmployeeForm">
                         <CreateNewEmployeeForm :newEmployee="newEmployee" :roleList="roleList"
                              @addEmployee-submit="createEmployee" :message1="message1" :message2="message2" />
                    </div>
                    <div class="overlay2" v-if="isOpenUpdateEmployeeForm">
                         <UpdateEmployeeForm :newEmployee="employeeChoosen" :roleList="roleList"
                              @updateEmployee-submit="updateEmployee" :message1="message1" :message2="message2" />
                    </div>
               </div>

          </div>

          <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->


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
          <div class="overlay2" v-if=" isOpenMessage ">
               <div class="messageDialog" v-if=" isOpenMessage ">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                         <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{
                         message
                         }}
                    </p>
                    <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click=" isOpenMessage = !isOpenMessage, active = false; ">OK</button>
               </div>
          </div>
          <div class="overlay2" v-if=" processing ">
               <div class="waitingDialog">
                    <div>
                         <p class="labelConfirm mt-4 pt-4">Đang sao lưu dữ liệu...</p>
                    </div>
                    <span v-show=" processing " class="spinner-border spinner-border-sm"></span>
               </div>
          </div>
          <div class="overlay2" v-if=" processed ">
               <div class="resultDialog text-center">
                    <p style="color:#515151; text-align:center; margin-top: 30px; font-size: 25px;" class="labelConfirm">{{
                         message }}
                    </p>
                    <button class="btnOK btn btn-sm btn-outline-secondary ml-3 mt-4"
                         @click=" processed = !processed, active = false ">OK</button>
               </div>
          </div>
     </div>
</template>
   
<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue'
import CreateNewEmployeeForm from '../../components/administratorsComponent/createNewEmployeeForm.vue';
import UpdateEmployeeForm from '../../components/administratorsComponent/updateEmployeeForm.vue';
import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import Preloader from '@/components/catalogManagementComponents/Preloader.vue'
import backupServices from '@/services/backup.services';
import Axios from 'axios';

export default {
     name: 'EmployeeManager',
     components: {
          Catalog,
          TopHeader,
          CreateNewEmployeeForm,
          UpdateEmployeeForm,
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
          async downloadItem({ url, label }) {
               Axios.get(url, { responseType: 'blob' })
                    .then(response => {
                         const blob = new Blob([response.data], { type: 'application/pdf' })
                         const link = document.createElement('a')
                         link.href = URL.createObjectURL(blob)
                         link.download = label
                         link.click()
                         URL.revokeObjectURL(link.href)
                    }).catch(console.error)
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
                    console.log(this.dataBackupList);
                    // this.dataBackupList.forEach(element => {
                    //      element.Link =  require('@/backup/'+element.Backup_link);
                    //      console.log(element.Link)
                    // });
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
     },

     mounted() {
          this.retrieveDataBackupList();
     },
}
</script>
   
<style>
@import url(../../assets/employeeStyle.css);
@import url(../../assets/mainStyle.css);

.EmployeeManagerFrame .dropdown-item:focus,
.EmployeeManagerFrame .dropdown-item:hover {
     background-color: #ABD2C8;
}

.EmployeeManagerFrame .waitingDialog {
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

.EmployeeManagerFrame .btnOK {
     /* display: block; */
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

.EmployeeManagerFrame .resultDialog {
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
</style>
   

