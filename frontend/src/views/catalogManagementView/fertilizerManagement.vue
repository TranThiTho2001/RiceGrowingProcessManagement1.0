<template>
     <div class="container-fluid fertilizerManagement pr-4 " style="background-color: #EAEAEA;">
          <div class="row fertilizerManagementFrame">
               <div class="col-md-2 col-sm-12 leftFertilizerManagement">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>
               <div class="col-md-10 rightFertilizerManagement">
                    <div class="row mr-2 mt-2 mb-4">                         
                         <div class="col-md-7 pr-5">
                              <div class="row">
                                   <input type="text" class="form-control col-sm-8 ml-4 pt-2 inputSearch"
                                        placeholder="Tìm theo tên" style="border-radius:10px" v-model="nameToSearch"
                                        @keyup.enter="searchName" />
                                   <button class=" btnSearch pt-2" @click="searchName">
                                        <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                                   </button>
                              </div>
                         </div>
                         <div class="col-md-3"></div>
                         <div class="col-md-2 pl-5 text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row ml-2 mt-1">
                         <div class="col-sm-12  text-center">
                              <h2>PHÂN BÓN</h2>
                         </div>
                    </div>
                    <div class="row ml-2 mt-4 pb-1 mr-1">
                         <div class="col-sm-12 text-right">
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
                                   <tr v-for="(fertilizer, i ) in get_rows(fertilizerList)" :key="i" class="align-self-center">
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
                         <nav aria-label="...">
                         <ul class="pagination " aria-controls="my-table">
                              <li class="page-item disabled" v-if="currentPage == 1">
                                   <a class="page-link" href="#" aria-controls="my-table">{{ previous }}</a>
                              </li>
                              <li class="page-item " v-if="currentPage > 1">
                                   <a class="page-link" href="#" @click="change_page('-', fertilizerList)" aria-controls="my-table">{{
                                        previous }}</a>
                              </li>
                              <li class="page-item"><a class="page-link" href="#" @click="change_page(currentPage - 1, fertilizerList)"
                                        v-if="currentPage > 1">{{ currentPage - 1 }}</a></li>
                              <li class="page-item active">
                                   <a class="page-link" style="background-color: #EEEA41; border-color: #EEEA41;" href="#">{{
                                        currentPage }} <span class="sr-only">(current)</span></a>
                              </li>
                              <li class="page-item"><a class="page-link" href="#" v-if="currentPage < num_pages(fertilizerList)"
                                        @click="change_page(currentPage + 1, fertilizerList)">{{ currentPage + 1 }}</a></li>
                              <li class="page-item">
                                   <a class="page-link" href="#" @click="change_page('+', fertilizerList)"
                                        v-if="currentPage < num_pages(fertilizerList)">{{
                                             next }}</a>
                              </li>
                              <li class="page-item disabled">
                                   <a class="page-link" href="#" v-if="currentPage >= num_pages(fertilizerList)">{{ next }}</a>
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
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import CreateFertilizerForm from '@/components/catalogManagementComponents/createNewFertilizerForm.vue';
import UpdateFertilizerForm from '@/components/catalogManagementComponents/updateFertilizerForm.vue';
export default {
     name: "FertilizerManagement",
     components: {
          Catalog,
          TopHeader,
          CreateFertilizerForm,
          UpdateFertilizerForm,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               previous: '<<',
               next: '>>',
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
          this.retrieveFertilizerList();
     }
}
</script>

<style>
@import url(../../assets/fertilizerStyle.css);
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