<template>
     <div style="height: 98%; width:100%; margin-top: 0px !important;" class="responsiveComponent">
          <router-link class="linktoRiceCropInfor container-fluid"
               :to="{ name: 'RiceCropDetail', params: { id: riceCrop.RiceCropInformation_id } }">
               <div class="riceCropComponent text-dark border">
                    <div class="img mt-2 ml-2 mr-2 text-center" style="height: 64%; width: 94%; display: inline-flexbox;"><img
                              :src="riceCrop.Images_link" class="img-fluid" alt="">
                    </div>
                    <div class="body-riceCropComponent">
                         <div class="" style="margin-top: 0px !important;">
                                   <p class="textid">{{ riceCrop.RiceCropInformation_id }}</p>
                              
                                   <p class="textname">
                                        {{ riceCrop.RiceCropInformation_name }}
                                   </p>
                         </div>
                         <div class="row ml-2 mr-1">
                              <table style="width: 95%;">
                                   <tr>
                                        <td class="text-center"><i class="fas fa-info-circle mt-1"
                                                  style="color: #919302; font-size: 26px;"></i></td>
                                        <td class="col-sm-12 text-center" style="justify-content: center;">
                                             <button v-if="riceCrop.RiceCropInformation_harvestDate != null"
                                                  class="btn btnFinish">Đã kết thúc</button>
                                             <button v-if="riceCrop.RiceCropInformation_harvestDate == null"
                                                  class="btn btn-sm btnMonitoring ">Đang theo dõi</button>
                                        </td>
                                        <td class="text-center"><i class="fas fa-ellipsis-v mt-1 mb-2"
                                                  style="color: #919302; font-size: 25px; ">
                                                  <div class="deleteIcon ">
                                                       <a style="width: 70px; height: 30px; background-color:#919302; font-size: 15px;"
                                                            class="row">Xoas
                                                       </a>
                                                  </div>
                                             </i>
                                        </td>
                                   </tr>

                              </table>

                         </div> 
                    </div>
               </div>
          </router-link>
     </div>
</template>
   
<script>

export default {
     name: "riceCrop",

     props: ["riceCrop"],

     methods: {
          formatMoney(data) {
               let val = (data / 1).toFixed(0).replace(".", ",");
               return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
          },

     }
};
</script>
   
<style>
#name {
     font-family: "Playfair Display";
     color: #756262;
}

.body-riceCropComponent {
     padding: 1px 1px 1px 1px;
     border: none;
     padding-top: 0px;
     margin-bottom: 2px;
     position: relative;
     display: inline-flexbox;
     height: max-content;
     margin-bottom: 2px;
}


.riceCropComponent {
     border-radius: 10px;
     width: 100%;
     height: 92%;
     max-height: 325px;
     text-align: left;
     background-color: #FAFAFC;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.3);
     position: relative;
     margin-top: -5% !important;
}

.riceCropComponent:hover {
     background-color: #dfdfdf;
}

.add-btn:hover {
     color: #919302;
     /* background-color: #515151; */
     border-color: #413e3e;
}

.linktoRiceCropInfor {
     text-decoration: none;
}

.linktoRiceCropInfor:hover {
     text-decoration: none;
}

.riceCropComponent .textid {
     white-space: nowrap;
     overflow: hidden;
     text-overflow: ellipsis;
     font-size: 19px;
     font-weight: 700;
     color: #008B8E;
     margin-bottom: 1px !important;
     margin-left: 2%;
     font-family: 'Roboto';
}

.riceCropComponent .textname {
     font-size: 16px;
     color: #919302;
     font-weight: 500;
     white-space: nowrap;
     overflow: hidden;
     text-overflow: ellipsis;
     margin-bottom: 1px !important;
     margin-left: 2%;
     font-size: 17px;
     font-family: 'Roboto';
}

.riceCropComponent .btnMonitoring,
.riceCropComponent .btnFinish {
     font-size: 16px;
     width: max-content;
     font-weight: 600;
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     border-radius: 15px;
     justify-content: center;
     align-items: center;
     height: 30px;
     display: flex;
     margin-left: 20% !important;

}

.riceCropComponent .btnFinish {
     color: #6D6E73;
     background-color: #ABD2C8;
     margin-left: 10px;
}

.riceCropComponent .btnMonitoring {
     color: #5C5D22;
     background: #EEEA41;
     margin-left: 6px;
}

.riceCropComponent .deleteIcon {
     position: absolute;
     display: none;
}

@media screen and (max-width: 576px) {
     .riceCropComponent {
          height: 95% !important;
          max-height: 450px;
     }

     .body-riceCropComponent {
          padding: 1px;
          border: none;
          padding-top: 20px !important;
     }
}
</style>