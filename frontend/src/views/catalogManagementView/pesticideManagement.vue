<template>
     <div class="container-fluid pesticideManagement pr-4 pl-4" style="background-color: #EAEAEA;">
          <div class="row pesticideManagementFrame">
               <div class="col-md-2 col-sm-12 leftPesticideManagement">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10 rightPesticideManagement">

                    <div class="row mt-1 mb-2">
                         <div class="col-sm-12">
                              <h2 class="text-center">THUỐC TRỊ BỆNH DỊCH</h2>
                         </div>
                    </div>
                    <div class="row ml-3 mr-2">
                         <div class="col-sm-8 input-group">
                              <div class="row">
                                   <input type="text" class="form-control col-md-10 inputSearch"
                                        placeholder="Tìm theo tên" style="border-radius:10px" v-model="nameToSearch"
                                        @keyup.enter="searchName" />
                                   <button class="btn btnTimKiem mb-2" type="button"
                                        style="border:none; width: 10%" @click="searchName">
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
                              <button class="btn btnCreate" @click="openCreate = !openCreate"><i
                                        class="fas fa-plus-circle" style="font-size: 15px;"></i>Thêm phân bón</button>
                         </div>
                    </div>
                    <div class=" row pesticideList mt-1 ml-2 mr-2 justify-content-center">
                         <table class="table mt-1 ml-2 mr-2">
                              <thead>
                                   <tr>
                                        <th>STT</th>
                                        <th>Mã</th>
                                        <th>Tên</th>
                                        <th>Nhà cung cấp</th>
                                        <th>Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(pesticide, i ) in get_rows()" :key="i" class="align-self-center">
                                        <td v-if="currentPage > 1">{{ i+ ((currentPage - 1) * 6)}}</td>
                                        <td v-else>{{ i }}</td>
                                        <td>{{ pesticide.Pesticide_id }}</td>
                                        <td>{{ pesticide.Pesticide_name }}</td>
                                        <td>{{ pesticide.Pesticide_supplier }}</td>
                                        <td>
                                             <span class="action ml-2 ml-2"
                                                  @click="setPesticideChoosen(pesticide), isOpenUpdatePesticide = !isOpenUpdatePesticide">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class="action ml-4"
                                                  @click="setPesticideChoosen(pesticide), isOpenConfirm = !isOpenConfirm">
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
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deletePesticide(pesticideChoosen.Pesticide_id)">Xóa</button>
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

                    <CreatePesticideForm v-if="openCreate" :newPesticide="newPesticide"
                         @addPesticide-submit="createPesticide" :message1="message1" :message2="message2" />

                    <UpdatePesticideForm v-if="isOpenUpdatePesticide" :newPesticide="pesticideChoosen"
                         @updatePesticide-submit="updatePesticide" :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import PesticideService from '../../services/pesticide.service';
import CreatePesticideForm from '@/components/catalogManagementComponents/createNewPesticideForm.vue';
import UpdatePesticideForm from '@/components/catalogManagementComponents/updatePesticideForm.vue';
export default {
     name: "PesticideManagement",
     components: {
          Catalog,
          CreatePesticideForm,
          UpdatePesticideForm,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               pesticideList: [],
               openCreate: false,
               newPesticide: {},
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               pesticideChoosen: {},
               isOpenUpdatePesticide: false,
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

          async retrievePesticideList() {
               const [err, respone] = await this.handle(
                    PesticideService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.pesticideList = respone.data;
                    console.log(respone.data);
                    var temp = (String(this.pesticideList[this.pesticideList.length - 1].Pesticide_id)).split("");
                    var id = "";
                    temp.forEach(element => {
                         if (element != "P" && element != "E" & element != "0") {
                              for (let index = temp.indexOf(element); index < temp.length; index++) {
                              id += temp[index];
                               break;
                             }
                         }
                    });

                    if (id < 10) {
                         this.newPesticide.Pesticide_id = "PE0000000" + String(Number(id) + 1);
                    }
                    else if (id > 9 && id < 100) {
                         this.newPesticide.Pesticide_id = "PE000000" + String(Number(id) + 1);
                    }
                    else if (id > 99 && id < 1000) {
                         this.newPesticide.Pesticide_id = "PE00000" + String(Number(id) + 1);
                    }
                    else {
                         this.newPesticide.Pesticide_id = "PE00" + String(Number(id) + 1);
                    }
               }
          },

          async createPesticide(data) {
               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
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
                         this.retrievePesticideList();
                    }
               }
          },

          async updatePesticide(data) {
               if (data.close == false) {
                    this.isOpenUpdatePesticide = false;
                    this.message1 = " ";
                    this.message2 = " ";
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    const [error, respone] = await this.handle(
                         PesticideService.update(data.Pesticide_id, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrievePesticideList();
                    }
               }
          },

          async deletePesticide(pesticideid) {
               const [error, response] = await this.handle(
                    PesticideService.delete(pesticideid)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrievePesticideList()
                    console.log(response.data);
                    this.message = "Xóa phân bón thành công"
               }
          },


          async searchName() {
               const [error, response] = await this.handle(PesticideService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.pesticideList = response.data;
                         console.log(response.data)
                    }
                    else {
                         // this.message = "Không tìm thấy phân bón!";
                         this.isOpenMessage = !this.isOpenMessage;
                    }

               }
          },

          async setPesticideChoosen(pesticide) {
               this.pesticideChoosen = pesticide;
               console.log(this.pesticideChoosen)
          },


          //  so hang của danh sach danh muc
          get_rows() {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return this.pesticideList.slice(start, end);
          },

          // So trang cua danh sach danh muc
          num_pages() {
               return Math.ceil(this.pesticideList.length / this.elementsPerPage);

          },

          async change_page(page) {
               this.currentPage = page;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrievePesticideList();
     }
}
</script>

<style>
@import url(../../assets/pesticideStyle.css);
</style>