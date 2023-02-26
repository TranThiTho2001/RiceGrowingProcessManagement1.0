<template>
     <div class="container-fluid epidemicManagement pr-4" style="background-color: #EAEAEA;">
          <div class="row epidemicManagementFrame">
               <div class="col-md-2 col-sm-12 leftEpidemicManagement">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10 rightEpidemicManagement">
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
                                   <TopHeader :currentUserid="currentUser.Employee_id" />
                              </div>
                         </div>
                    </div>
                    <div class="row ml-2 mt-1">
                         <div class="col-sm-12  text-center">
                              <h2>BỆNH DỊCH GÂY HẠI LÚA</h2>
                         </div>
                    </div>
                    <div class="row ml-2 mr-2 mt-4 pb-1">
                         <div class="col-sm-12 text-right">
                              <button class="btn btnCreate" @click="openCreate = !openCreate"><i
                                        class="fas fa-plus-circle pt-1" style="font-size: 20px;"></i>Thêm bệnh dịch</button>
                         </div>
                    </div>
                    <div class=" row epidemicList mt-1 ml-2 mr-2 justify-content-center">
                         <table class="table mt-1 ml-2 mr-2">
                              <thead>
                                   <tr>
                                        <th>Mã</th>
                                        <th>Tên</th>
                                        <th>Thời điểm</th>
                                        <th>Môi trường phát triển</th>
                                        <th>Tác hại</th>
                                        <th>Phân loại</th>
                                        <th style="width: 8%;">Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(epidemic, i ) in get_rows(epidemicList)" :key="i">
                                        <td>{{ epidemic.Epidemic_id }}</td>
                                        <td style="width: 15%;">{{ epidemic.Epidemic_name }}</td>
                                        <td style="width: 10%;">{{ epidemic.Epidemic_timeOfDevelopment }}</td>
                                        <td class="text-truncate" style="max-width: 250px;">{{
                                             epidemic.Epidemic_developmentEnvironment }}</td>
                                        <td class="text-truncate" style="max-width: 250px;">{{ epidemic.Epidemic_Harm }}</td>
                                        <td style="width: 10%;">{{ epidemic.EpidemicsClassification_name }}</td>
                                        <td style="border-top: none;">
                                             <span class="action ml-2" style="display:inline ;border-top: none;"
                                                  @click="setEpidemicChoosen(epidemic), isOpenUpdateEpidemic = !isOpenUpdateEpidemic">
                                                  <span class="fas fa-edit actionIcon"></span>
                                             </span>
                                             <span class="action ml-4" style="display:inline ;border-top: none;"
                                                  @click="setEpidemicChoosen(epidemic), isOpenConfirm = !isOpenConfirm">
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
                                        <a class="page-link" href="#" @click="change_page('-', epidemicList)"
                                             aria-controls="my-table">{{
                                                  previous }}</a>
                                   </li>
                                   <li class="page-item"><a class="page-link" href="#"
                                             @click="change_page(currentPage - 1, epidemicList)" v-if="currentPage > 1">{{
                                                  currentPage - 1 }}</a></li>
                                   <li class="page-item active">
                                        <a class="page-link" style="background-color: #EEEA41; border-color: #EEEA41;"
                                             href="#">{{
                                                  currentPage }} <span class="sr-only">(current)</span></a>
                                   </li>
                                   <li class="page-item"><a class="page-link" href="#"
                                             v-if="currentPage < num_pages(epidemicList)"
                                             @click="change_page(currentPage + 1, epidemicList)">{{ currentPage + 1 }}</a>
                                   </li>
                                   <li class="page-item">
                                        <a class="page-link" href="#" @click="change_page('+', epidemicList)"
                                             v-if="currentPage < num_pages(epidemicList)">{{
                                                  next }}</a>
                                   </li>
                                   <li class="page-item disabled">
                                        <a class="page-link" href="#" v-if="currentPage >= num_pages(epidemicList)">{{ next
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
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteEpidemic(epidemicChoosen.Epidemic_id)">Xóa</button>
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

                    <CreateEpidemicForm v-if="openCreate" :newEpidemic="newEpidemic" @addEpidemic-submit="createEpidemic"
                         :message1="message1" :message2="message2" />

                    <UpdateEpidemicForm v-if="isOpenUpdateEpidemic" :newEpidemic="epidemicChoosen"
                         @updateEpidemic-submit="updateEpidemic" :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import EpidemicService from '../../services/epidemic.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import CreateEpidemicForm from '@/components/catalogManagementComponents/createNewEpidemicForm.vue';
import UpdateEpidemicForm from '@/components/catalogManagementComponents/updateEpidemicForm.vue';
export default {
     name: "EpidemicManagement",
     components: {
          Catalog,
          TopHeader,
          CreateEpidemicForm,
          UpdateEpidemicForm,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               previous: '<<',
               next: '>>',
               epidemicList: [],
               openCreate: false,
               newEpidemic: {},
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               epidemicChoosen: {},
               isOpenUpdateEpidemic: false,
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

          async retrieveEpidemicList() {
               const [err, respone] = await this.handle(
                    EpidemicService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.epidemicList = respone.data;
                    console.log(respone.data);
                    var temp = (String(this.epidemicList[this.epidemicList.length - 1].Epidemic_id)).split("");
                    var id = "";
                    for (let index = 0; index < temp.length; index++) {
                         const element = temp[index];
                         if (element != "E" && element != "C" & element != "0") {
                              for (let i = index; i < temp.length; i++) {
                                   id = id.concat(temp[i]);
                              }
                              break;
                         }
                    }

                    if (id < 9) {
                         this.newEpidemic.Epidemic_id = "EC0000000" + String(Number(id) + 1);
                    }
                    else if (id >= 9 && id < 99) {
                         this.newEpidemic.Epidemic_id = "EC000000" + String(Number(id) + 1);
                    }
                    else if (id >= 99 && id < 999) {
                         this.newEpidemic.Epidemic_id = "EC00000" + String(Number(id) + 1);
                    }
                    else {
                         this.newEpidemic.Epidemic_id = "EC00" + String(Number(id) + 1);
                    }
               }
          },

          async createEpidemic(data) {
               if (data.EpidemicsClassification_id == "Côn trùng") {
                    data.EpidemicsClassification_id = "ECC00001";
                    console.log(data.EpidemicsClassification_id);
               }
               else if (data.EpidemicsClassification_id == "Dịch bệnh") {
                    data.EpidemicsClassification_id = "ECC00002";
                    console.log(data.EpidemicsClassification_id);
               }
               else if (data.EpidemicsClassification_id == "Nấm hại") {
                    data.EpidemicsClassification_id = "ECC00003";
                    console.log(data.EpidemicsClassification_id);
               }
               else {
                    data.EpidemicsClassification_id = "ECC00004";
                    console.log(data.EpidemicsClassification_id);
               }
               if (data.close == false) {
                    this.openCreate = false;
                    this.message1 = " ";
                    this.message2 = " ";
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    const [error, respone] = await this.handle(
                         EpidemicService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo một dịch bệnh mới") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.newEpidemic = {};
                         this.retrieveEpidemicList();
                    }
               }
          },

          async updateEpidemic(data) {

               if (data.EpidemicsClassification_id == "Côn trùng" || data.EpidemicsClassification_id == "EC000001") {
                    data.EpidemicsClassification_id = "EC000001";
                    console.log(data.EpidemicsClassification_id);
               }
               else if (data.EpidemicsClassification_id == "Dịch bệnh" || data.EpidemicsClassification_id == "EC000002") {
                    data.EpidemicsClassification_id = "EC000002";
                    console.log(data.EpidemicsClassification_id);
               }
               else if (data.EpidemicsClassification_id == "Nấm hại" || data.EpidemicsClassification_id == "EC000003") {
                    data.EpidemicsClassification_id = "EC000003";
                    console.log(data.EpidemicsClassification_id);
               }
               else {
                    data.EpidemicsClassification_id = "EC000004";
                    console.log(data.EpidemicsClassification_id);
               }
               if (data.close == false) {
                    this.isOpenUpdateEpidemic = false;
                    this.message1 = " ";
                    this.message2 = " ";
               }
               else {
                    this.message1 = "";
                    this.message2 = "";
                    const [error, respone] = await this.handle(
                         EpidemicService.update(data.Epidemic_id, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveEpidemicList();
                    }
               }
          },

          async deleteEpidemic(epidemicid) {
               const [error, response] = await this.handle(
                    EpidemicService.delete(epidemicid)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrieveEpidemicList()
                    console.log(response.data);
                    this.message = "Xóa giống lúa thành công"
               }
          },


          async searchName() {
               const [error, response] = await this.handle(EpidemicService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.epidemicList = response.data;
                         console.log(response.data)
                    }
                    else {
                         this.message = "Không tìm thấy giống lúa!";
                         // this.isOpenMessage = !this.isOpenMessage;
                    }

               }
          },

          async setEpidemicChoosen(epidemic) {
               this.epidemicChoosen = epidemic;
               this.epidemicChoosen.EpidemicsClassification_id = epidemic.EpidemicsClassification_id;
               console.log(this.epidemicChoosen)
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
          this.retrieveEpidemicList();
     }
}
</script>

<style>
@import url(../../assets/epidemicStyle.css);
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