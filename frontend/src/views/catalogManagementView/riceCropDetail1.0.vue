<template>
     <div class="container-fluid riceCropDetail" style="background-color: #EAEAEA;">
          <div class="row riceCropDetailFrame">
               <div class="col-md-2">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>

               <div class="col-md-10 rightRiceCropDetail">
                    <div class="row mr-1 mt-2  ml-2 pb-5">
                         <div class="col-md-10 pr-5">
                         </div>
                         <div class="col-md-2 text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row List mr-2 mt-5 mb-2 ml-2" style="padding-top: 3%;">
                         <div class="col-sm-8">
                              <div class="row">
                                   <div class="col-sm-3 text-center contentFrame">
                                        <h4 class="name"><i class="fas fa-fill-drip"></i> Bón phân</h4>
                                        <hr>
                                        <h1 style="display: inline;"> {{ fertilizerTimesList.length }}</h1>
                                        <h4 class="times"> Lần</h4>
                                        <h6>Gần nhất: {{ formatDate(fertilizerEnd.FertilizerTimes_startDate) }}</h6>
                                   </div>
                                   <div class="col-sm-1"></div>
                                   <div class="col-sm-3 text-center contentFrame">
                                        <h4 class="name"><i class="fas fa-spray-can"></i> Phun Thuốc</h4>
                                        <hr>
                                        <h1 style="display: inline;">{{ SprayingTimesList.length }}</h1>
                                        <h4 class="times"> Lần</h4>
                                        <h6>Gần nhất: {{ formatDate(SprayingTimesEnd.SprayingTimes_startDate) }}</h6>
                                   </div>
                                   <div class="col-sm-1"></div>
                                   <div class="col-sm-3 text-center contentFrame">
                                        <h4 class="name"><i class="fas fa-spider"></i> Bệnh Dịch</h4>
                                        <hr>
                                        <h1 style="display: inline;">{{ epidemicTimesList.length }}</h1>
                                        <h4 class="times"> Lần</h4>
                                        <h6>Gần nhất: {{ formatDate(epidemicTimesEnd.EpidemicTimes_startDate) }}</h6>
                                   </div>
                              </div>

                              <div class="row mt-5">
                                   <div class="col-sm-3 text-center contentFrame">
                                        <h4 class="name"><i class="far fa-list-alt"></i> Hoạt Động</h4>
                                        <hr>
                                        <h1 style="display: inline;">{{ fertilizerTimesList.length }}</h1>
                                        <h4 class="times"> Lần</h4>
                                        <h6>Gần nhất: {{ formatDate(fertilizerEnd.FertilizerTimes_startDate) }}</h6>
                                   </div>
                                   <div class="col-sm-1"></div>
                                   <div class="col-sm-3 text-center contentFrame">
                                        <h4 class="name"><i class="far fa-image"></i> Hình Ảnh</h4>
                                        <hr>
                                        <h1 style="display: inline;"> {{ imagesList.length }}</h1>
                                        <h4 class="times"> Ảnh</h4>
                                        <h6>Gần nhất: {{ formatDate(this.imageEnd.Image_date) }}</h6>
                                   </div>
                                   <div class="col-sm-1"></div>
                                   <div class="col-sm-3 text-center contentFrame">
                                        <h4 class="name"><i class="fas fa-fill-drip"></i> Giám Sát
                                        </h4>
                                        <hr>
                                        <h1 style="display: inline;">{{ epidemicTimesList.length }}</h1>
                                        <h4 class="times"> Lần</h4>
                                        <h6>Gần nhất: {{ formatDate(epidemicTimesEnd.EpidemicTimes_startDate) }}</h6>
                                   </div>
                              </div>
                              <!-- https://openweathermap.org/img/wn/10d@2x.png -->
                              <div class="row">

                              </div>
                         </div>

                         <div class="col-sm-4 text-center informationcol">
                              <h3 class="mt-3">{{ newRiceCrop.RiceCropInformation_name }}</h3>
                              <div class="circle">
                                   <h4 class="day"> 34 </h4>
                                   <h5>Ngày</h5>
                              </div>
                              <table class="tableInfor mb-3" style="width:90%;">

                                   <tr style="width: 100%; border-top: none;">
                                        <td class="namerow">Mã</td>
                                        <td>
                                             <p>{{ newRiceCrop.RiceCropInformation_id }}</p>
                                        </td>
                                   </tr>
                                   <tr>
                                        <td class="namerow">Giống lúa</td>
                                        <td>
                                             <p>{{ newRiceCrop.Seed_name }}</p>
                                        </td>
                                   </tr>
                                   <tr>
                                        <td class="namerow">Vụ mùa</td>
                                        <td>
                                             <p>{{ newRiceCrop.Crop_name }}</p>
                                        </td>
                                   </tr>
                                   <tr>
                                        <td class="namerow">Mẫu ruộng</td>
                                        <td>
                                             <p>{{ newRiceCrop.ArableLand_id }}</p>
                                        </td>
                                   </tr>
                                   <tr>
                                        <td class="namerow">Ngày gieo xạ</td>
                                        <td>
                                             <p>{{ formatDate(newRiceCrop.RiceCropInformation_sowingDate) }}</p>
                                        </td>
                                   </tr>
                                   <tr>
                                        <td class="namerow">Ngày thu hoạch</td>
                                        <td>
                                             <p>{{ formatDate(newRiceCrop.RiceCropInformation_harvestDate) }}...</p>
                                        </td>
                                   </tr>
                                   <tr style="border-bottom: none;">
                                        <td class="namerow">
                                             <p>Năng suất</p>
                                        </td>
                                        <td>
                                             <p>{{ newRiceCrop.RiceCropInformation_yield }} ...</p>
                                        </td>
                                   </tr>

                              </table>

                         </div>

                    </div>
               </div>
          </div>

     </div>
</template>

<script>
import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import MonitorService from '@/services/monitor.service';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import RiceCropService from '@/services/riceCropInformation.service';
import EpidemicTimesService from '@/services/epidemicTimes.service';
import SprayingTimesService from '@/services/sprayingTimes.service';
import FertilizerTimesService from '@/services/fertilizerTimes.service';
import OtherActivitiesService from '@/services/otherActivities.service';
import ImagesService from '@/services/images.service';
export default {
     name: "riceCropDetail",

     props: ["riceCrop"],

     components: {
          Catalog,
          TopHeader,
     },

     data() {
          return {
               newRiceCrop: {},
               fertilizerTimesList: [],
               fertilizerEnd: {},
               SprayingTimesList: [],
               SprayingTimesEnd: {},
               epidemicTimesList: [],
               epidemicTimesEnd: {},
               otherActivitiesList: [],
               otherActivitiesEnd: {},
               monitorList: [],
               imagesList: [],
               imageEnd: {},
               weather: {},
          }
     },

     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),
     },

     created() {
          this.newRiceCrop.RiceCropInformation_id = this.$route.params.id;
          this.initEmployeeState();
     },

     mounted() {
          this.retrieveNewRiceCrop();
          this.retrieveEpidemicTimesList();
          this.retrieveFertilizerTimesList();
          this.retrieveMonitorList();
          this.retrieveSprayingTimesList();
          this.retrieveOtherActivitiesList();
          this.retrieveImagesList();
          this.getAPI()
          
     },

     methods: {

          ...mapMutations([
               "initEmployeeState"
          ]),

          async retrieveFertilizerTimesList() {
               const [err, respone] = await this.handle(
                    FertilizerTimesService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.fertilizerTimesList = respone.data;
                    this.fertilizerEnd = this.fertilizerTimesList[this.fertilizerTimesList.length - 1];
               }
          },

          async retrieveSprayingTimesList() {
               const [err, respone] = await this.handle(
                    SprayingTimesService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.SprayingTimesList = respone.data;
                    this.SprayingTimesEnd = this.SprayingTimesList[this.SprayingTimesList.length - 1];
               }
          },

          async retrieveEpidemicTimesList() {
               const [err, respone] = await this.handle(
                    EpidemicTimesService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.epidemicTimesList = respone.data;
                    this.epidemicTimesEnd = this.epidemicTimesList[this.epidemicTimesList.length - 1];
               }
          },

          async retrieveMonitorList() {
               const [err, respone] = await this.handle(
                    MonitorService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.monitorList = respone.data;
                    this.monitorList.forEach(element => {
                         if (element.Role_id == '01') {
                              element.Role_name = "Quản trị viên";
                         }
                         else if (element.Role_id == '02') {
                              element.Role_name = "Chuyên gia";
                         }
                         else {
                              element.Role_name = "Nhân viên"
                         }
                    });
                    console.log(respone.data);
               }
          },

          async retrieveOtherActivitiesList() {
               const [err, respone] = await this.handle(
                    OtherActivitiesService.getAll(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.otherActivitiesList = respone.data;
                    this.otherActivitiesEnd = this.otherActivitiesList[this.otherActivitiesList.length - 1];
               }
          },

          async retrieveImagesList() {
               const [error, response] = await this.handle(
                    ImagesService.findByName(this.newRiceCrop.RiceCropInformation_id)
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         console.log(error)
                    }
                    else {
                         this.imagesList = response.data;
                         this.imagesList.forEach(element => {
                              element.Image_link = require('@/images/' + element.Image_link);
                         });
                         this.imageEnd = this.imagesList[this.imagesList.length - 1];
                    }
               }
          },

          async retrieveNewRiceCrop() {
               const [err, respone] = await this.handle(
                    RiceCropService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {

                    this.newRiceCrop.RiceCropInformation_id = respone.data.RiceCropInformation_id;
                    this.newRiceCrop.RiceCropInformation_name = respone.data.RiceCropInformation_name;
                    this.newRiceCrop.Seed_id = respone.data.Seed_id;
                    this.newRiceCrop.Seed_name = respone.data.Seed_name;
                    this.newRiceCrop.RiceCropInformation_sowingDate = respone.data.RiceCropInformation_sowingDate;
                    this.newRiceCrop.RiceCropInformation_harvestDate = respone.data.RiceCropInformation_harvestDate;
                    this.newRiceCrop.RiceCropInformation_yield = respone.data.RiceCropInformation_yield;
                    this.newRiceCrop.Crop_id = respone.data.Crop_id;
                    this.newRiceCrop.Crop_name = respone.data.Crop_name;
                    this.newRiceCrop.ArableLand_id = respone.data.ArableLand_id;
                    console.log(respone.data);
               }
          },

          formatDate(data) {
               if (data == null) return "";
               return (moment(String(data)).format("YYYY-MM-DD")).slice(0, 10);
          },


          async getAPI() {
               // let urlAPI = `https://api.openweathermap.org/data/2.5/weather?q=Can Tho&lang=vi&appid=9aed1da02f473617712a9955f04e0d01`;

               // let data = await fetch(urlAPI).then(res => res.json())
               // this.weather.temp = (data.main.temp - 273.15).toFixed(0);
               // this.weather.rain = data.weather[0].main;
               // this.weather.humidity = data.main.humidity;
               // this.weather.icon = "https://openweathermap.org/img/wn/"+data.weather[0].icon+"@2x.png";

               // this.weather.description= data.weather[0].description;
               // console.log(this.weather);
          }

     }



}
</script>

<style>
@import url(../../assets/riceCropDetailStyle.css);

.contentFrame {
     /* background-color: rgb(174, 174, 172); */
     border-radius: 10px;
     border: 1px solid #a4a4a3;

}

.name {
     font-size: 25px;
}

tr {
     text-align: left;
     border-bottom: 1px solid #ddd;
     font-size: 18px;
     font-family: Inter;
     border-radius: 10px;
     width: 100px;
}

tr .namerow {
     font-size: 16px;
}

.tableInfor {
     position: relative;
     left: 10%;
     border-radius: 10px;
}

.circle {
     background: #dff189;
     clip-path: circle(50%);
     height: 7em;
     width: 7em;
     position: relative;
     left: 33%;
}

.day {
     text-align: center;
     justify-content: center;
     justify-items: center;
     justify-self: center;
     font-size: 60px;
}

.informationcol {
     border-radius: 10px;
     border: 1px solid #dff189;
     background-color: #f1fac6;
}

.times {
     display: inline;
     padding-bottom: 3px;
     /* top:-3%; */
}
</style>