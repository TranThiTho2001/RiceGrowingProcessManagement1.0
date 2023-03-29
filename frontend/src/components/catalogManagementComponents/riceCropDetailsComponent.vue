<template>
     <div class="container-fluid riceCropDetailComponent">
          <div class="row">
               <h2>Thông tin mùa vụ</h2>
               <table class="table">
                    <thead>
                         <tr>
                              <th class="centerclass">Mã mùa vụ</th>
                              <th>Tên mùa vụ</th>
                              <th>Vụ mùa</th>
                              <th>Giống lúa</th>
                              <th>Mẫu ruộng</th>
                              <th class="centerclass">Ngày gieo xạ</th>
                         </tr>
                    </thead>
                    <tbody>
                         <tr>
                              <td class="centerclass" data-label="Mã mùa vụ">{{ riceCrop.RiceCropInformation_id }}</td>
                              <td data-label="Tên mùa vụ">{{
                                   riceCrop.RiceCropInformation_name }}</td>
                              <td data-label="Vụ mùa">{{ riceCrop.Crop_name }}</td>
                              <td data-label="Giống lúa">{{ riceCrop.Seed_name }}</td>
                              <td data-label="Mẫu ruộng">{{ riceCrop.ArableLand_owner }}</td>
                              <td class="centerclass" data-label="Ngày gieo xạ">{{
                                   formatDate(riceCrop.RiceCropInformation_sowingDate) }}</td>
                         </tr>
                    </tbody>
               </table>
          </div>

          <div class="row">
               <h2>Hoạt động bón phân</h2>
               <table class="table">
                    <thead>
                         <tr>
                              <th class="text-center ">Lần</th>
                              <th>Tên phân bón</th>
                              <th class="text-center ">Số lượng (kg/ha)</th>
                              <th class="text-center ">Ngày bất đầu</th>
                              <th class="text-center ">Ngày kết thúc</th>
                              <th class="">Nhân viên</th>
                         </tr>
                    </thead>
                    <tbody>
                         <tr v-for="(fertilizer, i) in (fertilizerTimesList)" :key="i">
                              <td class="text-center ">{{ fertilizer.FertilizerTimes_times }}</td>
                              <td class="">{{ fertilizer.Fertilizer_name }}</td>
                              <td class="text-center ">{{ fertilizer.FertilizerTimes_amount }}</td>
                              <td class="text-center ">{{
                                   formatDate(fertilizer.FertilizerTimes_startDate) }}</td>
                              <td class="text-center ">{{
                                   formatDate(fertilizer.FertilizerTimes_endDate)
                              }}</td>
                              <td class="">{{ fertilizer.Employee_name }}</td>
                         </tr>
                    </tbody>
               </table>
          </div>

          <div class="row">
               <h2>Các lần bị bệnh dịch</h2>
               <table class="table">
                    <thead>
                         <tr>
                              <th class="text-center ">Lần</th>
                              <th>Tên bệnh dịch</th>
                              <th class="text-center ">Ngày bất đầu</th>
                              <th class="text-center ">Ngày kết thúc</th>
                              <th class="">Nhân viên</th>
                         </tr>
                    </thead>
                    <tbody>

                         <tr v-for="(epidemic, i ) in (epidemicTimesList)" :key="i">
                              <td class="text-center ">{{ epidemic.EpidemicTimes_times }}</td>
                              <td class="">{{ epidemic.Epidemic_name }}</td>
                              <td class="text-center ">{{
                                   formatDate(epidemic.EpidemicTimes_startDate)
                              }}</td>
                              <td class="text-center ">{{ formatDate(epidemic.EpidemicTimes_endDate)
                              }}
                              </td>
                              <td class="">{{ epidemic.Employee_name }}</td>
                         </tr>
                    </tbody>
               </table>
          </div>

          <div class="row">
               <h2>Hoạt động phun thuốc</h2>
               <table class="table">
                    <thead>
                         <tr>
                              <th class="text-center ">Mã</th>
                              <th>Tên thuốc</th>
                              <th class="text-center ">Liều lượng (lít/ha)</th>
                              <th class="text-center ">Ngày bất đầu</th>
                              <th class="text-center ">Ngày kết thúc</th>
                              <th class="">Nhân viên</th>
                         </tr>
                    </thead>
                    <tbody>
                         <tr v-for="(sprayingTimes, i ) in (sprayingTimesList)" :key="i">
                              <td class="text-center ">{{ sprayingTimes.SprayingTimes_times }}</td>
                              <td class="">{{ sprayingTimes.Pesticide_name }}</td>
                              <td class="text-center ">{{ sprayingTimes.SprayingTimes_amount }}</td>
                              <td class="text-center ">{{
                                   formatDate(sprayingTimes.SprayingTimes_startDate)
                              }}</td>
                              <td class="text-center ">{{
                                   formatDate(sprayingTimes.SprayingTimes_endDate)
                              }}
                              </td>
                              <td class="">{{ sprayingTimes.Employee_name }}</td>
                         </tr>
                    </tbody>
               </table>
          </div>

          <div class="row">
               <h2>Các hoạt động khác</h2>
               <table class="table">
                    <thead>
                         <tr>
                              <th class="text-center ">STT</th>
                              <th class="text-center ">Mã</th>
                              <th>Tên hoạt động</th>
                              <th>Lần</th>
                              <th class="">Ngày bắt đầu</th>
                              <th class="">Ngày kết thúc</th>
                              <th class="">Nhân viên</th>
                         </tr>
                    </thead>
                    <tbody>
                         <tr v-for="(activity, i ) in (activitiesDetailList)" :key="i">
                              <td class="text-center">{{ i }}</td>
                              <td class="text-center">{{ activity.OtherActivities_id }}</td>
                              <td>{{ activity.OtherActivities_name }}</td>
                              <td>{{ activity.ActivityDetails_times }}</td>
                              <td>{{ formatDate(activity.ActivityDetails_startDate) }}</td>
                              <td>{{ formatDate(activity.ActivityDetails_endDate) }}</td>
                              <td class="">{{ activity.Employee_name }}</td>
                         </tr>
                    </tbody>
               </table>
          </div>
     </div>
</template>

<script>
import FertilizerTimesService from '@/services/fertilizerTimes.service';
import RiceCropInformationService from '@/services/riceCropInformation.service';
import EpidemicTimesService from '@/services/epidemicTimes.service';
import SprayingTimesService from '@/services/sprayingTimes.service';
import ActivityDetailsService from '@/services/activityDetails.service';
import moment from 'moment';
export default {
     name: "riceCropDetail",

     props: ["riceCropChosen"],

     data() {
          return {
               riceCrop: {},
               fertilizerTimesList: [],
               epidemicTimesList: [],
               sprayingTimesList: [],
               activitiesDetailList: [],
          }
     },
     methods: {
          async retrieveFertilizerTimesList() {
               console.log(this.riceCrop.RiceCropInformation_id)
               const [err, respone] = await this.handle(
                    FertilizerTimesService.get(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần bón phân.") {
                         this.fertilizerTimesList = respone.data;
                    }
               }
               this.retrieveEpidemicTimesList();
          },

          async retrieveRiceCrop() {
               const [err, respone] = await this.handle(
                    RiceCropInformationService.get(this.riceCropChosen.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCrop = respone.data;
               }
               this.retrieveFertilizerTimesList();
          },

          async retrieveEpidemicTimesList() {
               const [err, respone] = await this.handle(
                    EpidemicTimesService.get(this.riceCropChosen.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    console.log(respone.data)
                    if (respone.data != "Không tìm thấy lần bị dịch bệnh.") {
                         this.epidemicTimesList = respone.data;
                    }
               }
               this.retrieveSprayingTimesList();
          },

          async retrieveSprayingTimesList() {
               const [err, respone] = await this.handle(
                    SprayingTimesService.get(this.riceCropChosen.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần phun thuốc mới.") {
                         this.sprayingTimesList = respone.data;
                    }

               }
               this.retrieveActivitiesDetailList();
          },

          async retrieveActivitiesDetailList() {
               const [err, respone] = await this.handle(
                    ActivityDetailsService.findByName(this.riceCropChosen.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.activitiesDetailList = respone.data;
               }
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY"));
          },

     },

     mounted() {
          this.retrieveRiceCrop()

     }

};

</script>

<style>
@import url(../../assets/mainStyle.css);
</style>