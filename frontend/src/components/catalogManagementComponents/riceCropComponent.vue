<template><!-- <router-link class="linktoCTSP container-fuild" :to="{ name: 'CTSP', params: { id: sanpham.SP_Ma } }"> -->
     <div class="sanpham text-dark border bg-light ">
          <div class="hinhanh m-3"><img src="../../assets/Giong-lua-ST25.png" class="img-fluid" alt="">
          </div>
          <div class="body-sp ">
               <div class="row ml-1 mr-1">
                    <div class="col">
                         <strong class="font-weight-bold text-left">
                              <span class="textid">{{ riceCrop.RiceCropInformation_id }}</span>
                         </strong>

                         <p class=" textname">
                              {{ riceCrop.RiceCropInformation_name }}
                         </p>
                    </div>
               </div>
               <div class="row ml-1 mr-1">
                    <div class="col-sm-2">
                         <i class="fas fa-info-circle" style="color: #919302; font-size: 30px;"></i>
                    </div>
                    <div class="col-sm-8 text-center" v-if="riceCrop.RiceCropInformation_harvestDate == null">
                         <div class="mt-1 mb-1" style="background-color: #EEEA41; border-radius: 10px;"><p>Đang theo dõi</p></div>
                    </div>
                    <div class="col-sm-8 text-center" v-if="riceCrop.RiceCropInformation_harvestDate != null">
                         <p>Đã kết thúc</p>
                    </div>
                    <div class="col-sm-2">
                         <i class="fas fa-ellipsis-v" style="color: #919302; font-size: 25px;"></i>
                    </div>
               </div>

          </div>
     </div>
<!-- </router-link>  --></template>
   
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

.body-sp {
     padding: 1px;
     border: none;
}

.body-sp:hover {
     color: white;
     background-color: #515151;
     border-color: #515151;
}

.sanpham {
     padding: 2px 2px 3px;
     margin: 0 auto 2px;
     margin-top: 5%;
     margin-bottom: 20%;
     -moz-border-radius: 2px;
     -webkit-border-radius: 2px;
     -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25), inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     border-radius: 10px;
     width: 100%;
}

.add-btn:hover {
     color: #515151;
     /* background-color: #515151; */
     border-color: #413e3e;
}

.linktoCTSP {
     text-decoration: none;
}

.linktoCTSP:hover {
     text-decoration: none;
}

.sanpham .textid {
     font-family: Inter;
     white-space: nowrap;
     overflow: hidden;
     text-overflow: ellipsis;
     font-size: 18px;
     color: #008B8E;
}

.sanpham .textname {
     font-family: Inter;
     font-size: 15px;
     color: #919302;
}

.sanpham .textTenSanPham {
     white-space: nowrap;
     overflow: hidden;
     text-overflow: ellipsis;
     font-family: Inter;
     font-size: 18px;
}
</style>