<template>
     <div class="container-fluid riceCropDetail">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
          <Preloader color="red" scale="0.4" /></div>
          <div v-if="!loading" class="row riceCropDetailFrame" style="height: max-content;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false, active.leftnNoneActive = true"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true, active.leftnNoneActive = false"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>
               <div class="right rightRiceCropDetail" data-bs-spy="scroll">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Theo dõi mùa vụ</h3>
                         </div>
                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row" style="margin-top: 130px; margin-left:20px; margin-right:0px">
                         <button class="btn btnCome-back" @click="goToRiceCrop()">Trở về</button>
                         <button class="btn btnCreate" @click="isOpenCreateImage = !isOpenCreateImage">Thêm</button>
                    </div>
                    <div class="row mt-4 function-row" style=" margin-left:5px;margin-right: 10px ">
                              <div class="image-class col-lg-3 col-md-4 col-sm-4" v-for="(image, i) in imagesList" :key="i"
                                   style="margin-bottom: 8px !important;">
                                   <ImageComponent :images="image" @clicked-something="handleClickInParent" />
                              </div>
                    </div>
                    <div class="confirmationDialog" v-if="isOpenConfirm">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelConfirm">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, deleteImage()">Xóa</button>
                         <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                              @click="isOpenConfirm = !isOpenConfirm">Hủy</button>
                    </div>

                    <div class="messageDialog" v-if="isOpenMessage">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelThongBao">
                              <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span>
                              {{
                                   message
                              }}
                         </p>
                         <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                              @click="isOpenMessage = !isOpenMessage">OK</button>
                    </div>

                    <CreateImageForm v-if="isOpenCreateImage" :newImage="newImage" :message1="message1" :message2="message2"
                         :newRiceCrop="newRiceCrop" @addImage-submit=createNewImage />
               </div>

          </div>
     </div>
</template>

<script >

import axios from 'axios';
import moment from 'moment';
import 'vue3-carousel/dist/carousel.css'
import { mapGetters, mapMutations } from "vuex";
import ImagesService from '@/services/images.service';
import RiceCropService from '@/services/riceCropInformation.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue'
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import Catalog from '../../../components/catalogManagementComponents/catalog.vue';
import CreateImageForm from '@/components/catalogManagementComponents/createImageForm.vue';
import ImageComponent from '@/components/catalogManagementComponents/imageComponent.vue';
export default {
     name: "sprayingTimes",

     props: ["id"],

     components: {
          Catalog,
          CreateImageForm,
          TopHeader,
          Preloader,
          ImageComponent,
     },

     data() {
          return {
               nameToSearch: "",
               newRiceCrop: {},
               imagesList: [],
               message1: "",
               message2: "",
               isOpenImage: false,
               newImage: {},
               idImage: 0,
               isOpenCreateImage: false,
               isOpenMessage: false,
               isOpenSearch: {
                    open: false,
                    close: true,
               },
               cloneImageList: [],
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               imageChosen: {},
               loading: true,
          }
     },

     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },

     created() {
          this.newRiceCrop.RiceCropInformation_id = this.$route.params.id;
          this.initEmployeeState();
     },

     methods: {

          ...mapMutations([
               "initEmployeeState"
          ]),

          filteredImagesList() {
               return this.cloneImageList.filter(image => {
                    return image.Images_date.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          async retrieveImagesList() {
               this.loading = true;
               const [error, response] = await this.handle(
                    ImagesService.findByName(this.newRiceCrop.RiceCropInformation_id)
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         console.log(error)
                    }
                    else {
                         this.imagesList = response.data;
                         this.imagesList.forEach(element => {
                              element.Image_link = require('@/images/' + element.Image_link);
                         });
                    }
                    if (this.loading == true) {
                         setTimeout(() => {
                              this.loading = false;
                         }, 900);
                    }
               }
          },

          async retrieveImageID(link) {
               this.getIdImage();
               const data = {};
               data.Employee_id = this.currentUser.Employee_id;
               data.Image_link = link;
               const day = new Date();
               data.Image_id = this.idImage;
               data.Image_date = moment(day).format("YYYY-MM-DD hh:mm:ss");
               data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
               const [error, response] = await this.handle(
                    ImagesService.create(data)
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         this.message = "Thêm không thành công.";
                    }
                    else if (response.data == "Không thể lưu hình ảnh.") {
                         this.message = "Thêm không thành công";
                    }
                    else {
                         this.message = "Thêm thành công.";
                    }
               }
          },


          async getIdImage() {
               const [error, response] = await this.handle(
                    ImagesService.getAll()
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         console.log(error)
                    }
                    else {
                         const temp = response.data;
                         if (temp.length > 0) {
                              this.idImage = temp[temp.length - 1].Image_id + 1;
                         }
                         else {
                              this.idImage = 1;

                         }
                    }
               }
          },

          async createNewImage(data) {
               if (data.close == false) {
                    this.isOpenCreateImage = false;
               }
               else {
                    if (data.Image != null) {
                         const formdata = require('form-data');
                         const formData = new formdata();
                         formData.append("image", data.Image);
                         axios.post('http://localhost:8080/api/image', formData, {
                              headers: {
                                   'Content-Type': `multipart/form-data;`,
                              }
                         },
                         ).then((response) => {
                              fnSuccess(response);
                         }).catch((error) => {
                              fnFail(error);
                         });

                         const fnSuccess = (response) => {
                              this.retrieveImageID(response.data.Image_link);
                              this.message2 = "Thêm thành công";
                         };

                         const fnFail = (error) => {
                              console.log(error);
                              this.message2 = "Thêm không thành công";
                         };
                    }
                    else {
                         this.message1 = "Vui lòng chọn hình ảnh!!"
                    }
               }
          },

          async setImageChosen(image) {
               this.imageChosen = image;
          },

          async deleteImage() {
               const [error, response] = await this.handle(
                    ImagesService.delete(this.imageChosen.Image_id)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa hình ảnh không thành công";
               } else {
                    this.message = "Xóa hình ảnh thành công";
                    console.log(response.data);
                    this.retrieveImagesList();
               }
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY hh:mm:ss A")).slice(0, 10);
          },

          formatTimes(data) {
               return moment(String(data)).format("hh:mm:ss A");
          },

          async retrieveNewRiceCrop() {
               const [err, respone] = await this.handle(
                    RiceCropService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {

                    this.newRiceCrop.RiceCropInformation_id = respone.data.RiceCropInformation_id;
                    this.newRiceCrop.RiceCropInformation_name = respone.data.RiceCropInformation_name;
                    this.newRiceCrop.Seed_id = respone.data.Seed_id;
                    this.newRiceCrop.Seed_name = respone.data.Seed_name;
                    this.newRiceCrop.RiceCropInformation_sowingDate = respone.data.RiceCropInformation_sowingDate;
                    this.newRiceCrop.RiceCropInformation_harvestDate = (moment(String(respone.data.RiceCropInformation_harvestDate)).format("YYYY-MM-DD")).slice(0, 10);
                    this.newRiceCrop.RiceCropInformation_yield = respone.data.RiceCropInformation_yield;
                    this.newRiceCrop.Crop_id = respone.data.Crop_id;
                    this.newRiceCrop.Crop_name = respone.data.Crop_name;
                    this.newRiceCrop.ArableLand_id = respone.data.ArableLand_id;
                    this.newRiceCrop.ArableLand_location = respone.data.ArableLand_location;
                    this.newRiceCrop.ArableLand_owner = respone.data.ArableLand_owner;
                    this.newRiceCrop.ArableLand_latitude = respone.data.ArableLand_latitude;
                    this.newRiceCrop.ArableLand_longitude = respone.data.ArableLand_longitude;
               }
          },

          goToRiceCrop() {
               this.$router.push({ name: 'RiceCropDetail', params: { id: this.newRiceCrop.RiceCropInformation_id } });
          },

     },

     mounted() {
          this.initEmployeeState();
          this.retrieveNewRiceCrop();
          this.retrieveImagesList();
     }
};
</script>

<style>
@import url(../../../assets/mainStyle.css);
@import url(../../../assets/riceCropDetailStyle.css);

.datetime {
     position: relative;
     margin-bottom: 0;
     float: left;
     color: #5C5D22;
     font-family: 'Roboto';
     font-style: normal;
     font-size: 16px;
}

.btnMoreInforImage {
     position: absolute;
     left: 92%;
}

.detail-image {
     border-radius: 0px !important;
     min-height: 220px !important;
}

.btnAddimage {
     background-color: rgb(241, 248, 164);
     border-radius: 5px;
}

/* .imageclass{
     max-height: 250px;
} */
@media only screen and (max-width: 1000px) {
     .datetime {
          font-size: 13px;
     }

     .btnMoreInforImage {
          position: absolute;
          bottom: -5px !important;
          left: 92%;

     }

}

@media only screen and (max-width: 576px) {
     .datetime {
          font-size: 13px;
     }

     .btnMoreInforImage {
          position: absolute;
          bottom: -5px !important;
          left: 92%;

     }

     .image-class {
          width:50% !important;
          height: auto;
          margin-left: 0px !important;
     }

}
</style>
