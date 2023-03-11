<template>
     <div style="height: 260px; min-width: 203px;">
          <router-link class="linktoRiceCropInfor container-fuild"
               :to="{ name: 'RiceCropDetail', params: { id: riceCrop.RiceCropInformation_id } }">
               <div class="riceCropComponent text-dark border ">
                    <div class="img mt-2 ml-2 mr-2 text-center" ><img :src="riceCrop.Images_link"
                              class="img-fluid" alt="" style="max-height: 127px; min-height: 127px;">
                    </div>
                    <div class="body-riceCropComponent">
                         <div class="row ml-1 mr-1">
                              <div class="col">
                                   <strong class="font-weight-bold text-left">
                                        <span class="textid">{{ riceCrop.RiceCropInformation_id }}</span>
                                   </strong>

                                   <p class="textname">
                                        {{ riceCrop.RiceCropInformation_name }}
                                   </p>
                              </div>
                         </div>
                         <div class="row pl-2 pr-1 mb-2">
                              <div class="col-sm-2">
                                   <i class="fas fa-info-circle mt-2" style="color: #919302; font-size: 27px;"></i>
                              </div>
                              <div class="col-sm-8 text-center" v-if="riceCrop.RiceCropInformation_harvestDate == null">
                                   <button class="btn  btn-sm btnMonitoring ">Đang theo dõi</button>
                              </div>
                              <div class="col-sm-8 text-center" v-if="riceCrop.RiceCropInformation_harvestDate != null">
                                   <button class="btn  btnFinish">Đã kết thúc</button>
                              </div>
                              <div class="col-sm-2 opendelete">
                                   <i class="fas fa-ellipsis-v mt-2 pr-1" style="color: #919302; font-size: 25px;">
                                        <div class="deleteIcon ">
                                             <a style="width: 70px; height: 30px; background-color:#919302; font-size: 15px;" class="row">Xoas
                                             </a>
                                        </div>
                                   </i>
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
     padding: 1px;
     border: none;
}


.riceCropComponent {
     margin-right: 10%;
     margin-top: 2%;
     -moz-border-radius: 2px;
     -webkit-border-radius: 2px;
     -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     border-radius: 10px;
     width: 91%;
     text-align: left;
     background-color: #FAFAFC;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.3);


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
     font-family: Inter;
     white-space: nowrap;
     overflow: hidden;
     text-overflow: ellipsis;
     font-size: 18px;
     color: #008B8E;
}

.riceCropComponent .textname {
     font-family: Inter;
     font-size: 16px;
     color: #919302;
     font-weight: 500;
     white-space: nowrap;
     overflow: hidden;
     text-overflow: ellipsis;
}

.riceCropComponent .textTenSanPham {
     white-space: nowrap;
     overflow: hidden;
     text-overflow: ellipsis;
     font-family: Inter;
     font-size: 18px;
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
     position: absolute;
     display: flex;
     left: 14%;
     top: 15%
}

.riceCropComponent .btnFinish {
     color: #6D6E73;
     background-color: #ABD2C8;
     position: absolute;
     left: 15%;
}

.riceCropComponent .btnMonitoring {
     color: #5C5D22;
     background: #EEEA41;
     position: absolute;
     left: 11%;
}

.riceCropComponent .fa-ellipsis-v {
     position: absolute;
     left: 30%;
}

.riceCropComponent .deleteIcon {
     position: absolute;
     display: none;
}

.riceCropComponent .fa-ellipsis-v:hover .deleteIcon {
     display: inline;
     left: -300%;
     top: 95%;
}
.riceCropComponent .fa-info-circle{
     margin-top: 5px;

}
</style>