<template>
     <div class="navigationBar container-fluid ">
          <div class="row topRow  mt-2">
               <div class="col-sm-12 ">
                    <div class="row">
                         <div class="col-sm-3"></div>
                         <div class="col-sm-6 text-center">
                              <img class="img-fluid" src="../../assets/UserIcon/iconUser1.png">
                         </div>
                         <div class="col-sm-3"></div>
                    </div>
                    <div class="row" style="padding-bottom: 10px;">
                         <div class="col-sm-12 text-center">
                              <h4 style="font-family: Inter; font-size: 22px; display: block;color: #5C5D22;">{{
                                   currentuser.Employee_name
                              }}</h4>
                              <span class="mt-0" style="font-family: Inter; font-size: 18px; color:#5C5D22">{{
                                   currentuser.Role_name }}</span>
                         </div>
                    </div>
               </div>
               <hr style="background-color: #919302; border-width: 1.2px;; width: 80%;">
          </div>
          <div class="row bottomRow mt-1">
               <div class="categoryList col-sm-12 text-center">
                    <div class="row ml-2" v-if="currentuser.Role_id == '03' || currentuser.Role_id == '02'">
                         <button class="btn  pl-3 pr-5 btn-sm btn-outline-secondary btnMonitor" @click="goToQLMonitor">
                              <i class="fas fa-chart-line">&nbsp;</i>Theo Dõi Mùa Vụ</button>
                    </div>
                    <div class="row ml-2" v-if="currentuser.Role_id == '01'">
                         <button class="btn  pl-3  pr-2 mr-2 btn-sm btnEmployee">
                              <i class="fas fa-users">&nbsp;</i>Quản Lý Nhân Viên</button>
                    </div>
                    <div class="row mt-1 pt-2 ml-2" v-if="currentuser.Role_id == '03' || currentuser.Role_id == '02'">
                         <button class="btn pl-3 pr-5 btn-sm btn-outline-secondary btnStatistical" @click="gotoStatistical()">
                              <i class="fas fa-chart-pie" style="font-size: 20px;">&nbsp;</i> Thống Kê
                         </button>
                    </div>
                    <div class="row mt-1 pt-2 ml-2" v-if="currentuser.Role_id == '03' || currentuser.Role_id == '02'">
                         <button class="btn pl-3 pr-5 btn-sm btn-outline-secondary btnOtherActivities"
                              @click="goToOtherActivities"> <i class="far fa-list-alt">&nbsp;</i>Các Hoạt Động
                         </button>
                    </div>
                    <div class="row mt-1 ml-2" v-if="currentuser.Role_id == '03' || currentuser.Role_id == '02'">
                         <button class="btn pl-3 pr-5 btn-sm btn-outline-secondary btnCatalog"
                              @click="isOpenCatalog = !isOpenCatalog"><i class="fas fa-caret-down"
                                   style="font-size: 24px;">&nbsp;</i> Danh
                              Mục</button>
                    </div>
                    <div class="catalog ml-2" v-if="isOpenCatalog">
                         <div class="row mt-3 ml-1" v-if="currentuser.Role_id == '03' || currentuser.Role_id == '02'">
                              <button class="btn  pl-4 pr-5 btn-sm btn-outline-secondary btnSeed" @click="goToSeed"><i
                                        class="fas fa-seedling">&nbsp;</i>Giống Lúa</button>
                         </div>
                         <div class="row mt-3 ml-1" v-if="currentuser.Role_id == '03' || currentuser.Role_id == '02'">
                              <button class="btn  pl-4 pr-5 btn-sm btn-outline-secondary btnFertilizer"
                                   @click="goToFertilizer">
                                   <i class="fas fa-fill-drip">&nbsp;</i>Phân Bón </button>
                         </div>
                         <div class="row mt-3 ml-1" v-if="currentuser.Role_id == '03' || currentuser.Role_id == '02'">
                              <button class="btn pl-4 pr-5 btn-sm btn-outline-secondary btnEpidemic" @click="goToEpidemic"><i
                                        class="fas fa-spider">&nbsp;</i>Dịch Bệnh </button>
                         </div>
                         <div class="row mt-3 ml-1" v-if="currentuser.Role_id == '03' || currentuser.Role_id == '02'">
                              <button class="btn pl-4 pr-5 btn-sm btn-outline-secondary btnArableland"
                                   @click="goToArableLand"><i class="fas fa-square">&nbsp;</i>Mẫu Ruộng</button>
                         </div>
                         <div class="row mt-3 ml-1" v-if="currentuser.Role_id == '03' || currentuser.Role_id == '02'">
                              <button class="btn pl-4 pr-2 btn-sm btn-outline-secondary btnPesticide"
                                   @click="goToPesticide"><i class="fas fa-flask">&nbsp;</i>Thuốc Trị Bệnh Dịch </button>
                         </div>
                    </div>
               </div>
          </div>
     </div>
</template>
<script>
import EmployeeService from "../../services/employee.service";
import { mapGetters, mapMutations } from "vuex";

export default {
     name: `Catalog`,
     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),
     },
     data() {
          return {
               currentuser: {},
               isOpenCatalog: false,
          }
     },

     methods: {
          ...mapMutations([
               "initEmployeeState"
          ]),
          goToQLMonitor() {
               this.$router.push("/Monitor");
          },
          goToOtherActivities() {
               this.$router.push("/OtherActivities");
          },
          goToSeed() {
               this.$router.push("/Seed");
          },
          goToFertilizer() {
               this.$router.push("/Fertilizer");
          },
          goToEpidemic() {
               this.$router.push("/Epidemic");
          },
          goToArableLand() {
               this.$router.push("/ArableLand");
          },
          goToPesticide() {
               this.$router.push("/Pesticide");
          },
          gotoStatistical() {
               this.$router.push("/Statistical");
          },
          async PhanQuyenNhanVien() {
               const [err, respone] = await this.handle(
                    EmployeeService.get(this.currentUser.Employee_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    // this.employee = respone.data;
                    this.currentuser = respone.data;
                    if (this.currentuser.Role_id == "01") {
                         this.currentuser.Role_name = "Quản trị viên";
                    }
                    else if (this.currentuser.Role_id == "02") {
                         this.currentuser.Role_name = "Chuyên gia";
                    }
                    else {
                         this.currentuser.Role_name = "Nhân viên";
                    }
               }
          }
     },

     mounted() {
          this.initEmployeeState();
          this.PhanQuyenNhanVien();
     }

};
</script>

<style>  .navigationBar {

       font-family: Inter;
       background-color: inherit;
       /* height: 100vmin; */
       font-size: 18px;
       display: inline-block;
       justify-content: start !important;

  }


  .navigationBar .categoryList .btn-outline-secondary {
       font-size: 17px;
       font-family: Inter;
       text-align: left;
       width: 80%;
       display: block;
       background-color: none;
       color: #737374;
       border: none;
       border-radius: 14px;
  }

  .navigationBar .categoryList .catalog .btn-outline-secondary {
       font-size: 17px;
       font-family: Inter;
       text-align: left;
       width: 88% !important;
       display: block;
       background-color: none;
       color: #737374;
       border: none;
       border-radius: 14px;
  }

  .navigationBar .categoryList .btn-outline-secondary:hover {
       display: block;
       width: 85%;
       font-size: 17px;
       background-color: #FFFA37;
       color: #5C5D22;
       border: none;
       font-family: Inter;
       border-radius: 14px;
  }

  .navigationBar .fa,
  .navigationBar .far,
  .navigationBar .fas {
       font-size: 20px;
  }

  .navigationBar .catalog .fa,
  .navigationBar .catalog .fas {
       font-size: 15px;
  }

  .navigationBar .catalog .btn-outline-secondary {
       font-size: 16px;
  }

  .navigationBar .iconUser {
       font-size: 50px;
  }


  .navigationBar .btnEmployee {
       font-size: 16px;
       font-family: Inter;
       text-align: left;
       min-width: 90%;
       width: 100%;
       display: block;
       background-color: none;
       color: #737374;
       border: none;
       border-radius: 14px;
       font-weight: 500;
  }

  .nav-item {
       display: inline-block;
  }
</style>
