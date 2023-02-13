<template>
     <div id="app">
       <!-- <head>
           <link rel='shortcut icon' href='../../../images/LogoQL.png' />
       </head>
       <div class="container-fluid">
         <header class="align-items-center">
           <div class="row  justify-content-between align-items-center">
             <div class="col-sm-1 logo-image pl-0 pr-0">
               <img class="img-fluid" src="./images/Logo.png">
             </div>
             <div class="col-sm-11">
               <div class="row search">
                 <div class="col-sm-10 pt-1 pb-1 pl-1">
                   <div class="input-group">
                     <input type="text" class="form-control" placeholder="Tìm kiếm" v-model="nameToSearch"
                       style="font-size: 18px;" />
                     <div class="input-group-append">
                       <button class="btn btn-outline-secondary" type="button" @click="searchName"
                         style="border: none; font-size: 18px;">
                         <span class="fa fa-search" aria-hidden="true"></span>
                       </button>
                     </div>
                   </div>
                 </div>
                 <div class="col-sm-2 align-items-center pt-0 pl-0 pr-0">
                   <div v-if="currentUser" class="justify-content-end align-items-center">
                     <router-link to="/profile" class="nav-link" style="color: #756262">
                       {{ currentUser.username }}
                     </router-link>
                     <router-link to="/TaiKhoan">
                       <button class="btn btnTaiKhoan"><span class="fas fa-user-circle"
                           style="font-size: 36px; color: #4E4E4E;"></span></button>
                     </router-link>
                     <button class="btn btn-light btnGioHang"></button>
                   </div>
                   <div v-if="!currentUser" class="align-items-center">
                     <router-link to="./DangKy">
                       <button class="btn btn-secondary pl-1 pr-1 btnDangKy">Đăng ký</button>
                     </router-link>
                     <router-link to="/TaiKhoan">
                       <button class="btn btn-light btnTaiKhoan"><span class="fas fa-user-circle"
                           style="font-size: 36px; color: #4E4E4E;"></span></button>
                     </router-link>
   
                     <button class="btn btn-light btnGioHang"></button>
                   </div>
   
   
                 </div>
               </div>
               <div class="row pt-1">
                 <div class="col-12"><img src="./images/Cosmetic.png" class="img-fluid"></div>
               </div>
             </div>
           </div>
         </header> -->
       <!-- </div>  -->
       <router-view />
     </div>
   </template>
   
   <script>
   
   export default {
     name: 'App',
     data() {
       return {
         currentUser: null
       };
     },
     methods: {
       logout() {
         console.log("logout");
       },
     }
   }
   </script> 
   
   
   <style>
   /* #app {
     font-family: Helvetica, Arial, sans-serif;
     -webkit-font-smoothing: antialiased;
     -moz-osx-font-smoothing: grayscale;
     text-align: center;
     color: #2c3e50;
     margin-left: 45px;
     margin-right: 45px;
     margin-top: 31px;
   }
   
   .container-fluid {
     margin-bottom: 0px;
   }
   
   #app .container-fluid .search {
     text-align: center;
     background-color: #E9E8E8;
     font-size: 20px;
     border-radius: 5px;
   }
   
   #app .btnDangKy {
     border: none;
     color: white;
     background-color: #929292;
     border-radius: 5px;
     font-size: 18px;
   }
   
   #app .btnGioHang {
     background-color: black;
     background-image: url(./images/Shopping-cart.png);
     width: 36px;
     height: 36px;
     border: none;
   }
   
   #app .btnTaiKhoan {
     background-color: #E9E8E8;
     border: none;
   } */
   
   /* #app .navbar-expand-lg {
     color: #515151;
     font-size: 20px;
     
   }
   #app .nav-item{
     color: #515151;
     font-size: 20px; */
   
   </style>   
