<template>
     <div class="container-fluid activitiesManagement pr-4" style="background-color: #EAEAEA;height: max-content;">
          <div class="row activitiesManagementFrame" style="height: 100vmin;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>
               <div class="rightActivitiesManagement right" :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="row ml-4 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Mẫu ruộng</h3>
                         </div>
                         <div class="">
                              <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                                   @click="retrieveOtherActivities, isOpenInput1 = true"
                                   @keyup.enter="searchName(nameToSearch)"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch1" @click="searchName(nameToSearch), away()"
                                   v-if="nameToSearch == '' && !isOpenSearch.open">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>

                              <input v-if="isOpenInput2 || (isOpenSearch.open)" autofocus type="text"
                                   class="form-control inputSearch2" placeholder="Tìm" style="width: 2%;"
                                   v-model="nameToSearch" @click="retrieveOtherActivities"
                                   @keyup.enter="searchName(nameToSearch), away()"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch2" @click="isOpenInput2 = !isOpenInput2">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>

                              <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                   <p class="item" v-for="activity in filteredList()" :key="activity.OtherActivities_name"
                                        @click="searchName(activity.OtherActivities_name), away()">
                                        {{ activity.OtherActivities_name }}</p>
                              </div>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row ml-4 mr-2 mt-3 pb-4 pt-2">
                         <div class="col-sm-12 text-right">
                              <button class="btn btnCreate"
                                   @click="isOpenCreateOtherActivities = !isOpenCreateOtherActivities"><i
                                        class="fas fa-plus-circle" style="font-size: 15px;"></i> Thêm hoạt động</button>
                         </div>
                    </div>
                    <div class=" row scrollTable">
                         <div class="col-sm-12 justify-content-center">
                              <table class="table activitiesList" v-if="loaded">
                                   <thead>
                                        <tr>
                                             <th class="text-center" style=" padding-right: 2px;">STT</th>
                                             <th class="text-center">Mã</th>
                                             <th>Tên hoạt động</th>
                                             <th>Số lần được thực hiện</th>
                                             <th></th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(activity, i ) in activitiesList" :key="i">
                                             <td class="text-center">{{ i + 1 }}</td>
                                             <td class="text-center">{{ activity.OtherActivities_id }}</td>
                                             <td>{{ activity.OtherActivities_name }}</td>
                                             <td>{{ activity.Times.length }}</td>

                                             <td class="">
                                                  <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown"
                                                       aria-haspopup="true" aria-expanded="false">
                                                       <i class="fas fa-ellipsis-v"></i>
                                                  </button>
                                                  <div class="dropdown-menu">
                                                       <a class="dropdown-item action"
                                                            @click="setActivityChoosen(activity), isOpenUpdateActivities = !isOpenUpdateActivities">
                                                            <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                       </a>
                                                       <a class="dropdown-item" href="#"
                                                            @click="setActivityChoosen(activity), isOpenConfirm = !isOpenConfirm">
                                                            <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                       </a>
                                                  </div>
                                             </td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>
                    </div>

                    <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->

                    <div class="confirmationDialog" v-if="isOpenConfirm">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteOtherActivity(activityChoosen)">Xóa</button>
                         <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                              @click="isOpenConfirm = !isOpenConfirm">Hủy</button>
                    </div>

                    <div class="messageDialog" v-if="isOpenMessage">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelThongBao">
                              <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{
                                   message
                              }}
                         </p>
                         <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                              @click="isOpenMessage = !isOpenMessage">OK</button>
                    </div>

                    <CreateOtherActivityForm v-if="isOpenCreateOtherActivities" :newOtherActivities="newOtherActivities"
                         @addOtherActivities-submit="createOtherActivity" :message1="message1" :message2="message2" />

                    <UpdateOtherActivityForm v-if="isOpenUpdateActivities" :newOtherActivities="activityChoosen"
                         @updateOtherActivities-submit="updateOtherActivity" :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import OtherActivitiesService from '@/services/otherActivities.service';
import ActivityDetailsService from '@/services/activityDetails.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import UpdateOtherActivityForm from '@/components/catalogManagementComponents/updateOtherActvitiesForm.vue'
import CreateOtherActivityForm from '@/components/catalogManagementComponents/createNewOtherActivities.vue';

export default {
     name: "ArableLandManagement",
     components: {
          Catalog,
          TopHeader,
          CreateOtherActivityForm,
          UpdateOtherActivityForm,
     },

     data() {
          return {
               activitiesList: [],
               isOpenCreateOtherActivities: false,
               newOtherActivities: {},
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               activityChoosen: {},
               isOpenUpdateActivities: false,
               nameToSearch: "",
               message: "",
               isOpenInput2: false,
               isOpenInput1: false,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               cloneActivitiesList: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },

               active: {
                    rightActive: false,
                    leftnNoneActive: false,
               },

               loaded: false,
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

          getWidth() {
               console.log(document.body.clientWidth)
               var width = document.body.clientWidth;
               if (width > 1300 && width < 1600) {
                    return true;
               }
               else {
                    return false;
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
                    this.newOtherActivities.OtherActivities_id = "OA" + String(Number(id) + 1);

               }
               this.loaded = true;
          },

          async findActivityTimes(activityId, position) {
               console.log(activityId)
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
               }
               else {
                    const [error, response] = await this.handle(
                         OtherActivitiesService.update(this.activityChoosen.OtherActivities_id, data)
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
               } else {
                    this.message = "Xóa hoạt động thành công"
                    this.retrieveOtherActivities()
                    console.log(response.data);
               }
          },


          async searchName(data) {
               this.nameToSearch = data;
               const [error, response] = await this.handle(OtherActivitiesService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.activitiesList = response.data;
                    }
                    else {
                         this.isOpenMessage = !this.isOpenMessage;
                    }
               }
          },

          async setActivityChoosen(activity) {
               this.activityChoosen = activity;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveOtherActivities();
     }
}
</script>

<style>
@import url(../../assets/mainStyle.css);
@import url(../../assets/activitiesDetailStyle.css);
</style>