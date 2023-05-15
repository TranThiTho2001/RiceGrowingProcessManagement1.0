<template>
     <div class="container-fluid pesticideManagement pr-4" style="background-color: #EAEAEA; height: 100%;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row pesticideManagementFrame" style="min-height: 100%; background-color: !important #EAEAEA;"
               v-if="!loading" :class="{ active: active }">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>

               <div class="right rightPesticideManagement">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Thuốc trị bệnh dịch</h3>
                         </div>
                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row row-inputSearch">
                         <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                              @click="retrievePesticideList, isOpenInput1 = true"
                              @keyup.enter="searchName(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>

                         <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="pesticide in filteredList()" :key="pesticide.Pesticide_id"
                                   @click="searchName(pesticide.Pesticide_name), away()">
                                   {{ pesticide.Pesticide_name }}
                              </p>
                         </div>
                         <button class="btn btnCreate" @click="openCreate = !openCreate, active = true"
                              v-if="currentUser.Role_id == '02'">
                              <i class="fas fa-plus-circle" style="font-size: 15px;"></i>Thêm loại thuốc mới
                         </button>
                    </div>
                    <div class="scrollTable" v-if="!openCreate && !isOpenUpdatePesticide">
                         <div class="ol-class" style="--length: 5" role="list">
                              <a class="li-class " href="#popup1" v-for="(pesticide, j) in pesticideList" :key="j"
                                   @click="setPesticideChosen(pesticide, j)">
                                   <button type="button" class="btn btn-sm btnMoreSelection" data-toggle="dropdown"
                                        v-if="currentUser.Role_id == '02'" aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                   </button>
                                   <div class="dropdown-menu">
                                        <a class="dropdown-item action"
                                             @click="setPesticideChosen(pesticide, j), isOpenUpdatePesticide = !isOpenUpdatePesticide, active = true">
                                             <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                        </a>
                                        <a class="dropdown-item" href="#"
                                             @click="setPesticideChosen(pesticide, j), isOpenConfirm = !isOpenConfirm, active = true">
                                             <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                        </a>
                                   </div>
                                   <h5>{{ pesticide.Pesticide_name }}</h5>
                                   <div class="row">
                                        <div class="col-sm-5">
                                             <img class="img-fluid" :src="pesticide.url" style="height: 130px;">
                                        </div>
                                        <div class="col-sm-7">
                                             <p>{{ pesticide.Pesticide_uses }}</p>
                                        </div>
                                   </div>
                              </a>

                              <div id="popup1" class="overlay">
                                   <div class="popup">
                                        <a class="fas fa-times-circle" href="#"
                                             style="font-size: 25px; text-decoration: none; color:#B3B4BA; float: right;"></a>
                                        <h2>{{ pesticideChosen.Pesticide_name }}</h2>

                                        <div class="content">
                                             <div class="row" style="width:98%">
                                                  <div class="col-sm-3 text-center  align-self-center">
                                                       <img class="img-fluid" :src="pesticideChosen.url">
                                                  </div>
                                                  <div class="col-sm-8">
                                                       <h6 class="title-class">Nhà cung cấp</h6>
                                                       <p class="value-class">{{ pesticideChosen.Pesticide_supplier }}</p>

                                                       <h6 class="title-class mt-3">Thành phần</h6>
                                                       <p class="value-class">{{ pesticideChosen.Pesticide_component }}</p>

                                                       <h6 class="title-class mt-3">Đặc trị: </h6>
                                                       <p class="value-class" v-for="temp in pesticideChosen.Treatment"
                                                            :key="temp.Epidemic_id">{{ temp.Epidemic_name }}</p>
                                                  </div>
                                             </div>
                                             <h6 class="title-class mt-3">Công dụng</h6>
                                             <p class="value-class">{{ pesticideChosen.Pesticide_uses }}</p>
                                             <h6 class="title-class mt-2">Hướng dẫn sử dụng</h6>
                                             <p class="value-class">
                                                  {{ pesticideChosen.Pesticide_directionsForUse }}</p>
                                        </div>
                                   </div>
                              </div>
                         </div>
                    </div>
               </div>
          </div>
          <!-- ------------------------------ Confirm----------------------------- -->
          <div class="overlay2" v-if="isOpenConfirm">
               <div class="confirmationDialog" v-if="isOpenConfirm">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelConfirm">
                         <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                    </p>
                    <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                         @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteTreatments()">Xóa</button>
                    <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenConfirm = !isOpenConfirm, active = false">Hủy
                    </button>
               </div>
          </div>

          <div class="overlay2" v-if="isOpenMessage">
               <div class="messageDialog">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                         <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span>
                         {{ message }}
                    </p>
                    <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenMessage = !isOpenMessage, active = false">OK
                    </button>
               </div>
          </div>

          <div class="overlay2" v-if="openCreate">
               <CreatePesticideForm :newPesticide="newPesticide" :epidemicList="epidemicList"
                    @addPesticide-submit="createNewImage" :message1="message1" :message2="message2" />
          </div>

          <div class="overlay2" v-if="isOpenUpdatePesticide">
               <UpdatePesticideForm :newPesticide="pesticideChosen" :epidemicList="epidemicList"
                    :treatmentList="treatmentList" @updatePesticide-submit="updateImage" :message1="message1"
                    :message2="message2" />
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>

import axios from 'axios';
import { mapGetters, mapMutations } from "vuex";
import EpidemicService from '@/services/epidemic.service';
import TreatmentService from '@/services/treatment.service';
import PesticideService from '../../services/pesticide.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue'
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import UpdatePesticideForm from '@/components/catalogManagementComponents/updatePesticideForm.vue';
import CreatePesticideForm from '@/components/catalogManagementComponents/createNewPesticideForm.vue';

export default {
     name: "PesticideManagement",
     components: {
          Catalog,
          TopHeader,
          Preloader,
          CreatePesticideForm,
          UpdatePesticideForm,
     },

     data() {
          return {
               pesticideList: [],
               openCreate: false,
               newPesticide: {},
               message1: " ",
               message2: " ",
               loading: true,
               isOpenMessage: false,
               isOpenConfirm: false,
               pesticideChosen: {},
               isOpenUpdatePesticide: false,
               nameToSearch: "",
               message: "",
               isOpenInput1: false,
               isOpenInput2: false,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               clonePesticideList: [],
               treatment: [],
               epidemicList: [],
               treatmentList: [],
               cloneTreatmentList: [],
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
               return this.clonePesticideList.filter(pesticide => {
                    return pesticide.Pesticide_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
          },

          async loadData() {
               this.loading = true;
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
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
                    var i = 0;
                    this.pesticideList.forEach(element => {
                         if (element.Pesticide_image != null) {
                              element.url = require('@/images/' + element.Pesticide_image);
                         }
                         this.findTreatmentByPesticideId(element.Pesticide_id, i);
                         i++;
                    });

                    this.clonePesticideList = Array.from(this.pesticideList)
                    var temp = (String(this.pesticideList[this.pesticideList.length - 1].Pesticide_id)).split("");
                    var id = "";
                    for (let index = 0; index < temp.length; index++) {
                         const element = temp[index];
                         if (element != "P" && element != "E" & element != "0") {
                              for (let i = index; i < temp.length; i++) {
                                   id = id.concat(temp[i]);
                              }
                              break;
                         }
                    }
                    if (id < 9) {
                         this.newPesticide.Pesticide_id = "PE0000000" + String(Number(id) + 1);
                    }
                    else if (id >= 9 && id < 99) {
                         this.newPesticide.Pesticide_id = "PE000000" + String(Number(id) + 1);
                    }
                    else if (id >= 99 && id < 99) {
                         this.newPesticide.Pesticide_id = "PE00000" + String(Number(id) + 1);
                    }
                    else {
                         this.newPesticide.Pesticide_id = "PE00" + String(Number(id) + 1);
                    }
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
               }
          },

          async createPesticide(data) {
               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
               }
               else {
                    const [error, respone] = await this.handle(
                         PesticideService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo một thuốc trừ sâu bệnh hại mới") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         var temp = data.Treatment;
                         temp.forEach(element => {
                              var treatment = {};
                              treatment.Epidemic_id = element;
                              treatment.Pesticide_id = data.Pesticide_id;
                              this.createTreatment(treatment);
                         });
                         this.retrievePesticideList();
                    }
               }
          },

          async createTreatment(data) {
               const [error, respone] = await this.handle(
                    TreatmentService.create(data)
               );
               if (error) {
                    console.log(error);
                    console.log("Thêm không thành công.");
               } else if (respone.data == "Lỗi trong quá trình xử lý.") {
                    console.log("Thêm không thành công.");
               } else {
                    console.log("Thêm thành công.");

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
                              data.Pesticide_image = response.data.Image_link;
                              this.createPesticide(data);
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
                    this.message1 = " ";
                    this.message2 = " ";
                    this.active = false;
                    this.isOpenUpdatePesticide = false;
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
                              data.Pesticide_image = response.data.Image_link;
                              this.updatePesticide(data);
                              this.message2 = "Thêm thành công";
                         };

                         const fnFail = (error) => {
                              console.log(error);
                              this.message2 = "Thêm không thành công";
                         };
                    } else {
                         this.updatePesticide(data);
                    }
               }
          },

          async findTreatmentByPesticideId(data, i) {
               this.treatmentList = [];
               const [error, respone] = await this.handle(
                    TreatmentService.findByPesticideId(data)
               );
               if (error) {
                    console.log(error);
               } else if (respone.data != "Không tìm thấy.") {
                    this.treatmentList = respone.data;
                    this.pesticideList[i].Treatment = [];
                    this.treatmentList.forEach(element => {
                         this.pesticideList[i].Treatment.push(element);
                    });
               }
          },

          async updatePesticide(data) {
               this.message1 = " ";
               this.message2 = " ";
               const [error, respone] = await this.handle(
                    PesticideService.update(data.Pesticide_id, data)
               );
               if (error) {
                    console.log(error);
                    this.message1 = "Cập nhật không thành công."
               } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                    this.message1 = "Cập nhật không thành công."
               } else {
                    var templist = data.NewTreatment;
                    var temp = 0;
                    if (templist != null) {
                         templist.forEach(EpidemicID => {
                              console.log(this.pesticideList[this.pesticideChosen.position])
                              if (this.pesticideList[this.pesticideChosen.position].Treatment != null) {
                                   this.pesticideList[this.pesticideChosen.position].Treatment.forEach(element => {
                                        if (element.Epidemic_id == EpidemicID) {
                                             temp = 1;
                                        }
                                   });
                              }
                              if (temp == 0) {
                                   var treatment = {};
                                   treatment.Epidemic_id = EpidemicID;
                                   treatment.Pesticide_id = data.Pesticide_id;
                                   this.createTreatment(treatment);
                              }
                              temp = 0;
                         });
                    }

                    temp = 0;
                    if (this.pesticideList[this.pesticideChosen.position].Treatment != null) {
                         this.pesticideList[this.pesticideChosen.position].Treatment.forEach(element => {
                              if (data.NewTreatment != null) {
                                   data.NewTreatment.forEach(EpidemicID => {
                                        if (element.Epidemic_id == EpidemicID) {
                                             temp = 1;
                                        }
                                   });
                                   if (temp == 0) {
                                        this.deleteTreatment(data.Pesticide_id, element.Epidemic_id);
                                   }
                                   temp = 0;
                              }
                              else {
                                   this.deleteTreatment(element.Pesticide_id, element.Epidemic_id);
                              }
                         });
                    }
                    this.message2 = "Cập nhật thành công.";
                    this.retrievePesticideList();
               }
          },

          async deleteTreatment(pesticideid, epidemicid) {
               const [error, response] = await this.handle(
                    TreatmentService.delete(pesticideid, epidemicid)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrievePesticideList()
                    console.log(response.data);
               }
          },

          async deleteTreatments() {
               this.message = '';
               if (this.pesticideChosen.Treatment != null) {
                    this.pesticideChosen.Treatment.forEach(element => {
                         this.deleteTreatment(this.pesticideChosen.Pesticide_id, element.Epidemic_id);
                    });
               }
               this.deletePesticide(this.pesticideChosen.Pesticide_id);
          },


          async deletePesticide(pesticideid) {
               this.message = '';
               const [error, response] = await this.handle(
                    PesticideService.delete(pesticideid)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa thông tin loại thuốc trị bệnh dịch không thành công";
               } else {
                    this.retrievePesticideList()
                    console.log(response.data);
                    this.message = "Xóa thông tin loại thuốc trị bệnh dịch thành công";
               }
          },

          async searchName(data) {
               this.nameToSearch = data;
               const [error, response] = await this.handle(PesticideService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.pesticideList = response.data;
                         this.pesticideList.forEach(element => {
                              if (element.Pesticide_image != null) {
                                   element.url = require('@/images/' + element.Pesticide_image);
                              }
                         });
                    } else {
                         this.isOpenMessage = !this.isOpenMessage;
                    }
               }
          },

          async setPesticideChosen(pesticide, i) {
               this.pesticideChosen = pesticide;
               this.pesticideChosen.position = i;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrievePesticideList();
          this.retrieveEpidemicList();
          this.loadData();
     }
}
</script>

<style>
@import url(../../assets/mainStyle.css);


.pesticideManagement .navigationBar .btnPesticide {
    display: block;
    width: 88%;
    font-size: 18px;
    background-color: #fff945;
    box-shadow: 4px 4px 2px rgba(0, 0, 0, 0.25);
    color: #5C5D22;
    border: none;
    font-family: 'Roboto';
    font-style: normal;
    border-radius: 14px;
}

.pesticideManagement .navigationBar .btnCatalog  {
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

.labelEpidemic{
    background-color: none;
    cursor: pointer;
    bottom: 0.1px;
    color: black;
    font-family: 'Roboto';
    font-style: normal;
    font-size:20px;
    padding: 0.1px;
    margin: 0.2px;
    font-weight: 400 !important;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>