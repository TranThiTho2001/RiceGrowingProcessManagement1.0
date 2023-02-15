<template>
     <!-- Cot ben trai -->
     <div class="container-fluid topHeader">
          <div class="row topRow mt-1 text-right">
               <div class="col-sm-2">
                    <span class="fas fa-user-circle iconUser mt-2"></span>
               </div>
               <div class="col-sm-10" style="padding-bottom: 10px;">
                    <div class="row ml-2">
                         <span style="font-family: Inter; font-size: 22px; display: block;">{{ currentuser.Employee_name }}</span><br>
                         <span class="mt-0" style="font-family: Inter; font-size: 18px;">{{ currentuser.Role_name}}</span>
                    </div>
               </div>
          </div>
          
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
     },

};
</script>

<style>
.topHeader {
     background-color: #b7f8d0;
     font-family: Inter;
     font-size: 18px;
     display: inline-block;
     margin-left: 0px;
     border-radius: 10px;
}

.topHeader .iconUser{
     font-size: 45px;
}
</style>