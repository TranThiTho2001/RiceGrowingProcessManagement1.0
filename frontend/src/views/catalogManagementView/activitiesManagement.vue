<template>
     <div class="container-fluid activitiesManagement pr-4" style="background-color: #EAEAEA;height: max-content;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row activitiesManagementFrame" v-if="!loading" :class="{ active: active }">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }" style="position: fixed;">
                    <Catalog />
               </div>
               <div class="right rightActivitiesManagement " :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="mb-4  pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Hoạt động</h3>
                         </div>

                         <div class="text-right mt-3">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row row-inputSearch">
                         <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                              @click="retrieveOtherActivities, isOpenInput1 = true"
                              @keyup.enter="searchName(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>


                         <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="activity in filteredList()" :key="activity.OtherActivities_name"
                                   @click="searchName(activity.OtherActivities_name), away()">
                                   {{ activity.OtherActivities_name }}</p>
                         </div>


                         <button class="btn btnCreate"
                              @click="isOpenCreateOtherActivities = !isOpenCreateOtherActivities, active = true"><i
                                   class="fas fa-plus-circle" style="font-size: 15px;"></i> Thêm hoạt động</button>

                    </div>
                    <div class="scrollTable">
                         <div class="scrollTable-content">
                              <table class="table activitiesList" v-if="loaded">
                                   <thead>
                                        <tr>
                                             <th class="centerclass" style=" padding-right: 2px;">STT</th>
                                             <th class="centerclass">Mã</th>
                                             <th>Tên hoạt động</th>
                                             <th class="">Số lần được thực hiện</th>
                                             <th></th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(activity, i ) in activitiesList" :key="i">
                                             <td class="centerclass" data-label="STT">{{ i + 1 }}</td>
                                             <td class="centerclass" data-label="Mã">{{ activity.OtherActivities_id }}</td>
                                             <td data-label="Tên hoạt động">{{ activity.OtherActivities_name }}</td>
                                             <td data-label="Số lần được thực hiệnSTT">{{ activity.Times.length }}</td>

                                             <td data-label="Tùy chọn" style="padding: 2px ;">
                                                  <button type="button" class="btn btn-sm btnMore option1"
                                                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                       <i class="fas fa-ellipsis-v"></i>
                                                  </button>
                                                  <div class="dropdown-menu option1">
                                                       <a class="dropdown-item action"
                                                            @click="setActivityChoosen(activity), isOpenUpdateActivities = !isOpenUpdateActivities, active = true">
                                                            <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                       </a>
                                                       <a class="dropdown-item" href="#"
                                                            @click="setActivityChoosen(activity), isOpenConfirm = !isOpenConfirm, active = true">
                                                            <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                       </a>
                                                  </div>
                                                  <div class="option2">
                                                       <button class="btn btnMore"
                                                            @click="setActivityChoosen(activity), isOpenUpdateActivities = !isOpenUpdateActivities">
                                                            <span class="fas fa-edit actionIcon"></span> Chỉnh sửa</button>
                                                       <button class="btn btnMore"
                                                            @click="setActivityChoosen(activity), isOpenConfirm = !isOpenConfirm">
                                                            <span class="fas fa-trash-alt actionIcon"></span> Xóa</button>
                                                  </div>
                                             </td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>
                    </div>

                    <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->



               </div>
          </div>
          <div class="confirmationDialog" v-if="isOpenConfirm">
               <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelConfirm">
                    <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
               </p>
               <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                    @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteOtherActivity(activityChosen)">Xóa</button>
               <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                    @click="isOpenConfirm = !isOpenConfirm, active = false">Hủy</button>
          </div>

          <div class="messageDialog" v-if="isOpenMessage">
               <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                    {{
                         message
                    }}
               </p>
               <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                    @click="isOpenMessage = !isOpenMessage, active = false">OK</button>
          </div>

          <CreateOtherActivityForm v-if="isOpenCreateOtherActivities" :newOtherActivities="newOtherActivities"
               @addOtherActivities-submit="createOtherActivity" :message1="message1" :message2="message2" />

          <UpdateOtherActivityForm v-if="isOpenUpdateActivities" :newOtherActivities="activityChosen"
               @updateOtherActivities-submit="updateOtherActivity" :message1="message1" :message2="message2" />
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>


import { mapGetters, mapMutations } from "vuex";
import ActivityDetailsService from '@/services/activityDetails.service';
import OtherActivitiesService from '@/services/otherActivities.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import UpdateOtherActivityForm from '@/components/catalogManagementComponents/updateOtherActvitiesForm.vue'
import CreateOtherActivityForm from '@/components/catalogManagementComponents/createNewOtherActivities.vue';

export default {
     name: "ArableLandManagement",
     components: {
          Catalog,
          TopHeader,
          Preloader,
          CreateOtherActivityForm,
          UpdateOtherActivityForm,
     },

     data() {
          return {
               loading: true,
               loaded: false,
               message1: " ",
               message2: " ",
               message: "",
               nameToSearch: "",
               isOpenInput2: false,
               isOpenInput1: false,
               isOpenMessage: false,
               isOpenConfirm: false,
               activityChosen: {},
               activitiesList: [],
               newOtherActivities: {},
               cloneActivitiesList: [],
               isOpenUpdateActivities: false,
               isOpenCreateOtherActivities: false,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               active: false,
          }
     },

     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },
     methods: {
          ...mapMutations([
               "initEmployeeState"
          ]),

          filteredList() {
               return this.cloneActivitiesList.filter(activities => {
                    return activities.OtherActivities_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          async loadData(){
               this.loading= true;
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
          },

          async retrieveOtherActivities() {
               this.loaded = false;
               const [err, respone] = await this.handle(
                    OtherActivitiesService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.activitiesList = respone.data;
                    this.cloneActivitiesList = respone.data;
                    var i = 0;
                    this.cloneActivitiesList.forEach(activity => {
                         this.activitiesList[i].Times = new Array();
                         this.findActivityTimes(activity.OtherActivities_id, i)
                         i++;
                    });
                    var temp = (String(this.activitiesList[this.activitiesList.length - 1].OtherActivities_id)).split("");
                    var id = "";
                    temp.forEach(element => {
                         if (element != "O" && element != "A") {
                              for (let index = temp.indexOf(element); index < temp.length; index++) {
                                   id += temp[index];
                                   break;
                              }
                         }
                    });
                    if (id < 9) {
                         this.newOtherActivities.OtherActivities_id = "OA0000000" + String(Number(id) + 1);
                    }
                    else if (id >= 9 && id < 99) {
                         this.newOtherActivities.OtherActivities_id = "OA000000" + String(Number(id) + 1);
                    }
                    else if (id >= 99 && id < 999) {
                         this.newOtherActivities.OtherActivities_id = "OA00000" + String(Number(id) + 1);
                    }
                    else {
                         this.newOtherActivities.OtherActivities_id = "OA00" + String(Number(id) + 1);
                    }

               }
               this.loaded = true;

          },

          async findActivityTimes(activityId, position) {
               const [err, respone] = await this.handle(
                    ActivityDetailsService.findById(activityId)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    respone.data.forEach(times => {
                         this.activitiesList[position].Times.push(times);
                    });
               }
          },

          async createOtherActivity(data) {
               this.message1 = "";
               this.message2 = "";
               if (!data.close) {
                    this.isOpenCreateOtherActivities = false;
                    this.active = false;
               }
               else {
                    const [error, response] = await this.handle(
                         OtherActivitiesService.create(data)
                    );
                    if (response.data == error) {
                         this.message1 = "Thêm không thành công.";
                    }
                    else if (response.data == "Không thể tạo chi tiết hoạt động mới.") {
                         this.message1 = "Thêm không thành công.";
                    }
                    else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveOtherActivities();
                    }
               }

          },

          async updateOtherActivity(data) {
               if (!data.close) {
                    this.isOpenUpdateActivities = false;
                    this.message1 = "";
                    this.message2 = "";
                    this.active = false;
               }
               else {
                    const [error, response] = await this.handle(
                         OtherActivitiesService.update(this.activityChosen.OtherActivities_id, data)
                    );
                    if (response.data == error) {
                         this.message1 = "Cập nhật không thành công.";
                    }
                    else if (response.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công.";
                    }
                    else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveOtherActivities();
                    }
               }
          },

          async deleteOtherActivity(activity) {
               const [error, response] = await this.handle(
                    OtherActivitiesService.delete(activity.OtherActivities_id)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa hoạt động không thành công";
               } else if (response.data == "Lỗi trong quá trình xóa hoạt động!!") {
                    this.message = "Xóa hoạt động không thành công";
               }
               else {
                    this.message = "Xóa hoạt động thành công";
                    this.retrieveOtherActivities();
               }
          },

          async searchName(data) {
               this.nameToSearch = data;
               if (data != "") {
                    this.activitiesList = [];
                    this.cloneActivitiesList.forEach(element => {
                         if (element.OtherActivities_name == data) {
                              this.activitiesList.push(element);
                         }
                    });
                    if (this.activitiesList.length == 0) {
                         const [errors, responses] = await this.handle(OtherActivitiesService.findByName(this.nameToSearch));
                         if (errors) {
                              console.log(errors);
                         } else {
                              if (responses.data.length > 0) {
                                   this.activitiesList = responses.data;

                              }
                              else {
                                   this.isOpenMessage = !this.isOpenMessage;
                              }
                         }
                         if (this.activitiesList.length > 0) {
                              var i = 0;
                              this.activitiesList.forEach(element => {
                                   this.activitiesList[i].Times = new Array();
                                   this.findActivityTimes(element.OtherActivities_id, i);
                                   i++;
                              });
                         }
                    }

               }
               else {
                    this.retrieveOtherActivities();
               }

          },

          async setActivityChoosen(activity) {
               this.activityChosen = activity;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveOtherActivities();
          this.loadData();
     }
}
</script>

<style>
@import url(../../assets/activitiesDetailStyle.css);
@import url(../../assets/mainStyle.css);
</style>