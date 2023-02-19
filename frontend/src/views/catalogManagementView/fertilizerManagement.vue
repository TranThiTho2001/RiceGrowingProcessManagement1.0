<template>
     <div class="container-fluid fertilizerManagement pr-4 pl-4" style="background-color: #EAEAEA;">
          <div class="row fertilizerManagementFrame">
               <div class="col-md-2 col-sm-12 leftFertilizerManagement">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10 rightFertilizerManagement">
                    <div class="row mt-1 mb-2">
                         <div class="col-sm-12">
                              <h2 class="text-center">PHÂN BÓN</h2>
                         </div>
                    </div>
                    <div class="row ml-3">
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
                    <div class="row fertilizerList mt-1 ml-2 mr-2 justify-content-center">
                         <table class="table mt-1 ml-2 mr-2">
                              <thead>
                                   <tr>
                                        <th>STT</th>
                                        <th>Mã</th>
                                        <th>Tên</th>
                                        <th>Nhà cung cấp</th>
                                        <th><span class="ml-1">Tùy chọn</span></th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(fertilizer, i ) in get_rows()" :key="i" class="align-self-center">
                                        <td v-if="currentPage > 1">{{ i+ ((currentPage - 1) * 6)}}</td>
                                        <td v-else>{{ i }}</td>
                                        <td>{{ fertilizer.Fertilizer_id }}</td>
                                        <td>{{ fertilizer.Fertilizer_name }}</td>
                                        <td>{{ fertilizer.Fertilizer_supplier }}</td>
                                        <td>
                                             <span class="col-md-6 action mt-2 "
                                                  @click="setFertilizerChoosen(fertilizer), isOpenUpdateFertilizer = !isOpenUpdateFertilizer">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class="col-md-6 action mt-2"
                                                  @click="setFertilizerChoosen(fertilizer), isOpenConfirm = !isOpenConfirm">
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
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteFertilizer(fertilizerChoosen.Fertilizer_id)">Xóa</button>
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

                    <CreateFertilizerForm v-if="openCreate" :newFertilizer="newFertilizer"
                         @addFertilizer-submit="createFertilizer" :message1="message1" :message2="message2" />

                    <UpdateFertilizerForm v-if="isOpenUpdateFertilizer" :newFertilizer="fertilizerChoosen"
                         @updateFertilizer-submit="updateFertilizer" :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import FertilizerService from '../../services/fertilizer.service';
import CreateFertilizerForm from '@/components/catalogManagementComponents/createNewFertilizerForm.vue';
import UpdateFertilizerForm from '@/components/catalogManagementComponents/updateFertilizerForm.vue';
export default {
     name: "FertilizerManagement",
     components: {
          Catalog,
          CreateFertilizerForm,
          UpdateFertilizerForm,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               fertilizerList: [],
               openCreate: false,
               newFertilizer: {},
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               fertilizerChoosen: {},
               isOpenUpdateFertilizer: false,
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

          async retrieveFertilizerList() {
               const [err, respone] = await this.handle(
                    FertilizerService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.fertilizerList = respone.data;
                    console.log(respone.data);
                    var temp = (String(this.fertilizerList[this.fertilizerList.length - 1].Fertilizer_id)).split("");
                    var id = "";
                    temp.forEach(element => {
                         if (element != "F" && element != "R" & element != "0") {
                              id += element;
                         }
                    });

                    if (id < 10) {
                         this.newFertilizer.Fertilizer_id = "FR0000000" + String(Number(id) + 1);
                    }
                    else if (id > 9 && id < 100) {
                         this.newFertilizer.Fertilizer_id = "FR000000" + String(Number(id) + 1);
                    }
                    else if (id > 99 && id < 1000) {
                         this.newFertilizer.Fertilizer_id = "FR00000" + String(Number(id) + 1);
                    }
                    else {
                         this.newFertilizer.Fertilizer_id = "FR00" + String(Number(id) + 1);
                    }
               }
          },

          async createFertilizer(data) {
               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
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
                    }
               }
          },

          async updateFertilizer(data) {
               if (data.close == false) {
                    this.isOpenUpdateFertilizer = false;
                    this.message1 = " ";
                    this.message2 = " ";
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
                         this.retrieveFertilizerList();
                    }
               }
          },

          async deleteFertilizer(fertilizerid) {
               const [error, response] = await this.handle(
                    FertilizerService.delete(fertilizerid)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrieveFertilizerList()
                    console.log(response.data);
                    this.message = "Xóa phân bón thành công"
               }
          },


          async searchName() {
               const [error, response] = await this.handle(FertilizerService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.fertilizerList = response.data;
                         console.log(response.data)
                    }
                    else {
                         // this.message = "Không tìm thấy phân bón!";
                         this.isOpenMessage = !this.isOpenMessage;
                    }

               }
          },

          async setFertilizerChoosen(fertilizer) {
               this.fertilizerChoosen = fertilizer;
               console.log(this.fertilizerChoosen)
          },


          //  so hang của danh sach danh muc
          get_rows() {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return this.fertilizerList.slice(start, end);
          },

          // So trang cua danh sach danh muc
          num_pages() {
               return Math.ceil(this.fertilizerList.length / this.elementsPerPage);

          },

          async change_page(page) {
               this.currentPage = page;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveFertilizerList();
     }
}
</script>

<style>
@import url(../../assets/fertilizerStyle.css);
</style>