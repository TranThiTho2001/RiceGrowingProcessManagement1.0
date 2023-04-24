<template>
     <div class="container-fluid fertilizerManagement pr-4 " style="background-color: #EAEAEA; height: max-content;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row fertilizerManagementFrame" style="height: 100vmin;" v-if="!loading" :class="{ active: active }">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>

               <div class="right rightFertilizerManagement " :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Phân bón</h3>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row row-inputSearch">
                         <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                              @click="retrieveFertilizerList, isOpenInput1 = true"
                              @keyup.enter="searchName(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>

                         <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="fertilizer in filteredList()" :key="fertilizer.Fertilizer_name"
                                   @click="searchName(fertilizer.Fertilizer_name), away()">
                                   {{ fertilizer.Fertilizer_name }}</p>
                         </div>
                         <button class="btn btnCreate" @click="openCreate = !openCreate, active = true"><i
                                   class="fas fa-plus-circle" style="font-size: 15px;"></i> Thêm phân bón</button>
                    </div>
                    <div class="scrollTable">
                         <div class="scrollTable-content">
                              <table class="table fertilizerList">
                                   <thead>
                                        <tr>
                                             <th class="text-center">STT</th>
                                             <th>Mã</th>
                                             <th>Tên</th>
                                             <th>Nhà cung cấp</th>
                                             <th>Thông tin thành phần</th>
                                             <th>Công dụng</th>
                                             <th>Hướng dẫn sử dụng</th>
                                             <th></th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(fertilizer, i ) in fertilizerList" :key="i" class="">
                                             <td data-label="STT" class="centerclass">{{ i + 1 }}</td>
                                             <td data-label="Mã">{{ fertilizer.Fertilizer_id }}</td>
                                             <td data-label="Tên">{{ fertilizer.Fertilizer_name }}</td>
                                             <td data-label="Nhà cung cấp">{{ fertilizer.Fertilizer_supplier }}</td>
                                             <td data-label="Thành phần">
                                                  <span v-for=" nutrient in fertilizer.Contain"
                                                       :key="nutrient.Nutrient_id">{{ nutrient.Nutrient_name }}: {{
                                                            nutrient.Contain_percent }}%<br></span>
                                             </td>
                                             <td data-label="Công dụng">{{ fertilizer.Fertilizer_uses }}</td>
                                             <td data-label="Hướng dẫn sử dụng">{{ fertilizer.Fertilizer_directionsForUse }}
                                             </td>
                                             <td data-label="M" class="centerclass" style="z-index: 1000;">
                                                  <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown"
                                                       aria-haspopup="true" aria-expanded="false">
                                                       <i class="fas fa-ellipsis-v"></i>
                                                  </button>
                                                  <div class="dropdown-menu">
                                                       <a class="dropdown-item action"
                                                            @click="setFertilizerChosen(fertilizer), isOpenUpdateFertilizer = !isOpenUpdateFertilizer, active = true">
                                                            <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                       </a>
                                                       <a class="dropdown-item" href="#"
                                                            @click="setFertilizerChosen(fertilizer), isOpenConfirm = !isOpenConfirm, active = true">
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
                    @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteContains(fertilizerChosen)">Xóa</button>
               <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                    @click="isOpenConfirm = !isOpenConfirm, active = false">Hủy</button>
          </div>

          <div class="messageDialog" v-if="isOpenMessage">
               <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                    <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{
                         message
                    }}
               </p>
               <button class="btnOK btn btn-sm btn-outline-secondary"
                    @click="isOpenMessage = !isOpenMessage, active = false">OK</button>
          </div>

          <CreateFertilizerForm v-if="openCreate" :newFertilizer="newFertilizer" :nutrientList="nutrientList"
               @addFertilizer-submit="createFertilizer" :message1="message1" :message2="message2" />

          <UpdateFertilizerForm v-if="isOpenUpdateFertilizer" :newFertilizer="fertilizerChosen" :nutrientList="nutrientList"
               @updateFertilizer-submit="updateFertilizer" :message1="message1" :message2="message2" />
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>


import { mapGetters, mapMutations } from "vuex";

import ContainService from '@/services/contain.service';
import NutrientService from '@/services/nutrient.service';
import FertilizerService from '../../services/fertilizer.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import UpdateFertilizerForm from '@/components/catalogManagementComponents/updateFertilizerForm.vue';
import CreateFertilizerForm from '@/components/catalogManagementComponents/createNewFertilizerForm.vue';

class Fertilizer {
     constructor(fertilizer) {
          this.Fertilizer_id = fertilizer.Fertilizer_id;
          this.Fertilizer_name = fertilizer.Fertilizer_name;
     }
}

export default {
     name: "FertilizerManagement",
     components: {
          Catalog,
          TopHeader,
          Preloader,
          CreateFertilizerForm,
          UpdateFertilizerForm,
     },

     data() {
          return {
               message: "",
               loading: true,
               message1: " ",
               message2: " ",
               nameToSearch: "",
               nutrientList: [],
               openCreate: false,
               newFertilizer: {},
               fertilizerList: [],
               isOpenInput2: false,
               isOpenInput1: false,
               isOpenMessage: false,
               isOpenConfirm: false,
               fertilizerChosen: {},
               cloneFertilizerList: [],
               isOpenUpdateFertilizer: false,

               isOpenSearch: {
                    open: false,
                    close: true,
               },

               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               containList: [],
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
               return this.cloneFertilizerList.filter(fertilizer => {
                    return fertilizer.Fertilizer_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          async loadData() {
               this.loading = true;
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
          },

          async retrieveFertilizerList() {
               const [err, respone] = await this.handle(
                    FertilizerService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.fertilizerList = respone.data;
                    this.cloneFertilizerList = respone.data;
                    this.cloneFertilizerList.forEach(element => {
                         new Fertilizer(element)
                    });
                    var temp = (String(this.fertilizerList[this.fertilizerList.length - 1].Fertilizer_id)).split("");
                    var id = "";
                    for (let index = 0; index < temp.length; index++) {
                         const element = temp[index];
                         if (element != "F" && element != "R" & element != "0") {
                              for (let i = index; i < temp.length; i++) {
                                   id = id.concat(temp[i]);
                              }
                              break;
                         }
                    }

                    if (id < 9) {
                         this.newFertilizer.Fertilizer_id = "FR0000000" + String(Number(id) + 1);
                    }
                    else if (id >= 9 && id < 99) {
                         this.newFertilizer.Fertilizer_id = "FR000000" + String(Number(id) + 1);
                    }
                    else if (id >= 99 && id < 999) {
                         this.newFertilizer.Fertilizer_id = "FR00000" + String(Number(id) + 1);
                    }
                    else {
                         this.newFertilizer.Fertilizer_id = "FR00" + String(Number(id) + 1);
                    }
                    this.newFertilizer.Contain = [];
                    var i = 0;
                    this.nutrientList.forEach(nutrient => {
                         this.newFertilizer.Contain[i] = {};
                         this.newFertilizer.Contain[i].Nutrient_name = nutrient.Nutrient_name;
                         this.newFertilizer.Contain[i].Nutrient_id = nutrient.Nutrient_id;
                         this.newFertilizer.Contain[i].Contain_percent = '0';
                         i++;
                    });
               }
               this.retrieveContain();
          },

          async retrieveContain() {
               const [err, respone] = await this.handle(
                    ContainService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.containList = respone.data;
                    console.log(this.containList);
                    this.fertilizerList.forEach(fertilizer => {
                         fertilizer.Contain = [];
                         this.containList.forEach(element => {
                              if (element.Fertilizer_id == fertilizer.Fertilizer_id) {
                                   var temp = {
                                        Nutrient_id: element.Nutrient_id,
                                        Nutrient_name: element.Nutrient_name,
                                        Contain_percent: element.Contain_percent,
                                   }
                                   fertilizer.Contain.push(temp);
                              }
                         });
                         if (fertilizer.Contain.length == 0) {
                              this.nutrientList.forEach(element => {
                                   var temp = {
                                        Nutrient_id: element.Nutrient_id,
                                        Nutrient_name: element.Nutrient_name,
                                        Contain_percent: '0',
                                        Fertilizer_id: fertilizer.Fertilizer_id,
                                   }
                                   fertilizer.Contain.push(temp);
                                   this.createContain(temp);
                              });
                         }
                    });
                    console.log(this.fertilizerList)
               }
          },

          async retrieveNutrientList() {
               const [err, respone] = await this.handle(
                    NutrientService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.nutrientList = respone.data;
               }
               this.retrieveFertilizerList();
          },

          async createFertilizer(data) {
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
                         FertilizerService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo một loại phân bón mới") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.newFertilizer = {}
                         this.retrieveFertilizerList();
                         data.Contain.forEach(contain => {
                              contain.Fertilizer_id = data.Fertilizer_id;
                              this.createContain(contain);
                         });
                    }
               }
          },

          async createContain(contain) {
               const [error, respone] = await this.handle(
                    ContainService.create(contain)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrieveFertilizerList();
                    console.log(respone.data)
               }
          },

          async updateFertilizer(data) {
               console.log(data)
               if (data.close == false) {
                    this.isOpenUpdateFertilizer = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    const [error, respone] = await this.handle(
                         FertilizerService.update(data.Fertilizer_id, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         data.Contain.forEach(element => {
                              this.updateContain(element, data.Fertilizer_id);
                         });
                    }
               }
          },

          async updateContain(data, fertilizer_id) {
               console.log(data)
               var newContain = {
                    Nutrient_id: data.Nutrient_id,
                    Contain_percent: data.Contain_percent,
                    Fertilizer_id: fertilizer_id,
               }
               const [error, respone] = await this.handle(
                    ContainService.update(fertilizer_id, data.Nutrient_id, newContain)
               );
               if (error) {
                    console.log(error);
                    this.message1 = "Cập nhật không thành công."
               } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                    this.message1 = "Cập nhật không thành công."
               } else {
                    this.message2 = "Cập nhật thành công.";
                    this.retrieveFertilizerList();
               }
          },
          async deleteContain(data, fertilizer_id) {
               const [error, response] = await this.handle(
                    ContainService.delete(fertilizer_id, data.Nutrient_id)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa  không thành công";
               } else {
                    console.log(response.data);
                    this.message = "Xóa thành công";
               }
          },

          async deleteContains(data) {
               data.Contain.forEach(element => {
                    this.deleteContain(element, data.Fertilizer_id);
               });
               this.deleteFertilizer(data);
          },

          async deleteFertilizer(data) {
                    console.log("t")
                    const [error, response] = await this.handle(
                         FertilizerService.delete(data.Fertilizer_id)
                    );
                    if (error) {
                         console.log(error);
                         this.message = "Xóa phân bón không thành công";
                    } else {
                         console.log(response.data);
                         this.message = "Xóa phân bón thành công";
                         this.retrieveFertilizerList();
                    }

          },


          async searchName(data) {
               this.nameToSearch = data;
               const [error, response] = await this.handle(FertilizerService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.fertilizerList = response.data;
                    }
                    else {
                         this.isOpenMessage = !this.isOpenMessage;
                    }
               }
          },

          async setFertilizerChosen(fertilizer) {
               this.fertilizerChosen = fertilizer;
          },

          async goToFertilizerDetail(fertilizer_id) {
               this.$router.push({ name: 'FertilizerDetail', params: { id: fertilizer_id } });
          }

     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveNutrientList();
          this.loadData();
     }
}
</script>

<style>
@import url(../../assets/fertilizerStyle.css);

@import url(../../assets/mainStyle.css);
</style>