<template>
     <div class="reportPDF continer text-center">
          <div class="row">
               <div class="col-sm-3">
                    <h4>Cộng hòa xs hội </h4>
               </div>
               <div class="col-sm-1"></div>
               <div class="col-sm-3">
                    <img src="../../assets/logo.png">
               </div>
          </div>
          <div class="ml-2 mr-2" style="width: 80%;">
               <table class="table tabelreport">
                    <thead>
                         <tr>
                              <th class="text-center" >STT</th>
                              <th class="text-center">Mã</th>
                              <th>Tên</th>
                              <th>Giống lúa</th>
                              <th>Vụ mùa</th>
                              <th>Mẫu ruộng</th>
                              <th>Ngày gieo xạ</th>
                                                  <th>Ngày thu hoạch</th>
                                                  <th>Năng suất</th>
                         </tr>
                    </thead>
                    <tbody>
                         <tr v-for="(riceCrop, i ) in ricecroplist" :key="i">
                              <td class="text-center">{{ i + 1 }}</td>
                              <td class="text-center">{{ riceCrop.RiceCropInformation_id }}</td>
                              <td>{{ riceCrop.RiceCropInformation_name }}</td>
                              <td>{{ riceCrop.Seed_name }}</td>
                              <td>{{ riceCrop.Crop_name }}</td>
                              <td>{{ riceCrop.ArableLand_owner }}</td>
                              <td>{{ formatDate(riceCrop.RiceCropInformation_sowingDate) }}</td>
                                                  <td>{{ formatDate(riceCrop.RiceCropInformation_harvestDate) }}</td>
                                                  <td>{{ formatYield(riceCrop.RiceCropInformation_yield) }}</td>

                         </tr>
                    </tbody>
               </table>

          </div>
     </div>
</template>
   
<script>
import moment from 'moment';
export default {
     name: "riceCrop",

     props: ["riceCropList"],

     data(){
          return{
               ricecroplist: this.riceCropList,
          }
     },
     methods: {
          formatDate(data) {
               if (data != null)
                    return (moment(String(data)).format("DD-MM-YYYY")).slice(0, 10);
               return "...";
          },

          formatYield(data) {
               if (data != null) {
                    return data;
               }
               return "...";
          }
     }
};
</script>
   
<style>
@page {
     size: 21cm 29.7cm;
     margin: 30mm 45mm 30mm 45mm;
     /* change the margins as you want them to be. */
}
.tabelreport{
     width: 80%;
     margin-left: 4%;
     margin-right: 5%;
}
.tabelreport tbody tr td{
     font-size: 10px;

}    
.reportPDF{
     width: 90%;
     background-color: aqua;
}



.riceCropComponent .fa-info-circle {}
</style>