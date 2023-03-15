<template>
     <div class="container-fluid arablelandManagement pr-4" style="background-color: #EAEAEA;">
          <div class="row arablelandManagementFrame" style="height: 100vmin;">
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
               <div class="rightArableLandManagement right" :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="row ml-4 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="col-md-2">
                              <h3 class="name">Mẫu ruộng</h3>
                         </div>
                         <div class="col-md-8">

                         </div>

                         <div class="col-md-2 text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-3">
                              
                         </div>
                    </div>
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";


import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';



export default {
     name: "ArableLandManagement",
     components: {
          Catalog,
          TopHeader,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 9,
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
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               cloneArableLandList: [],
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
               return this.cloneArableLandList.filter(arableLand => {
                    return arableLand.ArableLand_owner.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
          },

          getWidth() {
               console.log(document.body.clientWidth)
               var width = document.body.clientWidth;
               if (width > 1300 && width < 1600) {
                    return true;
               }
               else {
                    return false;
               }
          },
          // async retrieveArableLandList() {
          //      const [err, respone] = await this.handle(
          //           ArableLandService.getAll()
          //      );
          //      if (err) {
          //           console.log(err)
          //      }
          //      else {
          //           this.arablelandList = respone.data;
          //           this.cloneArableLandList = respone.data;
          //           this.cloneArableLandList.forEach(element => {
          //                new ArableLand(element);
          //           });
          //           var temp = (String(this.arablelandList[this.arablelandList.length - 1].ArableLand_id)).split("");
          //           var id = "";
          //           for (let index = 0; index < temp.length; index++) {
          //                const element = temp[index];
          //                if (element != "A" && element != "L" & element != "0") {
          //                     for (let i = index; i < temp.length; i++) {
          //                          id = id.concat(temp[i]);
          //                     }
          //                     break;
          //                }
          //           }

          //           if (id < 9) {
          //                this.newArableLand.ArableLand_id = "AL0000000" + String(Number(id) + 1);
          //           }
          //           else if (id >= 9 && id < 99) {
          //                this.newArableLand.ArableLand_id = "AL000000" + String(Number(id) + 1);
          //           }
          //           else if (id >= 99 && id < 999) {
          //                this.newArableLand.ArableLand_id = "AL00000" + String(Number(id) + 1);
          //           }
          //           else {
          //                this.newArableLand.ArableLand_id = "AL00" + String(Number(id) + 1);
          //           }
          //      }
          // },

          // async createArableLand(data) {
          //      if (data.close == false) {
          //           this.openCreate = false;
          //           this.message1 = " ";
          //           this.message2 = " ";
          //      }
          //      else {
          //           this.message1 = "";
          //           this.message2 = "";
          //           if (data.Soil_id == "Đất phù sa ven sông") {
          //                data.Soil_id = "AL00000001";
          //           }
          //           else if (data.Soil_id == "Đất phù sa xa xông") {
          //                data.Soil_id = "SL00000002";
          //           }
          //           else if (data.Soil_id == "Đất nhiễm phèn") {
          //                data.Soil_id = "SL00000003";
          //           }
          //           else if (data.Soil_id == "Đất nhiễm mặn") {
          //                data.Soil_id = "SL00000004";
          //           }
          //           else {
          //                data.Soil_id = "SL00000005";
          //           }
          //           const [error, respone] = await this.handle(
          //                ArableLandService.create(data)
          //           );
          //           if (error) {
          //                console.log(error);
          //                this.message1 = "Thêm không thành công."
          //           } else if (respone.data == "Không thể tạo một mẫu ruộng mới") {
          //                this.message1 = "Thêm không thành công."
          //           } else {
          //                this.message2 = "Thêm thành công.";
          //                this.retrieveArableLandList();
          //           }
          //      }
          // },

          // async updateArableLand(data) {
          //      if (data.close == false) {
          //           this.isOpenUpdateArableLand = false;
          //           this.message1 = " ";
          //           this.message2 = " ";
          //      }
          //      else {
          //           this.message1 = "";
          //           this.message2 = "";
          //           if (data.Soil_id == "Đất phù sa ven sông" || data.Soil_id == "AL00000001") {
          //                data.Soil_id = "SL00000001";
          //           }
          //           else if (data.Soil_id == "Đất phù sa xa xông" || data.Soil_id == "AL00000002") {
          //                data.Soil_id = "SL00000002";
          //           }
          //           else if (data.Soil_id == "Đất nhiễm phèn" || data.Soil_id == "AL00000003") {
          //                data.Soil_id = "SL00000003";
          //           }
          //           else if (data.Soil_id == "Đất nhiễm mặn" || data.Soil_id == "AL00000004") {
          //                data.Soil_id = "SL00000004";
          //           }
          //           else {
          //                data.Soil_id = "SL00000005";
          //           }
          //           const [error, respone] = await this.handle(
          //                ArableLandService.update(data.ArableLand_id, data)
          //           );
          //           if (error) {
          //                console.log(error);
          //                this.message1 = "Cập nhật không thành công."
          //           } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
          //                this.message1 = "Cập nhật không thành công."
          //           } else {
          //                this.message2 = "Cập nhật thành công.";
          //                this.retrieveArableLandList();
          //           }
          //      }
          // },

          // async deleteArableLand(arablelandid) {
          //      const [error, response] = await this.handle(
          //           ArableLandService.delete(arablelandid)
          //      );
          //      if (error) {
          //           console.log(error);
          //      } else {
          //           this.retrieveArableLandList()
          //           console.log(response.data);
          //           this.message = "Xóa mẫu ruộng thành công"
          //      }
          // },


          // async searchName(data) {
          //      this.nameToSearch = data;
          //      const [error, response] = await this.handle(ArableLandService.findByName(this.nameToSearch));
          //      if (error) {
          //           console.log(error);
          //      } else {
          //           if (response.data != null) {
          //                this.arablelandList = response.data;
          //                console.log(response.data)
          //           }
          //           else {
          //                // this.message = "Không tìm thấy phân bón!";
          //                this.isOpenMessage = !this.isOpenMessage;
          //           }

          //      }
          // },

          // async setArableLandChoosen(arableland) {
          //      this.arablelandChoosen = arableland;
          //      console.log(this.arablelandChoosen)
          // },


          // get_rows(list) {
          //      var start = (this.currentPage - 1) * this.elementsPerPage;
          //      var end = start + this.elementsPerPage;
          //      return list.slice(start, end);

          // },

          // // So trang cua danh sach danh muc
          // num_pages(list) {
          //      return Math.ceil(list.length / this.elementsPerPage);
          // },

          // async change_page(page, list) {
          //      if (page == '-' && this.currentPage > 1) {
          //           this.currentPage -= 1;
          //           this.get_rows(list);
          //      }
          //      else if (page == '+' && this.currentPage < this.num_pages(list)) {
          //           this.currentPage += 1;
          //           this.get_rows(list);
          //      }
          //      else {
          //           this.currentPage = page;
          //           this.get_rows(list);
          //      }
          // },
     },

     created() {
          this.initEmployeeState();
     },

     mounted() {

     }
}
</script>

<style>
@import url(../../assets/arablelandStyle.css);


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
     background-color: #EAEAEA;
     font-size: 20px;
}

@import url(../../assets/mainStyle.css);
</style>