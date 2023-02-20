<template>
     <div class="container-fluid arablelandManagement pr-4" style="background-color: #EAEAEA;">
          <div class="row arablelandManagementFrame">
               <div class="col-md-2 col-sm-12 leftArableLandManagement">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10 rightArableLandManagement">
                    <div class="row mt-1 mb-2">
                         <div class="col-sm-12">
                              <h2 class="text-center">MẪU RUỘNG</h2>
                         </div>
                    </div>
                    <div class="row ml-3 mr-2">
                         <div class="col-sm-8 input-group">
                              <div class="row">
                                   <input type="text" class="form-control col-md-10 inputSearch" placeholder="Tìm theo tên"
                                        style="border-radius:10px" v-model="nameToSearch" @keyup.enter="searchName" />
                                   <button class="btn btnTimKiem mb-2" type="button" style="border:none; width: 10%"
                                        @click="searchName">
                                        <span class="fa fa-search" style="font-size:18px"></span>
                                   </button>
                              </div>
                         </div>
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
                    <div class=" row arablelandList mt-1 ml-2 mr-2 justify-content-center">
                         <table class="table mt-1 ml-2 mr-2">
                              <thead>
                                   <tr>
                                        <th>STT</th>
                                        <th>Mã</th>
                                        <th>Diện tích</th>
                                        <th>Chủ sỡ hưu</th>
                                        <th>Loại đất</th>
                                        <th>Vị trí</th>
                                        <th>Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(arableland, i ) in get_rows()" :key="i" class="align-self-center">
                                        <td v-if="currentPage > 1">{{ i + ((currentPage - 1) * 6) }}</td>
                                        <td v-else>{{ i }}</td>
                                        <td>{{ arableland.ArableLand_id }}</td>
                                        <td>{{ arableland.ArableLand_area }}</td>
                                        <td>{{ arableland.ArableLand_owner }}</td>
                                        <td>{{ arableland.Soil_name }}</td>
                                        <td>
                                             <i class="fas fa-map-marker-alt"></i>
                                             <a :href="`https://www.google.com/maps/place/` + arableland.ArableLand_location">{{
                                                  arableland.ArableLand_location }}</a>
                                        </td>
                                        <td>
                                             <span class="action ml-2 ml-2"
                                                  @click="setArableLandChoosen(arableland), isOpenUpdateArableLand = !isOpenUpdateArableLand">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class="action ml-4"
                                                  @click="setArableLandChoosen(arableland), isOpenConfirm = !isOpenConfirm">
                                                  <span class="fas fa-trash-alt actionIcon"></span>
                                             </span>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>
                    <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->

                    <div class="confirmationDialog" v-if="isOpenConfirm">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteArableLand(arablelandChoosen.ArableLand_id)">Xóa</button>
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

                    <CreateArableLandForm v-if="openCreate" :newArableLand="newArableLand"
                         @addArableLand-submit="createArableLand" :message1="message1" :message2="message2" />

                    <UpdateArableLandForm v-if="isOpenUpdateArableLand" :newArableLand="arablelandChoosen"
                         @updateArableLand-submit="updateArableLand" :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import ArableLandService from '../../services/arableLand.service';
import CreateArableLandForm from '@/components/catalogManagementComponents/createNewArableLandForm.vue';
import UpdateArableLandForm from '@/components/catalogManagementComponents/updateArableLandForm.vue';
export default {
     name: "ArableLandManagement",
     components: {
          Catalog,
          CreateArableLandForm,
          UpdateArableLandForm,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               arablelandList: [],
               openCreate: false,
               newArableLand: {},
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               arablelandChoosen: {},
               isOpenUpdateArableLand: false,
               nameToSearch: "",
               message: "",
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

          async retrieveArableLandList() {
               const [err, respone] = await this.handle(
                    ArableLandService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.arablelandList = respone.data;
                    console.log(respone.data);
                    var temp = (String(this.arablelandList[this.arablelandList.length - 1].ArableLand_id)).split("");
                    var id = "";
                    temp.forEach(element => {
                         if (element != "A" && element != "L" & element != "0") {
                              for (let index = temp.indexOf(element); index < temp.length; index++) {
                                   id += temp[index];
                                   break;
                              }
                         }
                    });

                    if (id < 10) {
                         this.newArableLand.ArableLand_id = "AL0000000" + String(Number(id) + 1);
                    }
                    else if (id > 9 && id < 100) {
                         this.newArableLand.ArableLand_id = "AL000000" + String(Number(id) + 1);
                    }
                    else if (id > 99 && id < 1000) {
                         this.newArableLand.ArableLand_id = "AL00000" + String(Number(id) + 1);
                    }
                    else {
                         this.newArableLand.ArableLand_id = "AL00" + String(Number(id) + 1);
                    }
               }
          },

          async createArableLand(data) {
               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    if (data.Soil_id == "Đất phù sa ven sông") {
                         data.Soil_id = "AL00000001";
                    }
                    else if (data.Soil_id == "Đất phù sa xa xông") {
                         data.Soil_id = "SL00000002";
                    }
                    else if (data.Soil_id == "Đất nhiễm phèn") {
                         data.Soil_id = "SL00000003";
                    }
                    else if (data.Soil_id == "Đất nhiễm mặn") {
                         data.Soil_id = "SL00000004";
                    }
                    else {
                         data.Soil_id = "SL00000005";
                    }
                    const [error, respone] = await this.handle(
                         ArableLandService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo một mẫu ruộng mới") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveArableLandList();
                    }
               }
          },

          async updateArableLand(data) {
               if (data.close == false) {
                    this.isOpenUpdateArableLand = false;
                    this.message1 = " ";
                    this.message2 = " ";
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    if (data.Soil_id == "Đất phù sa ven sông" || data.Soil_id == "AL00000001") {
                         data.Soil_id = "SL00000001";
                    }
                    else if (data.Soil_id == "Đất phù sa xa xông" || data.Soil_id == "AL00000002") {
                         data.Soil_id = "SL00000002";
                    }
                    else if (data.Soil_id == "Đất nhiễm phèn" || data.Soil_id == "AL00000003") {
                         data.Soil_id = "SL00000003";
                    }
                    else if (data.Soil_id == "Đất nhiễm mặn" || data.Soil_id == "AL00000004") {
                         data.Soil_id = "SL00000004";
                    }
                    else {
                         data.Soil_id = "SL00000005";
                    }
                    const [error, respone] = await this.handle(
                         ArableLandService.update(data.ArableLand_id, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveArableLandList();
                    }
               }
          },

          async deleteArableLand(arablelandid) {
               const [error, response] = await this.handle(
                    ArableLandService.delete(arablelandid)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrieveArableLandList()
                    console.log(response.data);
                    this.message = "Xóa phân bón thành công"
               }
          },


          async searchName() {
               const [error, response] = await this.handle(ArableLandService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.arablelandList = response.data;
                         console.log(response.data)
                    }
                    else {
                         // this.message = "Không tìm thấy phân bón!";
                         this.isOpenMessage = !this.isOpenMessage;
                    }

               }
          },

          async setArableLandChoosen(arableland) {
               this.arablelandChoosen = arableland;
               console.log(this.arablelandChoosen)
          },


          //  so hang của danh sach danh muc
          get_rows() {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return this.arablelandList.slice(start, end);
          },

          // So trang cua danh sach danh muc
          num_pages() {
               return Math.ceil(this.arablelandList.length / this.elementsPerPage);

          },

          async change_page(page) {
               this.currentPage = page;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveArableLandList();
     }
}
</script>

<style>
@import url(../../assets/arablelandStyle.css);
</style>