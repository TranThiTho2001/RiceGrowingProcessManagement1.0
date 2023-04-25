<template>
     <div class="container-fluid seedManagement pr-4 " style="background-color: #EAEAEA; height: 100%;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row seedManagementFrame" style="height: 100%;" v-if="!loading" :class="{ active: active }">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>
               <div class="right rightSeedManagement ">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Giống lúa</h3>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row row-inputSearch">
                         <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                              @click="retrieveSeedList, isOpenInput1 = true" @keyup.enter="searchName(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>

                         <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="seed in filteredList()" :key="seed.Seed_name"
                                   @click="searchName(seed.Seed_name), away()">
                                   {{ seed.Seed_name }}</p>
                         </div>
                         <button class="btn btnCreate" @click="openCreate = !openCreate, active = !active"
                              style="border-radius: 12px;"><i class="fas fa-plus-circle"></i> Thêm giống lúa</button>
                    </div>

                    <div class="scrollTable">
                         <!-- <div class="scrollTable-content">
                              <table class="table seedList" id="tblStocks">
                                   <thead>
                                        <tr>
                                             <th class="centerclass">STT</th>
                                             <th>Mã</th>
                                             <th>Tên</th>
                                             <th>Nhà cung cấp</th>
                                             <th>Đặc tính</th>
                                             <th></th>
                                        </tr>
                                   </thead>
                                   <tbody>
                                        <tr v-for="(seed, i ) in seedList" :key="i">
                                             <td class="centerclass" data-label="STT">{{ i + 1 }}</td>
                                             <td data-label="Mã">{{ seed.Seed_id }}</td>
                                             <td data-label="Tên">{{ seed.Seed_name }}</td>
                                             <td data-label="Nhà cung cấp">{{ seed.Seed_supplier }}</td>
                                             <td data-label="Đặc tính">{{ seed.Seed_characteristic }}
                                             </td>
                                             <td class="" data-label="Tùy chọn">
                                                  <button type="button" class="btn btn-sm btnMore option1"
                                                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                       <i class="fas fa-ellipsis-v"></i>
                                                  </button>
                                                  <div class="dropdown-menu option1">
                                                       <a class="dropdown-item action"
                                                            @click="setSeedChosen(seed), isOpenUpdateSeed = !isOpenUpdateSeed, active = !active">
                                                            <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                       </a>
                                                       <a class="dropdown-item" href="#"
                                                            @click="setSeedChosen(seed), isOpenConfirm = !isOpenConfirm, active = !active">
                                                            <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                       </a>
                                                  </div>
                                                  <div class="option2">
                                                       <button class="btn btnMore"
                                                            @click="setSeedChosen(seed), isOpenUpdateSeed = !isOpenUpdateSeed">
                                                            <span class="fas fa-edit actionIcon"></span> Chỉnh sửa</button>
                                                       <button class="btn btnMore"
                                                            @click="setSeedChosen(seed), isOpenConfirm = !isOpenConfirm">
                                                            <span class="fas fa-trash-alt actionIcon"></span> Xóa</button>
                                                  </div>
                                             </td>
                                        </tr>
                                   </tbody>
                              </table>
                         </div> -->


                         <div class="ol-class" style="--length: 5" role="list">
                              <a class="li-class " href="#popup1" v-for="(seed, j) in seedList" :key="j"
                                   @click="setSeedChosen(seed)">
                                   <button type="button" class="btn btn-sm btnMoreSelection" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                   </button>
                                   <div class="dropdown-menu">
                                        <a class="dropdown-item action"
                                             @click="setSeedChosen(seed), isOpenUpdateSeed = !isOpenUpdateSeed, active = true">
                                             <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                        </a>
                                        <a class="dropdown-item" href="#"
                                             @click="setSeedChosen(seed), isOpenConfirm = !isOpenConfirm, active = true">
                                             <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                        </a>
                                   </div>
                                   <h5>{{ seed.Seed_name }}</h5>
                                   <p>{{ seed.Seed_characteristic }}</p>
                              </a>
                              <div id="popup1" class="overlay" v-if="!active && !isOpenUpdateSeed">
                                   <div class="popup">
                                        <a class="fas fa-times-circle" href="#"
                                             style="font-size: 25px; text-decoration: none; color:#B3B4BA; float: right;"></a>
                                        <h2>{{ seedChosen.Seed_name }}</h2>

                                        <div class="content">
                                             <h6 class="title-class">Mã giống</h6>
                                             <p class="value-class">{{ seedChosen.Seed_id }}</p>
                                             <h6 class="title-class">Nhà cung cấp</h6>
                                             <p class="value-class">{{ seedChosen.Seed_supplier }}</p>
                                             <h6 class="title-class">Đặc tính</h6>
                                             <p class="value-class">{{ seedChosen.Seed_characteristic }}</p>
                                        </div>
                                   </div>
                              </div>
                         </div>
                    </div>
                    <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->
               </div>
          </div>
          <div class="overlay2" v-if="isOpenConfirm">
               <div class="confirmationDialog" >
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelConfirm">
                         <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                    </p>
                    <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                         @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteSeed(seedChosen.Seed_id)">Xóa</button>
                    <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenConfirm = !isOpenConfirm, active = false">Hủy</button>
               </div>
          </div>
          <div class="overlay2" v-if="isOpenMessage">
               <div class="messageDialog">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                         <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{
                              message
                         }}
                    </p>
                    <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenMessage = !isOpenMessage, active = !active">OK</button>
               </div>
          </div>
          <div class="overlay2" v-if="openCreate">
               <createSeedForm  :newSeed="newSeed" @addSeed-submit="createSeed" :message1="message1"
                    :message2="message2" />
          </div>

          <div class="overlay2" v-if="isOpenUpdateSeed">
               <updateSeedForm  :newSeed="seedChosen" @updateSeed-submit="updateSeed"
                    :message1="message1" :message2="message2" />
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>

<script >


import { mapGetters, mapMutations } from "vuex";
import SeedService from '../../services/seed.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue'
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import createSeedForm from '@/components/catalogManagementComponents/createNewSeedForm.vue';
import updateSeedForm from '@/components/catalogManagementComponents/updateSeedForm.vue';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';

class Seed {
     constructor(seed) {
          this.Seed_id = seed.Seed_id;
          this.Seed_name = seed.Seed_name;
          this.Seed_supplier = seed.Seed_supplier;
          this.Seed_characteristic = seed.Seed_characteristic;
     }
}

export default {
     name: "SeedManagement",
     components: {
          Catalog,
          Preloader,
          createSeedForm,
          updateSeedForm,
          TopHeader,
     },

     data() {
          return {
               seedList: [],
               openCreate: false,
               newSeed: {},
               loading: true,
               message1: " ",
               message2: " ",
               isOpenMessage: false,
               isOpenConfirm: false,
               seedChosen: {},
               isOpenUpdateSeed: false,
               nameToSearch: "",
               message: "",
               isOpenInput1: false,
               isOpenInput2: false,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               cloneSeedList: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },

               active: false,
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
               return this.cloneSeedList.filter(seed => {
                    return seed.Seed_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          async loadData() {
               this.loading = true;
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
          },

          async retrieveSeedList() {
               const [err, respone] = await this.handle(
                    SeedService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.seedList = respone.data;
                    this.cloneSeedList = respone.data
                    this.cloneSeedList.forEach(element => {
                         new Seed(element)
                    });

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

                    if (id < 9) {
                         this.newSeed.Seed_id = "SD0000000" + String(Number(id) + 1);
                    }
                    else if (id >= 9 && id < 99) {
                         this.newSeed.Seed_id = "SD000000" + String(Number(id) + 1);
                    }
                    else if (id >= 99 && id < 999) {
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
                    this.active = false;
                    this.newSeed = {};
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
                    this.active = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newSeed = {};
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
                    this.message = "Xóa giống lúa không thành công"
               } else {
                    this.retrieveSeedList()
                    console.log(response.data);
                    this.message = "Xóa giống lúa thành công"
               }
          },


          async searchName(data) {
               this.nameToSearch = data;
               const [error, response] = await this.handle(SeedService.findByName(data));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.seedList = response.data;
                    }
                    else {
                         this.message = "Không tìm thấy giống lúa!";
                         this.isOpenMessage = !this.isOpenMessage;
                    }

               }
          },

          async setSeedChosen(seed) {
               this.seedChosen = seed;
          },

          async gotoCreateNewSeed() {
               this.$router.push("/CreateNewSeed");
          },

     },

     created() {
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveSeedList();
          this.loadData();
     }
}
</script>

<style>
@import url(../../assets/seedStyle.css);
@import url(../../assets/mainStyle.css);

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
</style>