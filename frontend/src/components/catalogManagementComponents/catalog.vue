<template>
     <!-- Cot ben trai -->
     <div class="navigationBar container-fluid ">
          <div class="row topRow mb-4 mt-3 ">
          </div>
          <div class="row bottomRow">
               <div class="categoryList col-sm-12">
                    <div class="row mt-1 pt-2">
                         <button class="btn  pl-3 pr-5 btn-sm btn-outline-secondary btnMonitor"
                              @click="goToQLMonitor"> <i class="fas fa-chart-line">&nbsp; &nbsp;</i>Theo dõi </button>
                    </div>
                    <div class="row mt-1 pt-2">
                         <button class="btn pl-3 pr-5 btn-sm btn-outline-secondary btnOtherActivities"
                              @click="goToOtherActivities"> <i class="far fa-list-alt">&nbsp; &nbsp;</i>Các hoạt động </button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn pl-3 pr-5 btn-sm btn-outline-secondary btnSeed"
                              @click="goToSeed"><i class="fas fa-seedling">&nbsp; &nbsp;</i> Giống lúa</button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn pl-3 pr-5 btn-sm btn-outline-secondary btnFertilizer" @click="goToQLThongKe">
                              <i class="fas fa-fill-drip">&nbsp; &nbsp;</i>Phân bón </button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn pl-3 pr-5 btn-sm btn-outline-secondary btnEpidemic"
                              @click="goToEpidemic"><i class="fas fa-spider">&nbsp; &nbsp;</i>Dịch bệnh </button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn pl-3 pr-5 btn-sm btn-outline-secondary btnArableland"
                              @click="goToArableLand"><i class="fas fa-square">&nbsp; &nbsp;</i>Khu đất canh tác </button>
                    </div>
                    <div class="row mt-3">
                         <button class="btn pl-3 pr-2 btn-sm btn-outline-secondary btnPesticide"
                              @click="goToPesticide"><i class="fas fa-flask">&nbsp; &nbsp;</i>Thuốc trị bệnh dịch</button>
                    </div>
                    <div class="null"></div>
                    <div class="moreInformation">

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
                    if(this.currentuser.Role_id == "01"){
                         this.currentuser.Role_name = "Quản trị viên";
                    }
                    else if(this.currentuser.Role_id == "02"){
                         this.currentuser.Role_name = "Chuyên gia";
                    }
                    else{
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

<style>
.navigationBar {
     background-color: #6cc38c;
     font-family: Inter;
     height: 100vmin;
     font-size: 18px;
     display: inline-block;
     margin-left: 0px;
}

.navigationBar .null {
     height: 19%;
}

.categoryList {
     margin-top: 20px;
     width: 100%;
}

.categoryList .btn-outline-secondary,
.moreInformation .btn-outline-secondary {
     font-size: 19px;
     font-family: Inter;
     text-align: left;
     min-width: 100%;
     display: block;
     background-color: #6cc38c;
     color: #101010;
     border: none;
     border-radius: 0;
}

.categoryList .btn-outline-secondary:hover,
.moreInformation .btn-outline-secondary:hover {
     display: block;
     width: 120%;
     font-size: 19px;
     background-color: #ebfff3;;
     color: black;
     border: none;
     font-family: Inter;
     border-radius: 0;
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
     border-bottom: 3px solid #253e2d;
}
</style>