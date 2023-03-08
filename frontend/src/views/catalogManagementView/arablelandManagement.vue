<template>
     <div class="container-fluid arablelandManagement pr-4" style="background-color: #EAEAEA;">
          <div class="row arablelandManagementFrame">
               <div class="col-md-2 col-sm-12 leftArableLandManagement">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>
               <div class="col-md-10 rightArableLandManagement">
                    <div class="row ml-2 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="col-md-7" v-if="!isOpenSearch">
                              <h3 class="name">Mẫu ruộng</h3>
                         </div>
                         <div class="col-md-2" v-if="isOpenSearch">
                              <h3 class="name">Mẫu ruộng</h3>
                         </div>
                         <div class="col-md-3 text-right" v-if="!isOpenSearch">
                              <input type="text" class="form-control col-sm-8 inputSearch1" placeholder="Tìm"
                                   v-model="nameToSearch" @keyup.enter="searchName"
                                   @click="isOpenSearch = !isOpenSearch" />
                              <button class="btnSearch1" @click="searchName">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>
                         </div>
                         <div class="col-md-8 " v-if="isOpenSearch">
                              <input type="text" class="form-control inputSearch2" placeholder="" 
                                   v-model="nameToSearch" @keyup.enter="searchName" />
                              <button class="btnSearch2" @click="searchName">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>
                         </div>

                         <div class="col-md-2 text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row ml-2 mr-2 mt-5 pt-4">
                         <div class="col-sm-12 text-right">
                              <button class="btn btnCreate" @click="openCreate = !openCreate"><i class="fas fa-plus-circle"
                                        style="font-size: 15px;"></i>Thêm mẫu ruộng</button>
                         </div>
                    </div>
                    <div class=" row arablelandList mt-1 ml-2 mr-3 justify-content-center">
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
                                   <tr v-for="(arableland, i ) in get_rows(arablelandList)" :key="i" class="align-self-center">
                                        <td class="text-center" v-if="currentPage > 1">{{ i + ((currentPage - 1) * elementsPerPage) }}</td>
                                        <td class="text-center" v-else>{{ i }}</td>
                                        <td>{{ arableland.ArableLand_id }}</td>
                                        <td>{{ arableland.ArableLand_area }}</td>
                                        <td>{{ arableland.ArableLand_owner }}</td>
                                        <td>{{ arableland.Soil_name }}</td>
                                        <td>
                                             <i class="fas fa-map-marker-alt"></i>
                                             <a
                                                  :href="`https://www.google.com/maps/place/` + arableland.ArableLand_location">{{
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
                         <nav aria-label="...">
                              <ul class="pagination " aria-controls="my-table">
                                   <li class="page-item disabled" v-if="currentPage == 1">
                                        <a class="page-link" href="#" aria-controls="my-table">{{ previous }}</a>
                                   </li>
                                   <li class="page-item " v-if="currentPage > 1">
                                        <a class="page-link" href="#" @click="change_page('-', arablelandList)"
                                             aria-controls="my-table">{{
                                                  previous }}</a>
                                   </li>
                                   <li class="page-item"><a class="page-link" href="#"
                                             @click="change_page(currentPage - 1, arablelandList)" v-if="currentPage > 1">{{
                                                  currentPage - 1 }}</a></li>
                                   <li class="page-item active">
                                        <a class="page-link" style="background-color: #EEEA41; border-color: #EEEA41;"
                                             href="#">{{
                                                  currentPage }} <span class="sr-only">(current)</span></a>
                                   </li>
                                   <li class="page-item"><a class="page-link" href="#"
                                             v-if="currentPage < num_pages(arablelandList)"
                                             @click="change_page(currentPage + 1, arablelandList)">{{ currentPage + 1 }}</a>
                                   </li>
                                   <li class="page-item">
                                        <a class="page-link" href="#" @click="change_page('+', arablelandList)"
                                             v-if="currentPage < num_pages(arablelandList)">{{
                                                  next }}</a>
                                   </li>
                                   <li class="page-item disabled">
                                        <a class="page-link" href="#" v-if="currentPage >= num_pages(arablelandList)">{{ next
                                        }}</a>
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
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import CreateArableLandForm from '@/components/catalogManagementComponents/createNewArableLandForm.vue';
import UpdateArableLandForm from '@/components/catalogManagementComponents/updateArableLandForm.vue';
export default {
     name: "ArableLandManagement",
     components: {
          Catalog,
          TopHeader,
          CreateArableLandForm,
          UpdateArableLandForm,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               previous: '<<',
               next: '>>',
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
                    for (let index = 0; index < temp.length; index++) {
                         const element = temp[index];
                         if (element != "A" && element != "L" & element != "0") {
                              for (let i = index; i < temp.length; i++) {
                                   id = id.concat(temp[i]);
                              }
                              break;
                         }
                    }

                    if (id < 9) {
                         this.newArableLand.ArableLand_id = "AL0000000" + String(Number(id) + 1);
                    }
                    else if (id >= 9 && id < 99) {
                         this.newArableLand.ArableLand_id = "AL000000" + String(Number(id) + 1);
                    }
                    else if (id >= 99 && id < 999) {
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
          this.retrieveArableLandList();
     }
}
</script>

<style>
@import url(../../assets/arablelandStyle.css);
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