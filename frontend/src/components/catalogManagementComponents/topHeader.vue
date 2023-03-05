<template>
     <!-- Cot ben trai -->
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
     <div class="container-fluid topHeader">
          <div class="btn btnUser dropdown">
               <div class="row topRow text-center">
                    <div class="col-sm-3">
                         <span class="fas fa-user-circle iconUser mt-2"></span>
                    </div>
                    <div class="col-sm-9 text-left">
                         <h6 class="username pt-2">{{ formatName(currentuser.Employee_name) }} <i class="fas fa-caret-down"
                                   style="color: #919302"></i></h6>
                    </div>
               </div>
               <div class="dropdown-conten" style="background-color: #919302;">
                    <a @click="logout">Đăng xuất</a>
               </div>
          </div>
     </div>
</template>
<script>
import EmployeeService from "../../services/employee.service";
import { mapGetters, mapMutations } from "vuex";
export default {
     name: `topHeader`,

     data() {
          return {
               currentuser: {}
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
          async PhanQuyenNhanVien() {
               console.log(this.employee)
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
          },

          formatName(data) {
               var temp = String(data).split(" ");
               console.log(temp[temp.length])
               return temp[temp.length - 1];

          },
          logout() {
            
            this.$router.push("/");
            this.$store.commit("logout");
        },
     },

     mounted() {        
          this.initEmployeeState();
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

.topHeader .btnUser {
     border: none;
     border-radius: 15px;
     background-color: #EEEA41;
     width: max-content;
}


.topHeader .btnUser:hover .account {
     display: flex;
     position: absolute;
     background-color: #EEEA41;
     font-family: Inter;
     left: 50%;
}

.dropdown {
     position: relative;
     display: inline-block;
}

.dropdown-conten {
     display: none;
     background-color:#EEEA41;
     min-width: 120px;  
     font-family: Inter;
     font-size: 20px; 
     min-width: 140px;
     height: 40px; 
}
.dropdown-conten:hover {
     background-color:#EEEA41;
    
}
.dropdown:hover .dropdown-conten {
     display: block;
     position: absolute;
     top:95%;
     left:-2%;
     background-color:#EEEA41;
     background: #EEEA41;
}
.dropdown:checked .dropdown-conten {
     display: block;
     position: absolute;
     top:95%;
     left:-2%;
     background-color:#EEEA41;
     background: #EEEA41;
}
</style>