<template>
     <div class="container-fluid">
          <div class="row">
              
              
               <div class="col-sm-2" v-if="isOpenMenu">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-sm-10" v-if="isOpenMenu">
                    <div class="row">
                         <button style="font-size: 30px; top:2%; left: 2%" @click="Open"> <i class="fas fa-bars "  ></i></button>
                         <RiceCropManagement />
                    </div>
               </div>
               <div class="col-sm-12" v-if="!isOpenMenu">
                    <div class="row" style="position: relative;">
                          <button class="bt" style="font-size: 30px; position:absolute; top:2%; left: 2%; z-index:1;" @click="Open"> <i class="fas fa-bars "  ></i></button>
                         <RiceCropManagement />
                    </div>
               </div>
          </div>
     </div>
</template>

<script>
import Catalog from '@/components/catalogManagementComponents/catalog.vue';
import RiceCropManagement from '@/views/catalogManagementView/riceCropManagement.vue';
import { mapGetters, mapMutations } from "vuex";
export default {
     name: "mainForm",
     components: {
          Catalog,
          RiceCropManagement,

     },
     data() {
          return {
               isOpenMenu: false,
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

          async Open(){
               this.isOpenMenu = !this.isOpenMenu;
               console.log(this.isOpenMenu)
          }

     },

     created() {
          this.initEmployeeState();
     }
}

</script>

<style>
.fa-bars:hover{
     background-color: #fff;
     color: aqua;
}
</style>