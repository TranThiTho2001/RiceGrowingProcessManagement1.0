<template>
     <div class="container-fluid pesticideManagement pr-4" style="background-color: #EAEAEA;">
          <div class="row pesticideManagementFrame">
               <div class="col-md-2 col-sm-12 leftPesticideManagement">
                    <div class="row">
                         <Catalog  />
                    </div>
               </div>
               <div class="col-md-10 rightPesticideManagement">
                    <div class="row ml-2 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="col-md-3">
                              <h3 class="name">Thuốc trị bệnh dịch</h3>
                         </div>
                         <div class="col-md-7 ">
                              <input type="text" class="form-control inputSearch1" placeholder="Tìm" 
                                   v-model="nameToSearch" @keyup.enter="searchName" />
                              <button class="btnSearch1" @click="searchName">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>
                         </div>

                         <div class="col-md-2 text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row ml-2 mr-2 mt-4  pt-3 pb-2">
                         <div class="col-sm-12 text-right">
                              <button class="btn btnCreate" @click="openCreate = !openCreate"><i
                                        class="fas fa-plus-circle" style="font-size: 15px;"></i> Thêm loại thuốc mới</button>
                         </div>
                    </div>
                    <div class=" row pesticideList mt-2 ml-2 mr-2 justify-content-center">
                         <table class="table mt-4 ml-2 mr-3">
                              <thead>
                                   <tr>
                                        <th class="text-center">STT</th>
                                        <th>Mã</th>
                                        <th>Tên</th>
                                        <th>Nhà cung cấp</th>
                                        <th>Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(pesticide, i ) in get_rows(pesticideList)" :key="i" class="align-self-center">
                                        <td v-if="currentPage > 1"  class="text-center">{{ i+ ((currentPage - 1) * 6)}}</td>
                                        <td v-else  class="text-center">{{ i }}</td>
                                        <td>{{ pesticide.Pesticide_id }}</td>
                                        <td>{{ pesticide.Pesticide_name }}</td>
                                        <td>{{ pesticide.Pesticide_supplier }}</td>
                                        <td class="">
                                             <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown" 
                                                  aria-haspopup="true" aria-expanded="false">
                                                  <i class="fas fa-ellipsis-v"></i>
                                             </button>
                                             <div class="dropdown-menu">
                                                  <a class="dropdown-item action"
                                                  @click="setPesticideChoosen(pesticide), isOpenUpdatePesticide = !isOpenUpdatePesticide">
                                                       <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                  </a>
                                                  <a class="dropdown-item" href="#"
                                                  @click="setPesticideChoosen(pesticide), isOpenConfirm = !isOpenConfirm">
                                                       <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                  </a>
                                             </div>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                         <nav aria-label="..." v-if="pesticideChoosen.length>6">
                         <ul class="pagination " aria-controls="my-table">
                              <li class="page-item disabled" v-if="currentPage == 1">
                                   <a class="page-link" href="#" aria-controls="my-table">{{ previous }}</a>
                              </li>
                              <li class="page-item " v-if="currentPage > 1">
                                   <a class="page-link" href="#" @click="change_page('-', pesticideList)" aria-controls="my-table">{{
                                        previous }}</a>
                              </li>
                              <li class="page-item"><a class="page-link" href="#" @click="change_page(currentPage - 1, pesticideList)"
                                        v-if="currentPage > 1">{{ currentPage - 1 }}</a></li>
                              <li class="page-item active">
                                   <a class="page-link" style="background-color: #EEEA41; border-color: #EEEA41;" href="#">{{
                                        currentPage }} <span class="sr-only">(current)</span></a>
                              </li>
                              <li class="page-item"><a class="page-link" href="#" v-if="currentPage < num_pages(pesticideList)"
                                        @click="change_page(currentPage + 1, pesticideList)">{{ currentPage + 1 }}</a></li>
                              <li class="page-item">
                                   <a class="page-link" href="#" @click="change_page('+', pesticideList)"
                                        v-if="currentPage < num_pages(pesticideList)">{{
                                             next }}</a>
                              </li>
                              <li class="page-item disabled">
                                   <a class="page-link" href="#" v-if="currentPage >= num_pages(pesticideList)">{{ next }}</a>
                              </li>
                         </ul>
                    </nav>
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
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue'
import CreatePesticideForm from '@/components/catalogManagementComponents/createNewPesticideForm.vue';
import UpdatePesticideForm from '@/components/catalogManagementComponents/updatePesticideForm.vue';
export default {
     name: "PesticideManagement",
     components: {
          Catalog,
          TopHeader,
          CreatePesticideForm,
          UpdatePesticideForm,
          
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               previous: '<<',
               next: '>>',
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
               isOpenSearch: false,
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
          get_rows(list) {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return list.slice(start, end);

          },

          // So trang cua danh sach danh muc
          num_pages(list) {
               return Math.ceil(list.length / this.elementsPerPage);
          },

          async change_page(page, list) {
               if (page == '-' && this.currentPage > 1) {
                    this.currentPage -= 1;
                    this.get_rows(list);
               }
               else if (page == '+' && this.currentPage < this.num_pages(list)) {
                    this.currentPage += 1;
                    this.get_rows(list);
               }
               else {
                    this.currentPage = page;
                    this.get_rows(list);
               }
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
nav {
     float: right;
}

 nav .pagination .page-link {
     color: #5C5D22;
     font-size: 17px;
}

nav{
     position: absolute;
     left:85%;
     top: 92%;
}
</style>