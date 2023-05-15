<template>
     <div class="container-fluid fertilizerManagement pr-4 " style=" height: max-content;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>

          <div class="row fertilizerManagementFrame" style="height: 100vmin; background-color: #EAEAEA;" v-if="!loading"
               :class="{ active: active }">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>

               <div class="right rightFertilizerManagement ">
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
                         <button class="btn btnCreate" @click="openCreate = !openCreate, active = true"
                              v-if="currentUser.Role_id == '02'">
                              <i class="fas fa-plus-circle" style="font-size: 15px;"></i>Thêm phân bón
                         </button>
                    </div>
                    <div class="scrollTable">
                         <div class="ol-class" style="--length: 5" role="list">
                              <a class="li-class " href="#popup1" v-for="(fertilizer, j) in fertilizerList" :key="j"
                                   @click="setFertilizerChosen(fertilizer)">
                                   <button type="button" class="btn btn-sm btnMoreSelection" data-toggle="dropdown"
                                        v-if="currentUser.Role_id == '02'" aria-haspopup="true" aria-expanded="false">
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
                                   <h5>{{ fertilizer.Fertilizer_name }}</h5>
                                   <div class="row">
                                        <div style="width: 40%;">
                                             <img :src="fertilizer.url" class="img-fluid" style="height: 140px;">
                                        </div>
                                        <div style="width: 55%;">
                                             <p>{{ fertilizer.Fertilizer_uses }}</p>
                                        </div>
                                   </div>
                              </a>


                              <div id="popup1" class="overlay" v-if="!active && !isOpenUpdateFertilizer">
                                   <div class="popup">
                                        <a class="fas fa-times-circle" href="#"
                                             style="font-size: 25px; text-decoration: none; color:#B3B4BA; float: right;"></a>
                                        <h2>{{ fertilizerChosen.Fertilizer_name }}</h2>

                                        <div class="content">
                                             <div class="row" style="width: 98%;">
                                                  <div class="col-sm-2">
                                                       <img class="img-fluid" :src="fertilizerChosen.url"
                                                            style="height: 200px;">
                                                  </div>
                                                  <div class="col-sm-10">
                                                       <h6 class="title-class">Nhà cung cấp</h6>
                                                       <p class="value-class">{{ fertilizerChosen.Fertilizer_supplier }}</p>
                                                       <h6 class="title-class">Công dụng</h6>
                                                       <p class="value-class">{{ fertilizerChosen.Fertilizer_uses }}</p>
                                                  </div>
                                             </div>

                                             <h6 class="title-class">Thành phần</h6>
                                             <table class="table">
                                                  <tbody>
                                                       <tr>
                                                            <td></td>
                                                            <td class="title-class text-center">Đạm(N)</td>
                                                            <td class="title-class text-center">Lân(P)</td>
                                                            <td class="title-class text-center">Kali(K)</td>
                                                            <td class="title-class text-center">Khác</td>
                                                       </tr>
                                                       <tr>
                                                            <td class="value-class ">Tỉ lệ(%)</td>
                                                            <td class="value-class text-center"
                                                                 v-for="contain in fertilizerChosen.Contain"
                                                                 :key="contain.Nutrient_id">{{ contain.Contain_percent }}
                                                            </td>

                                                       </tr>
                                                  </tbody>
                                             </table>
                                             <h6 class="title-class">Hướng dẫn sử dụng</h6>
                                             <p class="value-class">{{ fertilizerChosen.Fertilizer_directionsForUse }}</p>
                                        </div>
                                   </div>
                              </div>
                         </div>
                    </div>
               </div>
          </div>
          <!-- ------------------------------confirm ----------------------------- -->

          <div class="overlay2" v-if="isOpenConfirm">
               <div class="confirmationDialog">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelConfirm">
                         <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                    </p>
                    <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                         @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteContains(fertilizerChosen)">Xóa</button>
                    <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenConfirm = !isOpenConfirm, active = false">Hủy</button>
               </div>
          </div>

          <div class="overlay2" v-if="isOpenMessage">
               <div class="messageDialog">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                         <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{
                              message
                         }}
                    </p>
                    <button class="btnOK btn btn-sm btn-outline-secondary"
                         @click="isOpenMessage = !isOpenMessage, active = false">OK</button>
               </div>
          </div>

          <div class="overlay2" v-if="openCreate">
               <CreateFertilizerForm :newFertilizer="newFertilizer" :nutrientList="nutrientList"
                    @addFertilizer-submit="createNewImage" :message1="message1" :message2="message2" />
          </div>

          <div class="overlay2" v-if="isOpenUpdateFertilizer">
               <UpdateFertilizerForm v-if="isOpenUpdateFertilizer" :newFertilizer="fertilizerChosen"
                    :nutrientList="nutrientList" @updateFertilizer-submit="updateImage" :message1="message1"
                    :message2="message2" />
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>


import { mapGetters, mapMutations } from "vuex";
import axios from 'axios';
import ContainService from '@/services/contain.service';
import NutrientService from '@/services/nutrient.service';
import FertilizerService from '../../services/fertilizer.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import UpdateFertilizerForm from '@/components/catalogManagementComponents/updateFertilizerForm.vue';
import CreateFertilizerForm from '@/components/catalogManagementComponents/createNewFertilizerForm.vue';


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
                    this.fertilizerList.forEach(fertilizer => {
                         if (fertilizer.Fertilizer_image != null) {
                              fertilizer.url = require('@/images/' + fertilizer.Fertilizer_image);
                         }
                    });

                    this.cloneFertilizerList.forEach(fertilizer => {
                         if (fertilizer.Fertilizer_image != null) {
                              fertilizer.url = require('@/images/' + fertilizer.Fertilizer_image);
                         }
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
                    } else if (id >= 9 && id < 99) {
                         this.newFertilizer.Fertilizer_id = "FR000000" + String(Number(id) + 1);
                    } else if (id >= 99 && id < 999) {
                         this.newFertilizer.Fertilizer_id = "FR00000" + String(Number(id) + 1);
                    } else {
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
               } else {
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
               }
          },

          async retrieveNutrientList() {
               const [err, respone] = await this.handle(
                    NutrientService.getAll()
               );
               if (err) {
                    console.log(err)
               } else {
                    this.nutrientList = respone.data;
               }
               this.retrieveFertilizerList();
          },

          async createFertilizer(data) {
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

          async createNewImage(data) {
               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
               }
               else {
                    if (data.Image != null) {
                         const formdata = require('form-data');
                         const formData = new formdata();
                         formData.append("image", data.Image);
                         axios.post('http://localhost:8080/api/image', formData, {
                              headers: {
                                   'Content-Type': `multipart/form-data;`,
                              }
                         },
                         ).then((response) => {
                              fnSuccess(response);
                         }).catch((error) => {
                              fnFail(error);
                         });

                         const fnSuccess = (response) => {
                              data.Fertilizer_image = response.data.Image_link;
                              this.createFertilizer(data);
                              this.message2 = "Thêm thành công";
                         };

                         const fnFail = (error) => {
                              console.log(error);
                              this.message2 = "Thêm không thành công";
                         };
                    } else {
                         this.message1 = "Vui lòng chọn hình ảnh!!"
                    }
               }
          },

          async updateImage(data) {
               if (data.close == false) {
                    this.isOpenUpdateFertilizer = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
               }
               else {
                    if (data.newImage != null) {
                         const formdata = require('form-data');
                         const formData = new formdata();
                         formData.append("image", data.newImage);
                         axios.post('http://localhost:8080/api/image', formData, {
                              headers: {
                                   'Content-Type': `multipart/form-data;`,
                              }
                         },
                         ).then((response) => {
                              fnSuccess(response);
                         }).catch((error) => {
                              fnFail(error);
                         });

                         const fnSuccess = (response) => {
                              data.Fertilizer_image = response.data.Image_link;
                              this.updateFertilizer(data);
                              this.message2 = "Thêm thành công";
                         };

                         const fnFail = (error) => {
                              console.log(error);
                              this.message2 = "Thêm không thành công";
                         };
                    } else {
                         this.updateFertilizer(data);
                    }
               }
          },

          async updateFertilizer(data) {
               console.log(data)
               if (data.close == false) {
                    this.isOpenUpdateFertilizer = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
               } else {
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
                         this.fertilizerList.forEach(fertilizer => {
                              if (fertilizer.Fertilizer_image != null) {
                                   fertilizer.url = require('@/images/' + fertilizer.Fertilizer_image);
                              }
                         });
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

<style style="scoped">
@import url(../../assets/fertilizerStyle.css);

@import url(../../assets/mainStyle.css);

.nutrient_class {
     width: 90px !important;
}
</style>