<template>
     <div class="container-fluid riceCropManagement " style="background-color: #ebfff3;">
          <div class="row riceCropManagemenFrame">
               <div class="col-md-2 col-sm-12 leftRiceCropManagement">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10 rightRiceCropManagement">
                    <div class="row">
                         <div class="col-md-9"></div>
                         <div class="col-md-3">
                              <TopHeader :currentUserid="currentUser.Employee_id" />
                         </div>
                    </div>

                    <div class="row mt-1 mb-2">
                         <div class="col-sm-12">
                              <h2 class="text-center">Vụ mùa</h2>
                         </div>
                    </div>

                    <div class="row mr-2 ml-3">
                         <div class="col-sm-8"></div>
                         <div class="btnChoosePage col-sm-2">
                              <p style="display: inline-block; padding-top: 1px;text-align: right;" class="soTrang">
                                   Trang &nbsp;</p>
                              <div class="numberPage">
                                   <div class="dropdown">
                                        <button class="dropbtn">{{ currentPage }}
                                             <span class="fas fa-chevron-down"></span></button>
                                        <div class="dropdown-content">
                                             <a class="dropdown-item" v-for="(i, j) in num_pages() " :key="j"
                                                  v-bind:class="[i == currentPage ? 'active' : '']"
                                                  v-on:click="change_page(i)" aria-controls="my-table"> {{ i }}</a>
                                        </div>
                                   </div>
                              </div>
                         </div>
                         <div class="col-sm-2">
                              <button class="btn btnCreate" @click="openCreate = !openCreate"><i class="fas fa-plus-circle"
                                        style="font-size: 15px;"></i>Thêm mẫu ruộng</button>
                         </div>
                    </div>
                    <div class=" row riceCropList mt-1 ml-2 mr-2 justify-content-center">
                         <table class="table mt-1 ml-2 mr-2">
                              <thead>
                                   <tr>
                                        <th>STT</th>
                                        <th>Mã</th>
                                        <th>Tên mùa vụ</th>
                                        <th>Giống lúa</th>
                                        <th>Ngày xuống giống</th>
                                        <th style="vertical-align: bottom; text-align: center;">Trạng thái</th>
                                        <th>Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(ricecrop, i ) in get_rows()" :key="i" class="align-self-center">
                                        <td v-if="currentPage > 1">{{ i + ((currentPage - 1) * 6) }}</td>
                                        <td v-else>{{ i }}</td>
                                        <td>{{ ricecrop.RiceCropInformation_id }}</td>
                                        <td>{{ ricecrop.RiceCropInformation_name }}</td>
                                        <td>{{ ricecrop.Seed_id }}</td>
                                        <td v-if="ricecrop.RiceCropInformation_sowingDate == null"> </td>
                                        <td v-if="ricecrop.RiceCropInformation_sowingDate != null">{{
                                             formatDate(ricecrop.RiceCropInformation_sowingDate) }}</td>
                                        <td style="vertical-align: bottom; text-align: center;">
                                             <button class="btn btnMonitor"
                                                  v-if="ricecrop.RiceCropInformation_harvestDate == null">
                                                  Theo dõi
                                             </button>
                                             <button class="btn btnEnd" v-else>
                                                  Hoàn thành
                                             </button>
                                             <!-- <a :href="`https://www.google.com/maps/place/`+arableland.ArableLand_location">{{ arableland.ArableLand_location }}</a> -->
                                        </td>
                                        <td>
                                             <span class="action ml-2 ml-2"
                                                  @click="setRiceCropChoosen(ricecrop), isOpenUpdateRiceCrop = !isOpenUpdateRiceCrop">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class="action ml-4"
                                                  @click="setRiceCropChoosen(ricecrop), isOpenConfirm = !isOpenConfirm">
                                                  <span class="fas fa-trash-alt actionIcon"></span>
                                             </span>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>

                    
                    <div class="confirmationDialog" v-if="isOpenConfirm">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteRiceCrop(riceCropChoosen.RiceCropInformation_id)">Xóa</button>
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

                    <CreateRiceCropForm v-if="openCreate" :newRiceCrop="newRiceCrop" :seedList="seedList"
                         :arableLandList="arableLandList" @addRiceCrop-submit="createRiceCrop" :message1="message1"
                         :message2="message2" />
                    <UpdateRiceCropForm v-if="isOpenUpdateRiceCrop" :seedList="seedList" :newRiceCrop="riceCropChoosen"
                         :arableLandList="arableLandList" @updateRiceCrop-submit="updateRiceCrop" :message1="message1"
                         :message2="message2" />
               </div>
          </div>
</div>
</template>

<script>
import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import CropService from '@/services/crop.service';
import SeedService from '@/services/seed.service';
import ArableLandService from '@/services/arableLand.service';
import RiceCropService from '@/services/riceCropInformation.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import CreateRiceCropForm from '@/components/catalogManagementComponents/createNewRiceCropForm.vue';
import UpdateRiceCropForm from '@/components/catalogManagementComponents/updateRiceCropForm.vue';


export default {
     name: "HomePage",
     components: {
          Catalog,
          TopHeader,
          CreateRiceCropForm,
          UpdateRiceCropForm,
     },

     data() {
          return {
               riceCropList: [],
               cropList: [],
               seedList: [],
               arableLandList: [],
               openCreate: false,
               newRiceCrop: {},
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               riceCropChoosen: {},
               isOpenUpdateRiceCrop: false,
               nameToSearch: "",
               message: "",
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
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
                    if (this.riceCropList.length < 10) {
                         this.newRiceCrop.RiceCropInformation_id = "RCI000000" + (this.riceCropList.length + 1);
                    }
                    else if (this.riceCropList.length > 10 && this.riceCropList.length < 100) {
                         this.newRiceCrop.RiceCropInformation_id = "RCI00000" + (this.riceCropList.length + 1);
                    }
                    else if (this.riceCropList.length > 100 && this.riceCropList.length < 1000) {
                         this.newRiceCrop.RiceCropInformation_id = "RCI0000" + (this.riceCropList.length + 1);
                    }
               }
          },

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

          async setRiceCropChoosen(data){
               this.riceCropChoosen = data;
               this.seedList.forEach(element => {
                         if (data.Seed_id == element.Seed_id) {
                              data.Seed_id = element.Seed_name;
                         }
                    });

                    this.cropList.forEach(element => {
                         if (data.Crop_id == element.Crop_id) {
                              data.Crop_id = element.Crop_name;
                         }
                    });
          },

          async createRiceCrop(data) {
               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newRiceCrop = {};
                    this.retrieveRiceCropList();
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    this.seedList.forEach(element => {
                         if (data.Seed_id == element.Seed_name) {
                              data.Seed_id = element.Seed_id;
                         }
                    });

                    this.cropList.forEach(element => {
                         if (data.Crop_id == element.Crop_name) {
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
                              RiceCropService.create(data)
                         );
                         if (error) {
                              console.log(error);
                              this.message1 = "Thêm không thành công."
                         } else if (respone.data == "Không thể tạo vụ mùa lúa mới.") {
                              this.message1 = "Thêm không thành công."
                         } else {
                              this.message2 = "Thêm thành công.";
                              this.retrieveRiceCropList();
                         }
                    }
                    else {
                         this.message1 = "Thêm không thành công.";
                    }

               }
          },

          async updateRiceCrop(data) {
               if (data.close == false) {
                    this.isOpenUpdateRiceCrop = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newRiceCrop = {};
                    this.retrieveRiceCropList();
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    this.seedList.forEach(element => {
                         if (data.Seed_id == element.Seed_name) {
                              data.Seed_id = element.Seed_id;
                         }
                    });

                    this.cropList.forEach(element => {
                         if (data.Crop_id == element.Crop_name) {
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
                         } else if (respone.data == "Cập nhật thể tạo vụ mùa lúa mới.") {
                              this.message1 = "Cập nhật không thành công."
                         } else {
                              this.message2 = "Cập nhật thành công.";
                              this.retrieveRiceCropList();
                         }
                    }
                    else {
                         this.message1 = "Cập nhật không thành công.";
                    }

               }
          },

          async deleteRiceCrop(data){
               const [error, response] = await this.handle(
                   RiceCropService.delete(data)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrieveRiceCropList();
                    console.log(response.data);
                    this.message = "Xóa phân bón thành công"
               }
          },

          formatDate(data) {
               return (moment(String(data)).format("YYYY-MM-DD")).slice(0, 10);
          },
          //  so hang của danh sach danh muc
          get_rows() {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return this.riceCropList.slice(start, end);
          },

          // So trang cua danh sach danh muc
          num_pages() {
               return Math.ceil(this.riceCropList.length / this.elementsPerPage);

          },

          async change_page(page) {
               this.currentPage = page;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveRiceCropList();
          this.retrieveCropList();
          this.retrieveSeedList();
          this.retrieveArableLandList();
     }
}


</script>

<style>@import url(../../assets/riceCropStyle.css);</style>