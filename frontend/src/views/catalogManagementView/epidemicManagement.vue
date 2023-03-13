<template>
     <div class="container-fluid epidemicManagement pr-4" style="background-color: #EAEAEA;">
          <div class="row epidemicManagementFrame">
               <div class="col-md-2 col-sm-12 leftEpidemicManagement">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>
               <div class="col-md-10 rightEpidemicManagement">
                    <div class="row ml-2 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="col-md-2">
                              <h3 class="name">Dịch bệnh</h3>
                         </div>
                         <div class="col-md-8 ">
                              <input type="text" class="form-control inputSearch1"  placeholder="Tìm" v-model="nameToSearch" 
                                   @click="retrieveEpidemicList()"
                                   @keyup.enter="searchName(nameToSearch)"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch1" @click="searchName(nameToSearch)"
                                   v-if="nameToSearch == '' && !isOpenSearch.open">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>
                              <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                   <p class="item" v-for="epidemic in filteredList()" :key="epidemic.Epidemic_id"
                                        @click="searchName(epidemic.Epidemic_name)">
                                        {{ epidemic.Epidemic_name }}</p>
                              </div>
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
                                        class="fas fa-plus-circle pt-1" style="font-size: 20px;"></i> Thêm bệnh dịch</button>
                         </div>
                    </div>
                    <div class=" row epidemicList mt-2 ml-2 mr-2 justify-content-center">
                         <table class="table mt-4 ml-2 mr-2">
                              <thead>
                                   <tr>
                                        <th class="text-center" style=" padding-right: 2px;">STT</th>
                                        <th>Mã</th>
                                        <th>Tên</th>
                                        <th>Thời điểm</th>
                                        <th>Môi trường phát triển</th>
                                        <th>Tác hại</th>
                                        <th>Phân loại</th>
                                        <th></th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(epidemic, i ) in get_rows(epidemicList)" :key="i">
                                        <td class="text-center" v-if="currentPage > 1">{{ i + ((currentPage - 1) *
                                             elementsPerPage) + 1 }}</td>
                                        <td class="text-center" v-else>{{ i + 1 }}</td>
                                        <td>{{ epidemic.Epidemic_id }}</td>
                                        <td style="width: 15%;">{{ epidemic.Epidemic_name }}</td>
                                        <td style="width: 10%;">{{ epidemic.Epidemic_timeOfDevelopment }}</td>
                                        <td class="text-truncate" style="max-width: 250px;">{{
                                             epidemic.Epidemic_developmentEnvironment }}</td>
                                        <td class="text-truncate" style="max-width: 250px;">{{ epidemic.Epidemic_Harm }}</td>
                                        <td style="width: 10%;">{{ epidemic.EpidemicsClassification_name }}</td>
                                        <td class="">
                                             <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown"
                                                  aria-haspopup="true" aria-expanded="false">
                                                  <i class="fas fa-ellipsis-v"></i>
                                             </button>
                                             <div class="dropdown-menu">
                                                  <a class="dropdown-item action"
                                                       @click="setEpidemicChoosen(epidemic), isOpenUpdateEpidemic = !isOpenUpdateEpidemic">
                                                       <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                  </a>
                                                  <a class="dropdown-item" href="#"
                                                       @click="setEpidemicChoosen(epidemic), isOpenConfirm = !isOpenConfirm">
                                                       <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                  </a>
                                             </div>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>
                    <div class="row mt-2 ml-2 mr-2" style="display: flex; justify-content: center;">
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
                         :epidemicsClassificationList="epidemicsClassificationList" @updateEpidemic-submit="updateEpidemic"
                         :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import EpidemicService from '../../services/epidemic.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import CreateEpidemicForm from '@/components/catalogManagementComponents/createNewEpidemicForm.vue';
import UpdateEpidemicForm from '@/components/catalogManagementComponents/updateEpidemicForm.vue';
import EpidemicsClassificationService from '@/services/epidemicsClassification.service';

class Epidemic {
     constructor(epidemic) {
          this.Epidemic_id = epidemic.Epidemic_id;
          this.Epidemic_name = epidemic.Epidemic_name;
     }
}

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
               epidemicsClassificationList: [],
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               cloneEpidemicList: [],
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

          filteredList() {
               return this.cloneEpidemicList.filter(epidemic => {
                    return epidemic.Epidemic_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
          },

          async retrieveEpidemicList() {
               const [err, respone] = await this.handle(
                    EpidemicService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.epidemicList = respone.data;
                    this.cloneEpidemicList = respone.data;
                    this.cloneEpidemicList.forEach(element => {
                         new Epidemic(element)
                    });
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
               this.epidemicsClassificationList.forEach(element => {
                    if (data.EpidemicsClassification_name == element.EpidemicsClassification_name) {
                         data.EpidemicsClassification_id = element.EpidemicsClassification_id;
                    }
               });

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

               this.epidemicsClassificationList.forEach(element => {
                    if (data.EpidemicsClassification_name == element.EpidemicsClassification_name) {
                         data.EpidemicsClassification_id = element.EpidemicsClassification_id;
                    }
               });
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
                    this.message = "Xóa bệnh dịch thành công"
               }
          },

          async retrieveEpidemicsClassification() {
               const [error, response] = await this.handle(
                    EpidemicsClassificationService.getAll()
               );
               if (error) {
                    console.log(error);
               } else {
                    this.epidemicsClassificationList = response.data;
               }
          },
          
          async searchName(data) {
               this.nameToSearch = data;
               const [error, response] = await this.handle(EpidemicService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.epidemicList = response.data;
                         console.log(response.data)
                    }
                    else {
                         this.message = "Không tìm thấy bệnh dịch!";
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
          this.retrieveEpidemicsClassification();
          this.retrieveEpidemicList();
     }
}
</script>

<style>
@import url(../../assets/epidemicStyle.css);


nav {
     position: relative;
     display: inline !important;
}

nav .pagination .active .page-link {
     background: #ABD2C8 !important;
     border: 1px solid #FAFAFC !important;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25) !important;
     border-radius: 15px !important;
     margin-left: 10px !important;
     margin-right: 10px !important;
     color: #FFFED8 !important;

     text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     /* width: 40px !important; */
}

nav .pagination .page-item .page-link {
     color: #6D6E73;
     border: none;
     text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 700;
     background-color:  #EAEAEA;
     font-size: 20px;
}

</style>