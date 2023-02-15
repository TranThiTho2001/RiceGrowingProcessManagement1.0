<template>
     <div class="container-fluid homepage" style="background-color: #ebfff3;">
          <div class="row homepageFrame">
               <div class="col-md-2 col-sm-12 leftHomePage">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10"></div>
          </div>
     </div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
export default {
     name: "HomePage",
     components: {
          Catalog,
     },

     data() {
          return {

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
     },

     created(){
          this.initEmployeeState();
          console.log(this.currentUser.Employee_name )
     },
}
</script>

<style>
@import url(../../assets/homepageStyle.css);
</style>