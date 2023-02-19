<template><!-- <router-link class="linktoCTSP container-fuild" :to="{ name: 'CTSP', params: { id: sanpham.SP_Ma } }"> -->
    <div class="sanpham text-dark border bg-light ">
        <div class="hinhanh"><img style="border-radius:20px" src="../../assets/Giong-lua-ST25.png" class="img-fluid" alt="">
        </div>
        <div class="body-sp border" style="border-radius: 20px; ">
            <div class="row">
                <div class="col-md-6">
                    <div class="col">
                        <strong class="font-weight-bold text-left">
                            <span class="textThuongHieu">{{ seed.Seed_name }}</span>
                        </strong>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="col pe-4">
                        <p class="text-right textGiaBan">
                            {{ seed.Seed_Name }}
                        </p>
                    </div>
                </div>
            </div>
            <!--  
                     <div class="row">
                         <div class="col-12">
                             <div class="col d-flex flex-column position-static pb-2">
                                 <span class="fw-bold fs-6 textTenSanPham">
                                     {{  }}
                                 </span>
                             </div>
                         </div>
     
                     </div> -->
            <!-- <div class="row">
                         <div class="col-9">
                             <div class="row">
                                 <span class="d-inline-block ps-3">
                                     <i style="color: #F1B5B5; display: inline; font-size: 22px;" class="fas fa-star"></i>
                                     <i style="color: #F1B5B5; display: inline; font-size: 22px;" class="fas fa-star"></i>
                                     <i style="color: #F1B5B5;display: inline;font-size: 22px; " class="fas fa-star"></i>
                                     <i style="color: #F1B5B5;display: inline; font-size: 22px;" class="fas fa-star"></i>
                                     <i style="color: #F1B5B5;display: inline; font-size: 22px;" class="fas fa-star"></i>
                                 </span>
                             </div>
                         </div>
                         <div class="col-3">
                             <div class="ol d-flex flex-column position-static">
                                 <strong class="d-inline-block">
                                     <span><i style="color: white; font-size: 25px;"
                                             class=" fas fa-lg fa-plus-circle"></i></span>
     
                                 </strong>
                             </div>
                         </div>
                     </div> -->
        </div>
    </div>
<!-- </router-link> --></template>
  
<script>
export default {
    name: "SanPham",
    props: ["seed"],

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
    background-color: #d0cfcf;
    padding: 1px;
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
    border-radius: 20px;
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

.sanpham .textThuongHieu {
    font-family: Inter;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 18px;
}

.sanpham .textGiaBan {
    font-family: Inter;
    font-size: 15px;
}

.sanpham .textTenSanPham {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-family: Inter;
    font-size: 18px;
}
</style>