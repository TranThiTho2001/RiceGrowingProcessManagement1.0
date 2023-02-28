<template>
     <div style="height: 195px;" class="container-fuild">
               <div class="imageComponent text-dark border ">
                    <div class="img mt-2 ml-2 mr-2" style="min-height: 135px; max" ><img :src="images.Image_link" class="img-fluid" alt="" >
                    </div>
                    <div class="row" >
                         <div class="col-sm-10 ">
                              <div class="row pl-4 pr-4 infor">Ngày: {{ formatDate(images.Image_date) }}</div>                          
                              <div class="row pl-4 pr-4 infor">Giờ: {{ formatTimes(images.Image_date) }}</div>
                         
                         </div>
                         <div class="col-sm-2">
                              <i class="fas fa-ellipsis-v mt-2 "  style="color: #919302; font-size: 25px;"></i>
                         </div>
                    </div>
               </div>
     </div>
</template>
   
<script>

import moment from 'moment';

export default {
     name: "imageItem",

     props: ["images"],
     
     methods: {
          formatDate(data){
               return moment(String(data)).format("MM/DD/YYYY");
          },

          formatTimes(data){
               return moment(String(data)).format("hh:mm:ss A");
          }

     }
};
</script>
   
<style>
.imageComponent {
     margin-right: 10%;;
     -moz-border-radius: 2px;
     -webkit-border-radius: 2px;
     -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     border-radius: 10px;
     width: 96%;
     text-align: left;
     background-color: #FAFAFC;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.3);


}

.imageComponent:hover {
     background-color: #dfdfdf;
}

.imageComponent .fa-ellipsis-v{
     position: absolute;
     left: 10%;
}

.imageComponent .infor{
     font-family: Inter;
     font-size: 15px;
     color:rgb(195, 195, 103);
}
</style>