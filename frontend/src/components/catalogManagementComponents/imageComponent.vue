<template>
     <div class="container-fuild">
          <div class="imageComponent text-dark border">
               <div class=" mt-2 ml-2 mr-2 text-center"><img :src="images.Image_link" class="img-fluid img-class" alt=""
                         style="height: 200px;">
               </div>
               <div class="row ml-2 mr-2">
                    <div style="width: 80%;">
                         <div class="datetime">{{ formatDate(images.Image_date) }}</div>
                         <div class="datetime">{{ formatTimes(images.Image_date) }}</div>
                    </div>
                    <div style="width: 20%;">
                         <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown" aria-haspopup="true"
                              aria-expanded="false">
                              <i class="fas fa-ellipsis-v mt-2 " style="color: #919302; font-size: 25px;"></i>
                         </button>
                         <div class="dropdown-menu" style="width: 20px !important;">
                              <a class="dropdown-item" href="#"
                                   @click="deleteImage()">
                                   <span class="fas fa-trash-alt actionIcon"></span>
                                   Xóa
                              </a>
                         </div>
                    </div>
               </div>
          </div>
     </div>
</template>
   
<script>

import moment from 'moment';
import imagesService from '@/services/images.service';
export default {
     name: "imageItem",

     props: ["images"],
     data(){
          return{
               image: this.images,
          }
     },

     methods: {
          formatDate(data) {
               return moment(String(data)).format("MM/DD/YYYY");
          },

          formatTimes(data) {
               return moment(String(data)).format("hh:mm:ss A");
          },

          async deleteImage() {
               const [error, response] = await this.handle(
                    imagesService.delete(this.image.Image_id)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa hình ảnh không thành công";
               } else {
                    this.message = "Xóa hình ảnh thành công";
                    console.log(response.data)
                    this.$emit('clicked-something')
               }
          },

     }
};
</script>
   
<style>
.imageComponent {
     -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     text-align: left;
     background-color: #FAFAFC;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.3);
}

.imageComponent:hover {
     background-color: #dfdfdf;
}

@media only screen and (max-width: 576px) {
     .img-class{
          height: 110px !important;
     }

     .datetime{
          font-size: 13px !important;
     }
}

.imageComponent .btnMore {
     float: right;
}

.imageComponent .datetime {
     font-size: 15px;
     color: rgb(195, 195, 103);
}
</style>