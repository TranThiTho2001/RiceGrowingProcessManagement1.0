<template>
     <!-- Cot ben trai -->
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
     <div class="container-fluid topHeader" @click="open = !open">
          <div class="btn btnUser dropdown">
               <i class="fas fa-user-circle iconUser"></i>
               <h6 class="username "> &nbsp;{{ formatName(currentuser.Employee_name) }} <i class="fas fa-caret-down"
                         style="color:  #FFFED8;"></i></h6>
               <!-- <div class="dropdown-conten" style="background-color: #FFFED8;">
                    <a @click="logout">Đăng xuất</a>
               </div> -->
          </div>

          <div class="menu " :class="{ menuactive: open }">
               <h3>
                    {{ currentUser.Employee_name }}
               </h3>
               <ul>
                    <li>
                         <span class="material-icons icons-size"><i class="far fa-user-circle"
                                   style="font-size: 22px;"></i></span>
                         <a href="#">Tài khoản</a>
                    </li>
                    <li>
                         <span class="material-icons icons-size"><i class="fas fa-sign-out-alt"
                                   style="font-size: 21px; padding-left: 2px;"></i></span>
                         <a href="#">Đăng xuất</a>
                    </li>

               </ul>
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
               currentuser: {},
               open: false,
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
               const [err, respone] = await this.handle(
                    EmployeeService.get(this.currentUser.Employee_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
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
* {
     font-family: "poppins", sans-serif;
     margin: 0;
     padding: 0;
}

body {
     background-color: #333;
     height: 100vh;
}

.icons-size {
     color: #333;
     font-size: 14px;
}

.topHeader {
     position: fixed;
     right: 30px;
     top: 20px
}

.topHeader .menu h3 {}

.topHeader .menu {
     background-color: #FFF;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     border-radius: 15px;
     padding: 10px 20px;
     position: absolute;
     right: -10px;
     width: 180px;
     transition: 0.5s;
     top: 30px;
     visibility: hidden;
     opacity: 0;
}

.topHeader .menuactive {
     opacity: 1;
     top: 40px;
     visibility: visible;
}

.topHeader .menu::before {
     background-color: #fff;
     content: '';
     height: 20px;
     position: absolute;
     right: 30px;
     transform: rotate(45deg);
     top: -5px;
     width: 20px;
}

.topHeader .menu h3 {
     color: #008B8E;
     font-size: 20px;
     font-weight: 600;
     line-height: 1.3em;
     padding: 20px 0px;
     text-align: left;
     font-family: 'Roboto';
     font-style: normal;
     width: 100%;
}

.topHeader .menu h3 div {
     color: #818181;
     font-size: 14px;
     font-weight: 400;
}

.topHeader .menu ul li {
     align-items: center;
     border-top: 1px solid rgba(0, 0, 0, 0.05);
     display: flex;
     justify-content: left;
     list-style: none;
     padding: 10px 0px;
}

.topHeader .menu ul li img {
     max-width: 20px;
     margin-right: 10px;
     opacity: 0.5;
     transition: 0.5s
}

.topHeader .menu ul li a {
     display: inline-block;
     color: #2F3033;
     color: #2F3033;
     font-family: 'Roboto';
     font-style: normal;
     font-size: 18px;
     font-weight: 500;
     padding-left: 15px;
     text-decoration: none;
     transition: 0.5s;
}

.topHeader .menu ul li:hover img {
     opacity: 1;
}

.topHeader .menu ul li:hover a {
     color: #a3a3a3;
}

.topHeader {
     font-size: 18px;
     margin-left: 0px;
     border-radius: 10px;
     height: 10px;
     position: absolute;
     left: -15px;
     top: 16px !important;
     z-index: 4;
}

.topHeader .iconUser {
     font-size: 26px;
     background: #ABD2C8;
     border-radius: 50%;
     color: #FFFED8;
     position: relative;
     top: -3%;
}

.topHeader .username {
     font-family: Inter;
     font-size: 18px;
     display: inline;
     color: #FFFED8;
     text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     position: relative;
     top: -12%
}

.topHeader .btnUser {
     height: 37px;
     background: #ABD2C8;
     border: 1px solid #FAFAFC;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     border-radius: 10px;
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
     height: 37px;
     background: #ABD2C8;
     border: 1px solid #FAFAFC;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     border-radius: 20px;
     position: relative;
}

.dropdown-conten {
     display: none;
     background-color: #EEEA41;
     min-width: 120px;
     font-family: Inter;
     font-size: 20px;
     min-width: 140px;
     height: 40px;
}

.dropdown-conten:hover {
     background-color: #EEEA41;

}

.dropdown:hover .dropdown-conten {
     display: block;
     position: absolute;
     top: 95%;
     left: -2%;
     background-color: #EEEA41;
     background: #EEEA41;
}

.dropdown:checked .dropdown-conten {
     display: block;
     position: absolute;
     top: 95%;
     left: -2%;
     background-color: #EEEA41;
     background: #EEEA41;
}

@media only screen and (max-width: 1430px) {
     .username {
          display: none !important;
     }
}</style>