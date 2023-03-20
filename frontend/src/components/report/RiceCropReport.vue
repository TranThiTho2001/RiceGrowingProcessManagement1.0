<template >
     <div class="reportPDF  text-center">
          <div style="">
          <div class="row topHeader" style="">
               <div class="center">
                    <p>BỘ GIÁO DỤC VÀ ĐÀO TẠO</p>
                    <P>TRƯỜNG ĐẠI HỌC CẦN THƠ</P>
                    <hr>
               </div>
               <div class=" text-center ml-3">
                    <p>CỘNG HÒA XÃ HỌI CHỦ NGHĨA VIỆT NAM</p>
                    <p>Độc lập - Tự do - Hạnh phúc</p>
                    <p>Cần Thơ, ngày {{ getDate() }} tháng {{ getMonth() }} năm {{ getYear() }}</p>
               </div>
          </div>
          <div class="row" style="">
               <table class="table tabelreport" style="page-break-inside: avoid; ">
                    <thead>
                         <tr>
                              <th class="text-center">STT</th>
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
          },

          getDate(){
               const date = new Date();
               console.log("alo")
               console.log(this.riceCropList)
               return date.getDate();
          },

          getMonth(){
               const date = new Date();
               return date.getMonth();
          },

          getYear(){
               const date = new Date();
               return date.getYear();
          }

     }
};
</script>
   
<style>
@page wide {
  size: a4 portrait;
}

@page{
     table-layout: auto;
}
/* Targets all odd-numbered pages */

.tabelreport{
     width: 100% !important;
     page-break-inside: avoid; 

}
.tabelreport tbody tr td{
     font-size: 10px;

}    
.reportPDF{ 
     /* width: 90%; */
     margin-left: 3cm;
     margin-right: 2cm;
     margin-top: 2cm;
     margin-bottom: 2cm;
     background-color: aqua;
     page-break-inside: avoid; 
     /* padding-left: 3cm; padding-right: 2cm; padding-top: 2cm; padding-bottom: 2cm; */
}



.riceCropComponent .fa-info-circle {}
</style>