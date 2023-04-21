<template>
     <div class="container-fluid fertilizerManagement pr-4 " style="background-color: #EAEAEA; height: max-content;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
          <Preloader color="red" scale="0.4" /></div>
          <div class="row fertilizerManagementFrame" style="height: max-content;" v-if="!loading">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>

               <div class="right rightFertilizerManagement " :class="{ leftNoneActive: active.leftnNoneActive }">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Phân bón</h3>
                         </div>

                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="fertilizer-content row">
                         <div class="left-content">
                              <div class="img mt-2 ml-2 mr-2 text-center"><img src="../../images/phanbon.jpg"
                                        class="img-fluid" alt="" style="min-height: 200px; max-height: 200px;">
                              </div>
                              <div class="img mt-2 ml-2 mr-2 text-center"><img src="../../images/phanbon.jpg"
                                        class="img-fluid" alt="" style="min-height: 200px; max-height: 200px;">
                              </div>
                         </div>
                         <div class="right-content">

                              <h5 class="title">Mã: </h5><span>{{ fertilizer.Fertilizer_id }}</span>



                              <h5 class="title">Tên phân bón: </h5><span>{{ fertilizer.Fertilizer_name }}</span>

                              <h5 class="title">Thành phần </h5>
                              <p>{{ fertilizer.Fertilizer_component }}</p>

                              <h5 class="title">Công dụng </h5>
                              <span>{{ fertilizer.Fertilizer_uses }}</span>


                              <h5 class="title">Hướng dẫn sử dụng </h5>
                              <span>{{ fertilizer.Fertilizer_directionForUse }}</span>
                         </div>
                    </div>
               </div>
          </div>
     </div>
</template>

<script>

import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import FertilizerService from '../../services/fertilizer.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';


export default {
     name: "FertilizerManagement",
     components: {
          Catalog,
          TopHeader,
          Preloader,
     },
     props: ["id"],
     data() {
          return {
               loading: true,
               fertilizer: {},
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               active: {
                    rightActive: false,
                    leftnNoneActive: false,
               }
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

          async retrieveFertilizer() {
               this.loading = true;
               const [error, respone] = await this.handle(
                    FertilizerService.get(this.fertilizer.Fertilizer_id)
               );
               if (error) {
                    console.log(error);
               } else {
                    this.fertilizer = respone.data;
               }
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
          },
     },

     created() {
          this.initEmployeeState();
          this.fertilizer.Fertilizer_id = this.$route.params.id;
     },

     mounted() {
          this.retrieveFertilizer();
     }
}
</script>

<style>
@import url(../../assets/mainStyle.css);

.fertilizer-content {
     margin-top: 145px !important;
     width: 97.5%;
     background-color: aliceblue;
     margin-left: 20px
}

.fertilizer-content .left-content {
     width: 30%;
}

.fertilizer-content .right-content {
     width: 70%;
}
</style>