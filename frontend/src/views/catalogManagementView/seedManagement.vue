<template>
     <div class="container-fluid seedManagement pr-4 pl-4" style="background-color: #EAEAEA;">
          <div class="row seedManagementFrame">
               <div class="col-md-2 col-sm-12 leftSeedManagement">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10 rightSeedManagement">
                    <div class="row mt-1 mb-2">
                         <div class="col-sm-12">
                              <h2 class="text-center">GIỐNG LÚA</h2>
                         </div>
                    </div>
                    <div class="row ml-3">
                         <div class="col-sm-8 input-group">
                              <div class="row">
                                   <input type="text" class="form-control col-md-10 inputSearch"
                                        placeholder="Tìm theo tên" style="border-radius:10px" v-model="nameToSearch"
                                        @keyup.enter="searchName" />
                                   <button class="btn mb-2 btnTimKiem" type="button"
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
                                        class="fas fa-plus-circle"></i>Thêm giống lúa</button>
                         </div>
                    </div>
                    <div class=" row seedList mt-1 ml-2 mr-2 justify-content-center">
                         <table class="table mt-1 ml-2 mr-2">
                              <thead>
                                   <tr>
                                        <th>Mã</th>
                                        <th>Tên</th>
                                        <th>Nhà cung cấp</th>
                                        <th>Đặc tính</th>
                                        <th style="width: 8%;">Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(seed, i ) in get_rows()" :key="i">
                                        <td>{{ seed.Seed_id }}</td>
                                        <td>{{ seed.Seed_name }}</td>
                                        <td style="width: max-content;">{{ seed.Seed_supplier }}</td>
                                        <td class="text-truncate" style="max-width: 520px;">{{ seed.Seed_characteristic }}</td>
                                        <td >
                                             <span class=" action mt-1 ml-2"
                                                  @click="setSeedChoosen(seed), isOpenUpdateSeed = !isOpenUpdateSeed">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class=" action mt-1 ml-4"
                                                  @click="setSeedChoosen(seed), isOpenConfirm = !isOpenConfirm">
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
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteSeed(seedChoosen.Seed_id)">Xóa</button>
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

                    <createSeedForm v-if="openCreate" :newSeed="newSeed" @addSeed-submit="createSeed"
                         :message1="message1" :message2="message2" />

                    <updateSeedForm v-if="isOpenUpdateSeed" :newSeed="seedChoosen" @updateSeed-submit="updateSeed"
                         :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import SeedService from '../../services/seed.service';
import createSeedForm from '@/components/catalogManagementComponents/createNewSeedForm.vue';
import updateSeedForm from '@/components/catalogManagementComponents/updateSeedForm.vue';
export default {
     name: "SeedManagement",
     components: {
          Catalog,
          createSeedForm,
          updateSeedForm,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               seedList: [],
               openCreate: false,
               newSeed: {},
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               seedChoosen: {},
               isOpenUpdateSeed: false,
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
                    var temp = (String(this.seedList[this.seedList.length - 1].Seed_id)).split("");
                    var id = "";
                    temp.forEach(element => {
                         if (element != "S" && element != "D" & element != "0") {
                              for (let index = temp.indexOf(element); index < temp.length; index++) {
                              id += temp[index];
                               break;
                             }
                         }
                    });

                    if (id < 10) {
                         this.newSeed.Seed_id = "SD0000000" + String(Number(id) + 1);
                    }
                    else if (id > 9 && id < 100) {
                         this.newSeed.Seed_id = "SD000000" + String(Number(id) + 1);
                    }
                    else if (id > 99 && id < 1000) {
                         this.newSeed.Seed_id = "SD00000" + String(Number(id) + 1);
                    }
                    else {
                         this.newSeed.Seed_id = "SD00" + String(Number(id) + 1);
                    }
               }
          },

          async createSeed(data) {
               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    const [error, respone] = await this.handle(
                         SeedService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo một giống lúa mới") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveSeedList();
                    }
               }
          },

          async updateSeed(data) {
               if (data.close == false) {
                    this.isOpenUpdateSeed = false;
                    this.message1 = " ";
                    this.message2 = " ";
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    const [error, respone] = await this.handle(
                         SeedService.update(data.Seed_id, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveSeedList();
                    }
               }
          },

          async deleteSeed(seedid) {
               const [error, response] = await this.handle(
                    SeedService.delete(seedid)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrieveSeedList()
                    console.log(response.data);
                    this.message = "Xóa giống lúa thành công"
               }
          },


          async searchName() {
               const [error, response] = await this.handle(SeedService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.seedList = response.data;
                         console.log(response.data)
                    }
                    else {
                         this.message = "Không tìm thấy giống lúa!";
                         this.isOpenMessage = !this.isOpenMessage;
                    }

               }
          },

          async setSeedChoosen(seed) {
               this.seedChoosen = seed;
               console.log(this.seedChoosen)
          },

          async gotoCreateNewSeed() {
               this.$router.push("/CreateNewSeed");
          },

          //  so hang của danh sach danh muc
          get_rows() {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return this.seedList.slice(start, end);
          },

          // So trang cua danh sach danh muc
          num_pages() {
               return Math.ceil(this.seedList.length / this.elementsPerPage);

          },

          async change_page(page) {
               this.currentPage = page;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveSeedList();
     }
}
</script>

<style>
@import url(../../assets/seedStyle.css);
</style>