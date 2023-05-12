<template>
     <div style="height: 98%; width:100%; margin-top: 0px !important;" class="responsiveComponent">
          <router-link class="linktoRiceCropInfor container-fluid"
               :to="{ name: 'RiceCropDetail', params: { id: riceCrop.RiceCropInformation_id } }">
               <div class="riceCropComponent text-dark border row">
                    <div class="img text-center " style="height: 64%; width: 94%;">
                         <img :src="riceCrop.Images_link" class="img-fluid imageRiceCrop" alt=""
                              style=" display: block; max-height: 190px;">
                    </div>

                    <div class="row body-riceCropComponent ">
                         <div class="col-sm-12" style="margin-top: 10px !important; margin-left: 4%;">
                              <div class="row">
                                   <p class="textid">{{ riceCrop.RiceCropInformation_name }}</p>
                              </div>

                              <div class="row">
                                   <div style="width: 80%; padding-left: 2px;">
                                        <p class="textname">
                                             {{ riceCrop.Province_name }}
                                        </p>
                                        <p class="textname">
                                             {{ riceCrop.ArableLand_owner }}
                                        </p>
                                   </div>

                                   <div class="text-right" style="width: 80%;">
                                        <button v-if="riceCrop.RiceCropInformation_harvestDate == null"
                                             class="btn btn-sm btnMonitoring ">{{
                                                  get_day_of_time(riceCrop.RiceCropInformation_sowingDate) }} Ngày</button>
                                        <button v-if="riceCrop.RiceCropInformation_harvestDate != null"
                                             class="btn btnFinish">
                                             Kết thúc</button>
                                   </div>
                              </div>
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

          get_day_of_time(d1) {
               let ms1 = (new Date(d1)).getTime();
               var d2 = new Date();
               let ms2 = d2.getTime();
               return Math.ceil((ms2 - ms1) / (24 * 60 * 60 * 1000));
          },
     },

};
</script>
   
<style>
#name {
     font-family: "Playfair Display";
     color: #756262;
}

.body-riceCropComponent {
     border: none;
     padding-top: 0px;
     margin-bottom: 2px;
     margin-left: -2% !important;
     height: max-content;
     margin-top: 2%;
     width: 100%;
     display: inline;
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
     border-radius: 10px;
     align-items: center;
     padding: 2px 4px 2px 4px;
     margin: auto;
     margin-top: 17px;
     position: absolute;
     top: 25px;
     right: 4%;
     z-index: 15;
}

.riceCropComponent .btnFinish {
     color: #6D6E73;
     background-color: #ABD2C8;
}

.riceCropComponent .btnMonitoring {
     color: #5C5D22;
     background: #EEEA41;

}

.riceCropComponent .deleteIcon {
     position: absolute;
     display: none;
}

.img {
     margin-left: auto;
     margin-right: auto;
     margin-top: 2%;
}

.imageRiceCrop {
     max-width: 100%;
     margin: auto;
     display: block;
     margin-left: auto;
     margin-right: auto;
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

     .imageRiceCrop {
          max-width: 100%;
          max-height: 140px !important;
          margin: auto;
          display: block;
          margin-left: auto;
          margin-right: auto;
     }

     .img {
          height: 90px !important;
     }

     .responsiveComponent {
          width: 115% !important;
          display: inline-block;
     }

     .riceCropComponent .btnMonitoring,
     .riceCropComponent .btnFinish {
          position: relative;
          margin-top: 2px !important;
          left: -59%;
          right: 0%;
          top: 2px;
     }
}

@media screen and (max-width: 400px) {

     .riceCropComponent .btnMonitoring,
     .riceCropComponent .btnFinish {
          position: relative;
          margin-top: 2px !important;
          left: -50%;
          right: 0%;
          top: 2px;
     }
}

.responsiveComponent {
     width: 100%;
     display: inline-block;
}
</style>