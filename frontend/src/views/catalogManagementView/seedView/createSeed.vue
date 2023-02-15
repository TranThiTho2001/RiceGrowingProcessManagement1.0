<template>

     <div class="container-fluid createNewSeedFrame">
         <div class="row">
             <div class="col-md-2"></div>
             <div class="col-md-8 col-sm-10">
                 <CreateNewSeedForm :newSeed="newSeed" @addSeed-submit="createSeed"
                     :message1="message1" :message2="message2" />
             </div>
             <div class="col-md-2"></div>
         </div>
     </div>
 
 </template>
 
 <script>
//  import CreateNewSeedForm from
 import SeedService from '../../services/employee.service';
 
 export default {
     name: "createNewSeed",
     components: { CreateNewSeedForm },
     data() {
         return {
             newSeed: {},
             message1: " ",
             message2: " ",
         };
     },
     methods: {
         async createSeed(data) {
             this.message1 = "";
             this.message2 = "";
             const [error, respone] = await this.handle(
                 SeedService.create(data)
             );
             if (error) {
                 console.log(error);
                 this.message1 = "Thêm không thành công."
             } else if (respone.data == "Đã xảy ra lỗi!!!") {
                 this.message1 = "Thêm không thành công."
             } else {
                 this.message2 = "Thêm thành công.";

             }
         },
 
     },
 
 
 }
 
 </script>
 
 <style>
 
 </style>