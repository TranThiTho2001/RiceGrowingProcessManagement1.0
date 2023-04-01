<template>
  <div id="app">

    <router-view />
  </div>
</template>
   
<script>
import { mapGetters, mapMutations } from "vuex";
export default {
  name: 'App',
  data() {
    return {
      //  currentUser: null
    };
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
  },
  created() {
    this.initEmployeeState();
  },
}
</script> 
   

<style> #app {
   max-width: 100%;
 }

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
