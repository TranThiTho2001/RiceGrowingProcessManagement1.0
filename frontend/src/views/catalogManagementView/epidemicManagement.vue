<template>
     <div class="container-fluid epidemicManagement" style="height:max-content !important;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row epidemicManagementFrame" style="height: max-content;" v-if="!loading"  :class="{ active: active }">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }" style="z-index: 8;">
                    <Catalog />
               </div>

               <div class="right rightEpidemicManagement ">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Dịch bệnh</h3>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row row-inputSearch">
                         <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                              @click="retrieveEpidemicList, isOpenInput1 = true"
                              @keyup.enter="searchName(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>


                         <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="epidemic in filteredList()" :key="epidemic.Epidemic_id"
                                   @click="searchName(epidemic.Epidemic_name), away()">
                                   {{ epidemic.Epidemic_name }}</p>
                         </div>
                         <button class="btn btnCreate" @click="openCreate = !openCreate, active= true"><i class="fas fa-plus-circle pt-1"
                                   style="font-size: 20px;"></i> Thêm bệnh dịch</button>
                    </div>
                    <div class="scrollTable">
                         <div class="scrollTable-content">
                              <table class="table epidemicList">
                                   <thead>
                                        <tr>
                                             <th class="centerclass" style=" padding-right: 2px;">STT</th>
                                             <th>Mã</th>
                                             <th>Tên</th>
                                             <th style="width: 100px;" class="centerclass">Thời điểm</th>
                                             <th>Môi trường phát triển</th>
                                             <th>Tác hại</th>
                                             <th style="width: 96px;" class="centerclass">Phân loại</th>
                                             <th></th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(epidemic, i ) in epidemicList" :key="i">
                                             <td class="centerclass" data-label="STT">{{ i + 1 }}</td>
                                             <td data-label="Mã">{{ epidemic.Epidemic_id }}</td>
                                             <td data-label="Tên">{{ epidemic.Epidemic_name }}</td>
                                             <td data-label="Thời điểm" class="centerclass">{{
                                                  epidemic.Epidemic_timeOfDevelopment }}</td>
                                             <td data-label="Môi trường phát triển">{{
                                                  epidemic.Epidemic_developmentEnvironment }}</td>
                                             <td data-label="Tác hại">{{ epidemic.Epidemic_Harm }}
                                             </td>
                                             <td data-label="Phân loại" class="centerclass">{{
                                                  epidemic.EpidemicClassification_name }}</td>
                                             <td data-label="Tùy chọn" class="">
                                                  <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown"
                                                       aria-haspopup="true" aria-expanded="false">
                                                       <i class="fas fa-ellipsis-v"></i>
                                                  </button>
                                                  <div class="dropdown-menu">
                                                       <a class="dropdown-item action"
                                                            @click="setEpidemicChosen(epidemic), isOpenUpdateEpidemic = !isOpenUpdateEpidemic, active= true">
                                                            <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                       </a>
                                                       <a class="dropdown-item" href="#"
                                                            @click="setEpidemicChosen(epidemic), isOpenConfirm = !isOpenConfirm, active= true">
                                                            <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                       </a>
                                                  </div>
                                             </td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div>
                    </div>


               </div>
          </div>
          <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->

          <div class="confirmationDialog" v-if="isOpenConfirm">
               <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelConfirm">
                    <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
               </p>
               <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                    @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteEpidemic(epidemicChosen.Epidemic_id)">Xóa</button>
               <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                    @click="isOpenConfirm = !isOpenConfirm, active = false;">Hủy</button>
          </div>

          <div class="messageDialog" v-if="isOpenMessage">
               <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                    <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{
                         message
                    }}
               </p>
               <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                    @click="isOpenMessage = !isOpenMessage, active = false;">OK</button>
          </div>

          <CreateEpidemicForm v-if="openCreate" :newEpidemic="newEpidemic" @addEpidemic-submit="createEpidemic"
               :message1="message1" :message2="message2" />

          <UpdateEpidemicForm v-if="isOpenUpdateEpidemic" :newEpidemic="epidemicChosen"
               :epidemicClassificationList="epidemicClassificationList" @updateEpidemic-submit="updateEpidemic"
               :message1="message1" :message2="message2" />
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import EpidemicService from '../../services/epidemic.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import CreateEpidemicForm from '@/components/catalogManagementComponents/createNewEpidemicForm.vue';
import UpdateEpidemicForm from '@/components/catalogManagementComponents/updateEpidemicForm.vue';
import EpidemicClassificationService from '@/services/epidemicClassification.service';

class Epidemic {
     constructor(epidemic) {
          this.Epidemic_id = epidemic.Epidemic_id;
          this.Epidemic_name = epidemic.Epidemic_name;
     }
}

export default {
     name: "EpidemicManagement",
     components: {
          Catalog,
          TopHeader,
          Preloader,
          CreateEpidemicForm,
          UpdateEpidemicForm,
     },

     data() {
          return {
               message: "",
               message1: " ",
               message2: " ",
               loading: true,
               newEpidemic: {},
               nameToSearch: "",
               epidemicList: [],
               openCreate: false,
               isOpenInput1: false,
               isOpenInput2: false,
               epidemicChosen: {},
               isOpenMessage: false,
               isOpenConfirm: false,
               cloneEpidemicList: [],
               isOpenUpdateEpidemic: false,
               epidemicClassificationList: [],
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
               return this.cloneEpidemicList.filter(epidemic => {
                    return epidemic.Epidemic_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
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

          async retrieveEpidemicList() {
               const [err, respone] = await this.handle(
                    EpidemicService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.epidemicList = respone.data;
                    this.cloneEpidemicList = respone.data;
                    this.cloneEpidemicList.forEach(element => {
                         new Epidemic(element)
                    });
                    var temp = (String(this.epidemicList[this.epidemicList.length - 1].Epidemic_id)).split("");
                    var id = "";
                    for (let index = 0; index < temp.length; index++) {
                         const element = temp[index];
                         if (element != "E" && element != "C" & element != "0") {
                              for (let i = index; i < temp.length; i++) {
                                   id = id.concat(temp[i]);
                              }
                              break;
                         }
                    }
                    if (id < 9) {
                         this.newEpidemic.Epidemic_id = "EC0000000" + String(Number(id) + 1);
                    }
                    else if (id >= 9 && id < 99) {
                         this.newEpidemic.Epidemic_id = "EC000000" + String(Number(id) + 1);
                    }
                    else if (id >= 99 && id < 999) {
                         this.newEpidemic.Epidemic_id = "EC00000" + String(Number(id) + 1);
                    }
                    else {
                         this.newEpidemic.Epidemic_id = "EC00" + String(Number(id) + 1);
                    }
               }
          },

          async createEpidemic(data) {
               this.epidemicClassificationList.forEach(element => {
                    if (data.EpidemicClassification_name == element.EpidemicClassification_name) {
                         data.EpidemicClassification_id = element.EpidemicClassification_id;
                    }
               });

               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    const [error, respone] = await this.handle(
                         EpidemicService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo một dịch bệnh mới") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.newEpidemic = {};
                         this.retrieveEpidemicList();
                    }
               }
          },

          async updateEpidemic(data) {

               this.epidemicClassificationList.forEach(element => {
                    if (data.EpidemicClassification_name == element.EpidemicClassification_name) {
                         data.EpidemicClassification_id = element.EpidemicClassification_id;
                    }
               });
               if (data.close == false) {
                    this.isOpenUpdateEpidemic = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    const [error, respone] = await this.handle(
                         EpidemicService.update(data.Epidemic_id, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveEpidemicList();
                    }
               }
          },

          async deleteEpidemic(epidemicid) {
               const [error, response] = await this.handle(
                    EpidemicService.delete(epidemicid)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa bệnh dịch không thành công";
               } else {
                    this.retrieveEpidemicList()
                    console.log(response.data);
                    this.message = "Xóa bệnh dịch thành công";
               }
          },

          async retrieveEpidemicClassification() {
               const [error, response] = await this.handle(
                    EpidemicClassificationService.getAll()
               );
               if (error) {
                    console.log(error);
               } else {
                    this.epidemicClassificationList = response.data;
               }
          },

          async searchName(data) {
               this.nameToSearch = data;
               const [error, response] = await this.handle(EpidemicService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.epidemicList = response.data;
                    }
                    else {
                         this.message = "Không tìm thấy bệnh dịch!";
                    }
               }
          },

          async setEpidemicChosen(epidemic) {
               this.epidemicChosen = epidemic;
               this.epidemicChosen.EpidemicClassification_id = epidemic.EpidemicClassification_id;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveEpidemicClassification();
          this.retrieveEpidemicList();
          this.loadData();
     }
}
</script>

<style>
@import url(../../assets/mainStyle.css);
@import url(../../assets/epidemicStyle.css);
</style>