<template><!-- Cot ben trai -->
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
                              <h4 style="font-family: Inter; font-size: 22px; display: block;color: #5C5D22;">{{ currentuser.Employee_name
                              }}</h4>
                              <span class="mt-0" style="font-family: Inter; font-size: 18px; color:#5C5D22">{{
                                   currentuser.Role_name }}</span>
                         </div>
                    </div>
                    
               </div>
               <hr style="background-color: #919302; border-width: 1.2px;; width: 235px;">
          </div>
          <div class="row bottomRow mt-1">
               <div class="categoryList col-sm-12">
                    <div class="row " >
                         <button class="btn ml-2 pl-3 pr-5 btn-sm btn-outline-secondary btnMonitor" @click="goToQLMonitor"> <i
                                   class="fas fa-chart-line" >&nbsp; </i>Theo dõi vụ mùa</button>
                    </div>
                    <div class="row mt-1 pt-2">
                         <button class="btn ml-2 pl-3 pr-5 btn-sm btn-outline-secondary btnOtherActivities"
                              @click="goToOtherActivities"> <i class="far fa-list-alt">&nbsp;</i>Các hoạt động
                         </button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn ml-2 pl-3 pr-5 btn-sm btn-outline-secondary btnSeed" @click="goToSeed"><i
                                   class="fas fa-seedling">&nbsp;</i> Giống lúa</button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn ml-2 pl-3 pr-5 btn-sm btn-outline-secondary btnFertilizer" @click="goToFertilizer">
                              <i class="fas fa-fill-drip">&nbsp;</i>Phân bón </button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn ml-2 pl-3 pr-5 btn-sm btn-outline-secondary btnEpidemic" @click="goToEpidemic"><i
                                   class="fas fa-spider">&nbsp;</i>Dịch bệnh </button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn ml-2 pl-3 pr-5 btn-sm btn-outline-secondary btnArableland" @click="goToArableLand"><i
                                   class="fas fa-square">&nbsp;</i>Mẫu ruộng</button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn ml-2 pl-3 pr-2 btn-sm btn-outline-secondary btnPesticide" @click="goToPesticide"><i
                                   class="fas fa-flask">&nbsp;</i>Thuốc trị bệnh dịch </button>
                    </div>
               </div>
               <!-- Cot ben phai -->
          </div>
     </div>
</template>
<script>
import EmployeeService from "../../services/employee.service";

export default {
     name: `Catalog`,
     props: [
          "currentUserid",
     ],
     data() {
          return {
               currentuser: {}
          }
     },

     methods: {

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

          async PhanQuyenNhanVien() {
               console.log(this.employee)
               const [err, respone] = await this.handle(
                    EmployeeService.get(this.currentUserid)
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
          this.PhanQuyenNhanVien();
     }

};
</script>

<style> .navigationBar {
      background-image: linear-gradient(#dffac8, #f7f8cc);
      font-family: Inter;
      height: 100vmin;
      font-size: 18px;
      display: inline-block;

 }

 .navigationBar .null {
      height: 19%;
 }

 .categoryList {
      width: 100%;
 }

 .categoryList .btn-outline-secondary,
 .moreInformation .btn-outline-secondary {
      font-size: 19px;
      font-family: Inter;
      text-align: left;
      min-width: 94%;
      display: block;
      background-color: none;
      color: #737374;
      border: none;
      border-radius: 14px;
 }

 .categoryList .btn-outline-secondary:hover,
 .moreInformation .btn-outline-secondary:hover {
      display: block;
      width: 94%;
      font-size: 19px;
      background-color: #FFFA37;
      color: #5C5D22;
      border: none;
      font-family: Inter;
      border-radius: 14px;
 }

 .categoryList .fas,
 .categoryList .fa,
 .moreInformation .fas,
 .moreInformation .fa {
      font-size: 20px;
 }

 .navigationBar .iconUser {
      font-size: 50px;
 }

 .navigationBar .topRow {
      /* border-bottom: 1px solid #919302; */
 }</style>