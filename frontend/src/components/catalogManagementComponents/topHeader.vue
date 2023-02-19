<template><!-- Cot ben trai -->
     <div class="container topHeader">
          <button class="btnUser">
               <div class="row topRow text-center">
                    <div class="col-sm-3">
                         <span class="fas fa-user-circle iconUser mt-2"></span>
                    </div>
                    <div class="col-sm-9 text-left">
                         <h6 class="username pt-2">{{ formatName(currentuser.Employee_name) }} <i class="fas fa-caret-down" style="color: #919302"></i></h6>
                    </div>

               </div>
          </button>
     </div>
</template>
<script>
import EmployeeService from "../../services/employee.service";

export default {
     name: `topHeader`,
     props: [
          "currentUserid",
     ],
     data() {
          return {
               currentuser: {}
          }
     },

     methods: {
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
          },

          formatName(data) {
               var temp = String(data).split(" ");
               console.log(temp[temp.length])
               return temp[temp.length - 1];

          },
     },

     mounted() {
          this.PhanQuyenNhanVien();
     },

};
</script>

<style>
.topHeader {
     /* background-color: #b7f8d0; */
     font-family: Inter;
     font-size: 18px;
     display: inline-block;
     margin-left: 0px;
     border-radius: 10px;
}

.topHeader .iconUser {
     font-size: 26px;
     color: #5C5D22;
}

.topHeader .username {
     font-family: Inter;
     font-size: 18px;
     display: block;
     color: #5C5D22; 
}

.topHeader .btnUser{
     border: none;
     border-radius: 15px;
     background-color: #EEEA41;
     width: max-content;
}
</style>