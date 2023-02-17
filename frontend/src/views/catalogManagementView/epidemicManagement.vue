<template>
     <div class="container-fluid epidemicManagement pr-4 pl-4" style="background-color: #ebfff3;">
          <div class="row epidemicManagementFrame">
               <div class="col-md-2 col-sm-12 leftEpidemicManagement">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10 rightEpidemicManagement">
                    <div class="row">
                         <div class="col-md-9"></div>
                         <div class="col-md-3">
                              <TopHeader :currentUserid="currentUser.Employee_id" />
                         </div>
                    </div>
                    <div class="row mt-1 mb-2">
                         <div class="col-sm-12">
                              <h2 class="text-center">BỆNH DỊCH</h2>
                         </div>
                    </div>
                    <div class="row ml-3 mr-2">
                         <div class="col-sm-8 input-group">
                              <div class="row">
                                   <input type="text" class="form-control col-md-10 inputSearch"
                                        placeholder="Tìm theo tên" style="border-radius:10px" v-model="nameToSearch"
                                        @keyup.enter="searchName" />
                                   <button class="btn  btnTimKiem mb-2" type="button"
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
                                   <tr v-for="(epidemic, i ) in get_rows()" :key="i">
                                        <td>{{ epidemic.Epidemic_id }}</td>
                                        <td style="width: 10%;">{{ epidemic.Epidemic_name }}</td>
                                        <td style="width: 10%;">{{ epidemic.Epidemic_timeOfDevelopment }}</td>
                                        <td>{{ epidemic.Epidemic_developmentEnvironment }}</td>
                                        <td>{{ epidemic.Epidemic_Harm }}</td>
                                        <td style="width: 10%;">{{ epidemic.EpidemicsClassification_name }}</td>
                                        <td  style="border-top: none;">
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

                    <CreateEpidemicForm v-if="openCreate" :newEpidemic="newEpidemic"
                         @addEpidemic-submit="createEpidemic" :message1="message1" :message2="message2" />

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
import TopHeader from '../../components/catalogManagementComponents/topHeader.vue'
import CreateEpidemicForm from '@/components/catalogManagementComponents/createNewEpidemicForm.vue';
import UpdateEpidemicForm from '@/components/catalogManagementComponents/updateEpidemicForm.vue';
export default {
     name: "EpidemicManagement",
     components: {
          Catalog,
          CreateEpidemicForm,
          TopHeader,
          UpdateEpidemicForm,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
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
               }
          },

          async createEpidemic(data) {
               if (data.EpidemicsClassification_id == "Côn trùng") {
                    data.EpidemicsClassification_id = "EC000001";
                    console.log(data.EpidemicsClassification_id);
               }
               else if (data.EpidemicsClassification_id == "Dịch bệnh") {
                    data.EpidemicsClassification_id = "EC000002";
                    console.log(data.EpidemicsClassification_id);
               }
               else if (data.EpidemicsClassification_id == "Nấm hại") {
                    data.EpidemicsClassification_id = "EC000003";
                    console.log(data.EpidemicsClassification_id);
               }
               else {
                    data.EpidemicsClassification_id = "EC000004";
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

          //  so hang của danh sach danh muc
          get_rows() {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return this.epidemicList.slice(start, end);
          },

          // So trang cua danh sach danh muc
          num_pages() {
               return Math.ceil(this.epidemicList.length / this.elementsPerPage);

          },

          async change_page(page) {
               this.currentPage = page;
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
</style>