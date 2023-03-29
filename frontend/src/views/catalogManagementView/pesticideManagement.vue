<template>isOpenMenuIcon
     <div class="container-fluid pesticideManagement pr-4" style="background-color: #EAEAEA; height: 100%;">
          <div class="row pesticideManagementFrame" style="min-height: 100%;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
                    <div  class="left" :class=" {navbarresponsive: openMenu.openMenu }" >
                         <Catalog />
               </div>

               <div class="right rightPesticideManagement" :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="row pt-3 mb-5 pb-1 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{name2: isOpenInput2}"  style="font">Thuốc trị bệnh dịch</h3>
                         </div>
                              <div class="">
                                   <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                                   @click="retrievePesticideList, isOpenInput1 = true" @keyup.enter="searchName(nameToSearch), away()"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch1" @click="searchName(nameToSearch), away()"
                                   v-if="nameToSearch == '' && !isOpenSearch.open">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>

                              <input v-if="isOpenInput2 || (isOpenSearch.open)" autofocus type="text" class="form-control inputSearch2" placeholder="Tìm" style="width: 2%;"
                                   v-model="nameToSearch" @click="retrievePesticideList" 
                                   @keyup.enter="searchName(nameToSearch), away()"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch2" @click="isOpenInput2 = !isOpenInput2">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>
                              
                              <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                   <p class="item" v-for="pesticide in filteredList()" :key="pesticide.Pesticide_id"
                                        @click="searchName(pesticide.Pesticide_name), away()">
                                        {{ pesticide.Pesticide_name }}</p>
                              </div>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row ml-4 mr-1 mt-3 pb-4 pt-2">
                         <div class="col-sm-12 text-right">
                              <button class="btn btnCreate" @click="openCreate = !openCreate"><i
                                        class="fas fa-plus-circle" style="font-size: 15px;"></i> Thêm loại thuốc mới</button>
                         </div>
                    </div>
                    <div class=" row scrollTable">
                         <div class="col-sm-12 justify-content-center" style="width: ;: 100%;">
                         <table class="table pesticideList">
                              <thead>
                                   <tr>
                                        <th class="centerclass">STT</th>
                                        <th>Mã</th>
                                        <th>Tên</th>
                                        <th>Nhà cung cấp</th>
                                        <th>Thông tin</th>
                                        <th>Trị bệnh</th>
                                        <th></th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(pesticide, i ) in pesticideList" :key="i" class="align-self-center">
                                        <td class="centerclass" data-label="STT">{{ i }}</td>
                                        <td data-label="Mã">{{ pesticide.Pesticide_id }}</td>
                                        <td data-label="Tên" >{{ pesticide.Pesticide_name }}</td>
                                        <td data-label="Nhà cung cấp">{{ pesticide.Pesticide_supplier }}</td>
                                        <td data-label="Thông tin" style="width: 20%;"> {{ pesticide.Pesticide_description }}</td>
                                        <td data-label="Trị bệnh"><div style="display: inline-block;"><p v-for="treatment in pesticide.Treatment" :key="treatment.Epidemic_id" style="margin-bottom: 0.2px !important;">{{ treatment.Epidemic_name }}</p></div></td>
                                        <td data-label="Tùy chọn">
                                             <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown" 
                                                  aria-haspopup="true" aria-expanded="false">
                                                  <i class="fas fa-ellipsis-v"></i>
                                             </button>
                                             <div class="dropdown-menu">
                                                  <a class="dropdown-item action"
                                                  @click="setPesticideChosen(pesticide), isOpenUpdatePesticide = !isOpenUpdatePesticide">
                                                       <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                  </a>
                                                  <a class="dropdown-item" href="#"
                                                  @click="setPesticideChosen(pesticide), isOpenConfirm = !isOpenConfirm">
                                                       <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                  </a>
                                             </div>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>
                    </div>
                    <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->

                    <div class="confirmationDialog" v-if="isOpenConfirm">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deletePesticide(pesticideChosen.Pesticide_id)">Xóa</button>
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

                    <CreatePesticideForm v-if="openCreate" :newPesticide="newPesticide" :epidemicList="epidemicList"
                         @addPesticide-submit="createPesticide" :message1="message1" :message2="message2" />

                    <UpdatePesticideForm v-if="isOpenUpdatePesticide" :newPesticide="pesticideChosen" :epidemicList="epidemicList" :treatmentList="treatmentList"
                         @updatePesticide-submit="updatePesticide" :message1="message1" :message2="message2" />
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import PesticideService from '../../services/pesticide.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue'
import EpidemicService from '@/services/epidemic.service';
import TreatmentService from '@/services/treatment.service';
import CreatePesticideForm from '@/components/catalogManagementComponents/createNewPesticideForm.vue';
import UpdatePesticideForm from '@/components/catalogManagementComponents/updatePesticideForm.vue';


class Pesticide {
     constructor(pesticide) {
          this.Pesticide_id = pesticide.Pesticide_id;
          this.Pesticide_name = pesticide.Pesticide_name;
     }
}

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
               pesticideChosen: {},
               isOpenUpdatePesticide: false,
               nameToSearch: "",
               message: "",
               isOpenInput1: false,
               isOpenInput2: false,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               clonePesticideList: [],
               treatment: [],
               epidemicList: [],
               treatmentList: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },

               active: {
                    rightActive: false,
                    leftnNoneActive: false,
               }
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
               return this.clonePesticideList.filter(pesticide => {
                    return pesticide.Pesticide_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          async retrievePesticideList() {
               const [err, respone] = await this.handle(
                    PesticideService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.pesticideList = respone.data;
                    this.clonePesticideList = respone.data;
                    var i =0;
                    this.pesticideList.forEach(element => {
                         new Pesticide(element);  
                         this.findTreatmentByPesticideId(element.Pesticide_id, i);
                         i++;
                    });
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

          async retrieveEpidemicList() {
               const [err, respone] = await this.handle(
                    EpidemicService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.epidemicList = respone.data;
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
                         
                         var temp = data.Treatment;
                         temp.forEach(element => {
                              var treatment = {};
                              treatment.Epidemic_id = element;
                              treatment.Pesticide_id = data.Pesticide_id;
                              this.createTreatment(treatment);
                         });
                         this.retrievePesticideList();
                    }
               }
          },

          async createTreatment(data) {
                    const [error, respone] = await this.handle(
                         TreatmentService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         console.log("Thêm không thành công.");
                    } else if (respone.data == "Lỗi trong quá trình xử lý.") {
                         console.log("Thêm không thành công.");
                    } else {
                         console.log("Thêm thành công.");
                         this.findTreatmentByPesticideId(data.Pesticide_id)
                    }
          },

          async findTreatmentByPesticideId(data, i) {
               this.treatmentList = [];
                    const [error, respone] = await this.handle(
                         TreatmentService.findByPesticideId(data)
                    );
                    if (error) {
                         console.log(error);                       
                    } else if(respone.data != "Không tìm thấy."){
                         this.treatmentList = respone.data;this.pesticideList[i].Treatment = [];
                         this.treatmentList.forEach(element => {
                              this.pesticideList[i].Treatment.push(element);
                         });
                    }
          },

          async updatePesticide(data) {
               if (data.close == false) {
                    this.isOpenUpdatePesticide = false;
                    this.message1 = " ";
                    this.message2 = " ";
               }
               else {
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
                         this.findTreatmentByPesticideId(data.Pesticide_id)
                         var temp = 0;
                         data.Treatment.forEach(EpidemicID => {
                              this.treatmentList.forEach(element => {
                                   if(element.Epidemic_id == EpidemicID){
                                        temp= 1;
                                   }
                              });
                              if(temp == 0){
                                   var treatment = {};
                                   treatment.Epidemic_id = EpidemicID;
                                   treatment.Pesticide_id = data.Pesticide_id;
                                   this.createTreatment(treatment);
                              }
                              temp = 0;
                         });
                         temp = 0;
                         this.treatmentList.forEach(element => {
                              data.Treatment.forEach(EpidemicID  => {
                                   if(element.Epidemic_id == EpidemicID){
                                        temp= 1;
                                   }
                              });
                              if(temp == 0){
                                   this.deleteTreatment(data.Pesticide_id, element.Epidemic_id);
                              }
                              temp = 0;
                         });
                         this.retrievePesticideList();
                    }
               }
          },

          async deleteTreatment(pesticideid, epidemicid) {
               console.log(pesticideid,epidemicid)
               const [error, response] = await this.handle(
                    TreatmentService.delete(pesticideid,epidemicid)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.retrievePesticideList()
                    console.log(response.data);
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
                    this.message = "Xóa thuốc trị bệnh dịch thành công"
               }
          },


          async searchName(data) {
               this.nameToSearch = data;
               const [error, response] = await this.handle(PesticideService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.pesticideList = response.data;
                         console.log(response.data)
                    }
                    else {
                         this.isOpenMessage = !this.isOpenMessage;
                    }
               }
          },

          async setPesticideChosen(pesticide) {
               this.pesticideChosen = pesticide;
               this.findTreatmentByPesticideId(pesticide.Pesticide_id);
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
          this.retrieveEpidemicList();
     }
}
</script>

<style>
@import url(../../assets/pesticideStyle.css);
nav {
     position: absolute;
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
@import url(../../assets/mainStyle.css);
</style>