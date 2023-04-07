<template>
     <div style="height: 260px; min-width: 197px;">
          <router-link class="linktoRiceCropInfor container-fuild"
               :to="{ name: 'RiceCropDetail', params: { id: riceCrop.RiceCropInformation_id } }">
               <div class="riceCropComponent text-dark border">
                    <div class="img mt-2 ml-2 mr-2 text-center"><img :src="riceCrop.Images_link" class="img-fluid" alt=""
                              style="max-height: 127px; min-height: 127px;">
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
                         <div class="row pl-3 mb-2">
                              <table style="width: 90%;">
                                   <tr>
                                        <td class="text-center"><i class="fas fa-info-circle mt-1"
                                                  style="color: #919302; font-size: 26px;"></i></td>
                                        <td class="text-center">
                                             <button v-if="riceCrop.RiceCropInformation_harvestDate != null"
                                                  class="btn btnFinish">Đã kết thúc</button>
                                             <button v-if="riceCrop.RiceCropInformation_harvestDate == null"
                                                  class="btn btn-sm btnMonitoring ">Đang theo dõi</button>
                                        </td>
                                        <td class="text-center"><i class="fas fa-ellipsis-v mt-1 "
                                                  style="color: #919302; font-size: 25px; ">
                                                  <div class="deleteIcon ">
                                                       <a style="width: 70px; height: 30px; background-color:#919302; font-size: 15px;"
                                                            class="row">Xoas
                                                       </a>
                                                  </div>
                                             </i></td>
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
     padding: 1px;
     border: none;
}


.riceCropComponent {
     /* margin-right: 10%; */
     margin-top: 2%;
     -moz-border-radius: 2px;
     -webkit-border-radius: 2px;
     -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     border-radius: 10px;
     width: 197px;
     text-align: left;
     background-color: #FAFAFC;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.3);
     position: relative;
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
     display: flex;
     
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


.riceCropComponent .fa-info-circle {}</style>