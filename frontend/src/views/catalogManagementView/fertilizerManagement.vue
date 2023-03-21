<template>
     <div class="container-fluid fertilizerManagement pr-4 " style="background-color: #EAEAEA; height: max-content;">
          <div class="row fertilizerManagementFrame" style="height: 100vmin;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="" :class="{ menubar: openMenu.openMenu }" v-if="openMenu.openMenu">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>
               <div class="left">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>
               <div class="rightFertilizerManagement right" :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="row ml-4 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{name2: isOpenInput2}"  style="font">Phân bón</h3>
                         </div>
                         <div class="">
                              <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                                   @click="retrieveFertilizerList, isOpenInput1 = true" @keyup.enter="searchName(nameToSearch)"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch1" @click="searchName(nameToSearch), away()"
                                   v-if="nameToSearch == '' && !isOpenSearch.open">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>

                              <input v-if="isOpenInput2 || (isOpenSearch.open)" autofocus type="text" class="form-control inputSearch2" placeholder="Tìm" style="width: 2%;"
                                   v-model="nameToSearch" @click="retrieveFertilizerList" 
                                   @keyup.enter="searchName(nameToSearch), away()"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch2" @click="isOpenInput2 = !isOpenInput2">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>

                              <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                   <p class="item" v-for="fertilizer in filteredList()" :key="fertilizer.Fertilizer_name"
                                        @click="searchName(fertilizer.Fertilizer_name), away()">
                                        {{ fertilizer.Fertilizer_name }}</p>
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
                              <button class="btn btnCreate" @click="openCreate = !openCreate"><i class="fas fa-plus-circle"
                                        style="font-size: 15px;"></i> Thêm phân bón</button>
                         </div>
                    </div>
                    <div class="row scrollTable">
                         <div class="col-sm-12 justify-content-center">
                              <table class="table fertilizerList">
                                   <thead>
                                        <tr>
                                             <th class="text-center">STT</th>
                                             <th>Mã</th>
                                             <th>Tên</th>
                                             <th>Nhà cung cấp</th>
                                             <th>Thông tin thành phần</th>
                                             <th>Công dụng</th>
                                             <th></th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(fertilizer, i ) in fertilizerList" :key="i"
                                             class="">
                                             <td v-if="currentPage > 1" class="text-center" style="vertical-align: top !important; ">{{ i + ((currentPage - 1) * 6 +
                                                  1) }}
                                             </td>
                                             <td v-else class="text-center">{{ i + 1 }}</td>
                                             <td>{{ fertilizer.Fertilizer_id }}</td>
                                             <td>{{ fertilizer.Fertilizer_name }}</td>
                                             <td>{{ fertilizer.Fertilizer_supplier }}</td>
                                             <td  style="max-width: 650px;">{{ fertilizer.Fertilizer_description }}</td>
                                             <td style="max-width: 650px;">{{ fertilizer.Fertilizer_uses }}</td>
                                             <td style="text-align: center; vertical-align: middle !important; ">
                                                  <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown"
                                                       aria-haspopup="true" aria-expanded="false">
                                                       <i class="fas fa-ellipsis-v"></i>
                                                  </button>
                                                  <div class="dropdown-menu">
                                                       <a class="dropdown-item action"
                                                            @click="setFertilizerChoosen(fertilizer), isOpenUpdateFertilizer = !isOpenUpdateFertilizer">
                                                            <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                       </a>
                                                       <a class="dropdown-item" href="#"
                                                            @click="setFertilizerChoosen(fertilizer), isOpenConfirm = !isOpenConfirm">
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
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import FertilizerService from '../../services/fertilizer.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import CreateFertilizerForm from '@/components/catalogManagementComponents/createNewFertilizerForm.vue';
import UpdateFertilizerForm from '@/components/catalogManagementComponents/updateFertilizerForm.vue';

class Fertilizer {
     constructor(fertilizer) {
          this.Fertilizer_id = fertilizer.Fertilizer_id;
          this.Fertilizer_name = fertilizer.Fertilizer_name;
     }
}

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
               isOpenInput2: false,
               isOpenInput1: false,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               cloneFertilizerList: [],
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
               return this.cloneFertilizerList.filter(fertilizer => {
                    return fertilizer.Fertilizer_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          async retrieveFertilizerList() {
               const [err, respone] = await this.handle(
                    FertilizerService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.fertilizerList = respone.data;
                    this.cloneFertilizerList = respone.data;
                    this.cloneFertilizerList.forEach(element => {
                         new Fertilizer(element)
                    });
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
                    console.log(this.fertilizerList)
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


          async searchName(data) {
               this.nameToSearch = data;
               const [error, response] = await this.handle(FertilizerService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.fertilizerList = response.data;
                         console.log(response.data)
                    }
                    else {
                         this.isOpenMessage = !this.isOpenMessage;
                    }
               }
          },

          async setFertilizerChoosen(fertilizer) {
               this.fertilizerChoosen = fertilizer;
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
     z-index: 0;
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
     background-color: #EAEAEA;
     font-size: 20px;
}

@import url(../../assets/mainStyle.css);</style>