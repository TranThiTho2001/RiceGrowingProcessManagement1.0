<template>
     <div class="container-fluid riceCropDetailForPrediction" style="background-color:#EAEAEA;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>
          <div class="row riceCropDetailFrame" style="height: max-content;" v-if="!loading" :class="{ active: active }">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>
               <div class="right rightRiceCropDetail" data-bs-spy="scroll">
                    <div class="mb-5 pb-1 pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Dự Đoán Năng Suất</h3>
                         </div>
                         <div class="text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="container-fluid riceCropDetailComponent"
                         style="margin-top: 88px; margin-left:20px; width: 97%; margin-right:10px">
                         <div class="row">
                              <h4 class="prediction-title" style="padding-bottom: 2px; width: 100%;">Thông tin {{
                                   riceCrop.RiceCropInformation_name
                              }}</h4>
                              <button class="btn btnPredict" @click="getWeather(true), active = true"> Dự Đoán</button>
                              <div class="riceCropInfor-component ">
                                   <table class="tablericeCropInfor">
                                        <tbody>
                                             <tr>
                                                  <td data-label="Mã mùa vụ">{{
                                                       riceCrop.RiceCropInformation_id }}</td>
                                             </tr>
                                             <tr>
                                                  <td data-label="Tên mùa vụ">{{ riceCrop.RiceCropInformation_name }}</td>
                                             </tr>
                                             <tr>
                                                  <td data-label="Vụ mùa">Vụ mùa - {{ riceCrop.Crop_name }}</td>
                                             </tr>
                                             <tr>
                                                  <td data-label="Giống lúa">Sử dụng giống lúa {{ riceCrop.Seed_name }}
                                                  </td>
                                             </tr>
                                             <tr>
                                                  <td data-label="Mẫu ruộng" @click="goToMap">Vị trí mẫu ruộng: {{
                                                       riceCrop.ArableLand_latitude }}, {{ riceCrop.ArableLand_longitude }}
                                                  </td>
                                             </tr>
                                             <tr>
                                                  <td data-label="Ngày gieo xạ">Bắt đầu từ ngày {{
                                                       formatDate(riceCrop.RiceCropInformation_sowingDate) }}</td>
                                             </tr>
                                             <tr>
                                                  <td data-label="Ngày thu hoạch" style="border-bottom: 0px !important;"> Thu
                                                       hoạch ngày {{
                                                            formatDate(riceCrop.RiceCropInformation_harvestDate) }}</td>
                                             </tr>
                                        </tbody>
                                   </table>
                              </div>
                              <div class="calendarComponent">
                                   <time class="icon">
                                        <em>Ngày</em>
                                        <strong>Gieo trồng</strong>
                                        <span class="countingDays">{{
                                             get_day_of_time(riceCrop.RiceCropInformation_sowingDate) }}</span>
                                   </time>
                              </div>
                              <!-- <div class="resultRiceYield"> -->
                              <div class="result-prediction">
                                   <p>Dự đoán</p>
                                   <div class="yield">
                                        <h2 class="yield-value ">{{ getPrediction().yield }}</h2>
                                        <h5 style="color: #919302;">Kg/ha</h5>
                                   </div>
                              </div>
                              <div class="result-prediction">
                                   <p>Thực tế</p>
                                   <div class="yield">
                                        <h2 class="yield-value" v-if="riceCrop.RiceCropInformation_yield != null">{{
                                             riceCrop.RiceCropInformation_yield }}</h2>
                                        <h2 class="yield-value" v-else>00</h2>
                                        <h5 style="color: #919302;">Kg/ha</h5>
                                   </div>
                              </div>
                              <!-- </div> -->
                         </div>

                         <div class="row mt-3 tablePredictFrame">
                              <div class="row mt-1" style="width: 100%; height: 38px; margin-left: 0px;">
                                   <button class="btn btnDowload" @click="dowload()">
                                        <i class="fas fa-arrow-alt-circle-down"></i> Tải CSV
                                   </button>
                              </div>
                              <div class="row table-row mb-1">
                                   <h4 class="prediction-title2" style="">
                                        Thông tin thời tiết trong mùa vụ cho lần dự đoán ngày
                                        <span v-if="getPrediction().yield != '00'"> {{
                                             formatDate(predictionList[0].Prediction_date) }}</span>
                                   </h4>
                                   <button class="btn btnViewDetail" @click="openWeatherInfor = true"
                                        v-if="getPrediction().yield != '00'">Xem chi tiết</button>
                                   <table class="tableWeather tablePredict" v-if="weatherInfor.loadding">
                                        <thead>
                                             <tr>
                                                  <th class="centerclass">STT</th>
                                                  <th class="centerclass">Ngày</th>
                                                  <th class="centerclass">Nhiệt Độ (°C )</th>
                                                  <th class="centerclass">Độ ẩm (%)</th>
                                                  <th class="centerclass">Lượng mưa (mm/h)</th>
                                                  <th class="centerclass">Tốc độ gió (Km/h)</th>
                                                  <th class="centerclass">Bức xạ mặt trời (MJ/m²)</th>
                                             </tr>
                                        </thead>
                                        <tbody v-if="predictionList.length > 0 && getPrediction() != '00'">
                                             <tr v-for="i in 2" :key="i">
                                                  <td class="centerclass">{{ i }}</td>
                                                  <td class="centerclass">{{ formatDate(weatherInfor.dateList[i]) }}</td>
                                                  <td class="centerclass">{{ weatherInfor.temperatureList[i] }}
                                                  </td>
                                                  <td class="centerclass">{{ weatherInfor.humitidityList.final[i]
                                                  }}</td>
                                                  <td class="centerclass">{{ weatherInfor.precipitationList[i] }}
                                                  </td>
                                                  <td class="centerclass">{{ weatherInfor.windSpeed[i] }}</td>
                                                  <td class="centerclass">{{ weatherInfor.solarRadiation[i] }}</td>
                                             </tr>
                                             <tr>
                                                  <td class="centerclass">...</td>
                                                  <td class="centerclass">...</td>
                                                  <td class="centerclass">...
                                                  </td>
                                                  <td class="centerclass">...</td>
                                                  <td class="centerclass">...</td>
                                                  <td class="centerclass">...</td>
                                                  <td class="centerclass">...</td>
                                             </tr>
                                             <tr>
                                                  <td class="centerclass final-row">Dữ liệu dùng cho dự đoán</td>
                                                  <td class="centerclass final-row">{{ weatherInfor.dateList.length
                                                  }}</td>
                                                  <td class="centerclass final-row">{{ weatherInfor.Temperature }}
                                                  </td>
                                                  <td class="centerclass final-row">{{ weatherInfor.Humitidity }}
                                                  </td>
                                                  <td class="centerclass final-row">{{ weatherInfor.Precipitation
                                                  }}</td>
                                                  <td class="centerclass final-row">{{ weatherInfor.WinSpeed }}
                                                  </td>
                                                  <td class="centerclass final-row">{{ weatherInfor.SolarRadiation
                                                  }}</td>
                                             </tr>
                                        </tbody>
                                   </table>
                              </div>
                              <div class="row table-row">
                                   <h4 class="prediction-title2">Hoạt động bón phân</h4>
                                   <button class="btn btnViewDetail " @click="openFertilizer = true"
                                        v-if="getPrediction().yield != '00'">Xem chi tiết</button>
                                   <table class="tableWeather tablePredict">
                                        <thead>
                                             <tr>
                                                  <th class="text-center th_pre">Lần</th>
                                                  <th class="th_pre">Tên phân bón</th>
                                                  <th class="text-center th_pre">Số lượng bón (kg/ha)</th>
                                                  <th class="text-center th_pre">Tỉ lệ Đạm (kg/ha)</th>
                                                  <th class="text-center th_pre">Tỉ lệ Lân (kg/ha)</th>
                                                  <th class="text-center th_pre">Tỉ lệ Kali (kg/ha)</th>
                                                  <th class="text-center th_pre">Ngày bắt đầu</th>
                                                  <th class="text-center th_pre">Ngày kết thúc</th>
                                             </tr>
                                        </thead>
                                        <tbody v-if="fertilizerTimesList.length < 1">
                                             <tr>
                                                  <td colspan="8" class="centerclass">Chưa có lần bón phân nào được
                                                       thực hiện
                                                  </td>
                                             </tr>
                                        </tbody>
                                        <tbody v-if="fertilizerTimesList.length == 1">
                                             <tr >
                                                  <td class="text-center ">{{ fertilizerTimesList[0].FertilizerTimes_times }}
                                                  </td>
                                                  <td class="">{{ fertilizerTimesList[0].Fertilizer_name }}</td>
                                                  <td class="text-center ">{{ fertilizerTimesList[0].FertilizerTimes_amount
                                                  }}
                                                  </td>
                                                  <td class="text-center ">
                                                       {{ toFixedNumber(fertilizerTimesList[0].QuantityUsed.N) }}</td>
                                                  <td class="text-center ">{{
                                                       toFixedNumber(fertilizerTimesList[0].QuantityUsed.P) }}</td>
                                                  <td class="text-center ">{{
                                                       toFixedNumber(fertilizerTimesList[0].QuantityUsed.K) }}</td>
                                                  <td class="text-center ">{{
                                                       formatDate(fertilizerTimesList[0].FertilizerTimes_startDate) }}</td>
                                                  <td class="text-center ">{{
                                                       formatDate(fertilizerTimesList[0].FertilizerTimes_endDate)
                                                  }}</td>
                                             </tr>

                                             <tr>
                                                  <td class=" final-row" colspan="2">Tổng</td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.Total)
                                                  }}</td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.N) }}
                                                  </td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.P) }}
                                                  </td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.K) }}
                                                  </td>
                                                  <td class="text-center final-row"></td>
                                                  <td class="text-center final-row"></td>
                                             </tr>
                                        </tbody>
                                        <tbody v-if="fertilizerTimesList.length == 2 || fertilizerTimesList.length ==3">

                                             <tr v-for="i in fertilizerTimesList.length" :key="i">
                                                  <td class="text-center ">{{ fertilizerTimesList[i].FertilizerTimes_times }}
                                                  </td>
                                                  <td class="">{{ fertilizerTimesList[i].Fertilizer_name }}</td>
                                                  <td class="text-center ">{{ fertilizerTimesList[i].FertilizerTimes_amount
                                                  }}
                                                  </td>
                                                  <td class="text-center ">
                                                       {{ toFixedNumber(fertilizerTimesList[i].QuantityUsed.N) }}</td>
                                                  <td class="text-center ">{{
                                                       toFixedNumber(fertilizerTimesList[i].QuantityUsed.P) }}</td>
                                                  <td class="text-center ">{{
                                                       toFixedNumber(fertilizerTimesList[i].QuantityUsed.K) }}</td>
                                                  <td class="text-center ">{{
                                                       formatDate(fertilizerTimesList[i].FertilizerTimes_startDate) }}</td>
                                                  <td class="text-center ">{{
                                                       formatDate(fertilizerTimesList[i].FertilizerTimes_endDate)
                                                  }}</td>
                                             </tr>

                                             <tr>
                                                  <td class=" final-row" colspan="2">Tổng</td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.Total)
                                                  }}</td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.N) }}
                                                  </td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.P) }}
                                                  </td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.K) }}
                                                  </td>
                                                  <td class="text-center final-row"></td>
                                                  <td class="text-center final-row"></td>
                                             </tr>
                                        </tbody>
                                        <tbody v-if="fertilizerTimesList.length > 3">
                                             <tr v-for="i in 2" :key="i">
                                                  <td class="text-center ">{{ fertilizerTimesList[i].FertilizerTimes_times }}
                                                  </td>
                                                  <td class="">{{ fertilizerTimesList[i].Fertilizer_name }}</td>
                                                  <td class="text-center ">{{ fertilizerTimesList[i].FertilizerTimes_amount
                                                  }}
                                                  </td>
                                                  <td class="text-center ">
                                                       {{ toFixedNumber(fertilizerTimesList[i].QuantityUsed.N) }}</td>
                                                  <td class="text-center ">{{
                                                       toFixedNumber(fertilizerTimesList[i].QuantityUsed.P) }}</td>
                                                  <td class="text-center ">{{
                                                       toFixedNumber(fertilizerTimesList[i].QuantityUsed.K) }}</td>
                                                  <td class="text-center ">{{
                                                       formatDate(fertilizerTimesList[i].FertilizerTimes_startDate) }}</td>
                                                  <td class="text-center ">{{
                                                       formatDate(fertilizerTimesList[i].FertilizerTimes_endDate)
                                                  }}</td>
                                             </tr>

                                             <tr>
                                                  <td class="text-center ">...</td>
                                                  <td class="">...</td>
                                                  <td class="text-center ">...</td>
                                                  <td class="text-center ">...</td>
                                                  <td class="text-center ">...</td>
                                                  <td class="text-center ">...</td>
                                                  <td class="text-center ">...</td>
                                                  <td class="text-center ">...</td>
                                             </tr>
                                             <tr>
                                                  <td class=" final-row" colspan="2">Tổng</td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.Total)
                                                  }}</td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.N) }}
                                                  </td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.P) }}
                                                  </td>
                                                  <td class="text-center final-row">{{
                                                       toFixedNumber(total_amount_of_fertilizer_used.K) }}
                                                  </td>
                                                  <td class="text-center final-row"></td>
                                                  <td class="text-center final-row"></td>
                                             </tr>
                                        </tbody>
                                   </table>
                              </div>
                         </div>

                         <div :class="{ overlay2: openWeatherInfor }" class="overlay">
                              <div class="popup">
                                   <a class="fas fa-times-circle" href="#" @click="openWeatherInfor = false"
                                        style="font-size: 25px; text-decoration: none; color:#B3B4BA; float: right;"></a>
                                   <h2>Thông tin thời tiết trong mùa vụ cho lần dự đoán ngày
                                        <span v-if="getPrediction().yield != '00'"> {{
                                             formatDate(predictionList[0].Prediction_date) }}</span>
                                   </h2>

                                   <div class="content">
                                        <table class="tableWeather-popup dowload-table tableWeather tablePredict"
                                             id="weatherInfor" style="width: 90%;" v-if="weatherInfor.loadding">
                                             <thead>
                                                  <tr>
                                                       <th class="centerclass">STT</th>
                                                       <th class="centerclass">Ngày</th>
                                                       <th class="centerclass">Nhiệt Độ (°C )</th>
                                                       <th class="centerclass">Độ ẩm (%)</th>
                                                       <th class="centerclass">Lượng mưa (mm/h)</th>
                                                       <th class="centerclass">Tốc độ gió (Km/h)</th>
                                                       <th class="centerclass">Bức xạ mặt trời (MJ/m²)</th>
                                                  </tr>
                                             </thead>
                                             <tbody v-if="predictionList.length > 0 && getPrediction() != '00'">
                                                  <tr v-for="(data, i) in weatherInfor.dateList" :key="i">
                                                       <td class="centerclass">{{ i }}</td>
                                                       <td class="centerclass">{{ formatDate(data) }}</td>
                                                       <td class="centerclass">{{ weatherInfor.temperatureList[i] }}
                                                       </td>
                                                       <td class="centerclass">{{ weatherInfor.humitidityList.final[i]
                                                       }}</td>
                                                       <td class="centerclass">{{ weatherInfor.precipitationList[i] }}
                                                       </td>
                                                       <td class="centerclass">{{ weatherInfor.windSpeed[i] }}</td>
                                                       <td class="centerclass">{{ weatherInfor.solarRadiation[i] }}</td>
                                                  </tr>
                                                  <tr>
                                                       <td class="centerclass final-row">Dữ liệu dùng cho dự đoán</td>
                                                       <td class="centerclass final-row">{{ weatherInfor.dateList.length
                                                       }}</td>
                                                       <td class="centerclass final-row">{{ weatherInfor.Temperature }}
                                                       </td>
                                                       <td class="centerclass final-row">{{ weatherInfor.Humitidity }}
                                                       </td>
                                                       <td class="centerclass final-row">{{ weatherInfor.Precipitation
                                                       }}</td>
                                                       <td class="centerclass final-row">{{ weatherInfor.WinSpeed }}
                                                       </td>
                                                       <td class="centerclass final-row">{{ weatherInfor.SolarRadiation
                                                       }}</td>
                                                  </tr>
                                             </tbody>
                                        </table>
                                   </div>
                              </div>
                         </div>



                         <div :class="{ overlay2: openFertilizer }" class="overlay">
                              <div class="popup">
                                   <a class="fas fa-times-circle" href="#" @click="openFertilizer = false"
                                        style="font-size: 25px; text-decoration: none; color:#B3B4BA; float: right;"></a>
                                   <h2 class="prediction-title2">Hoạt động bón phân </h2>

                                   <div class="content">
                                        <table class="tablePredict  dowload-table" id="weatherInfor">
                                             <thead>
                                                  <tr>
                                                       <th class="text-center th_pre">Lần</th>
                                                       <th class="th_pre">Tên phân bón</th>
                                                       <th class="text-center th_pre">Số lượng bón (kg/ha)</th>
                                                       <th class="text-center th_pre">Tỉ lệ Đạm (kg/ha)</th>
                                                       <th class="text-center th_pre">Tỉ lệ Lân (kg/ha)</th>
                                                       <th class="text-center th_pre">Tỉ lệ Kali (kg/ha)</th>
                                                       <th class="text-center th_pre">Ngày bắt đầu</th>
                                                       <th class="text-center th_pre">Ngày kết thúc</th>
                                                  </tr>
                                             </thead>
                                             <tbody>
                                                  <tr v-if="fertilizerTimesList.length < 1">
                                                       <td colspan="6" class="centerclass">Chưa có lần bón phân nào được
                                                            thực hiện
                                                       </td>
                                                  </tr>
                                                  <tr v-for="(fertilizer, i) in (fertilizerTimesList)" :key="i">
                                                       <td class="text-center ">{{ fertilizer.FertilizerTimes_times }}
                                                       </td>
                                                       <td class="">{{ fertilizer.Fertilizer_name }}</td>
                                                       <td class="text-center ">{{ fertilizer.FertilizerTimes_amount }}
                                                       </td>
                                                       <td class="text-center ">
                                                            {{ toFixedNumber(fertilizer.QuantityUsed.N) }}</td>
                                                       <td class="text-center ">{{
                                                            toFixedNumber(fertilizer.QuantityUsed.P) }}</td>
                                                       <td class="text-center ">{{
                                                            toFixedNumber(fertilizer.QuantityUsed.K) }}</td>
                                                       <td class="text-center ">{{
                                                            formatDate(fertilizer.FertilizerTimes_startDate) }}</td>
                                                       <td class="text-center ">{{
                                                            formatDate(fertilizer.FertilizerTimes_endDate)
                                                       }}</td>
                                                  </tr>
                                                  <tr>
                                                       <td class=" final-row" colspan="2">Tổng</td>
                                                       <td class="text-center final-row">{{
                                                            toFixedNumber(total_amount_of_fertilizer_used.Total)
                                                       }}</td>
                                                       <td class="text-center final-row">{{
                                                            toFixedNumber(total_amount_of_fertilizer_used.N) }}
                                                       </td>
                                                       <td class="text-center final-row">{{
                                                            toFixedNumber(total_amount_of_fertilizer_used.P) }}
                                                       </td>
                                                       <td class="text-center final-row">{{
                                                            toFixedNumber(total_amount_of_fertilizer_used.K) }}
                                                       </td>
                                                       <td class="text-center final-row"></td>
                                                       <td class="text-center final-row"></td>
                                                  </tr>
                                             </tbody>
                                        </table>
                                   </div>
                              </div>
                         </div>




                         <!-- 
                         <div class="row mt-4">
                              <h4 class="prediction-title">Các lần bị bệnh dịch</h4>
                              <div class="tablePredictFrame">
                                   <table class="tablePredict">
                                        <thead>
                                             <tr>
                                                  <th class="text-center th_pre">Lần</th>
                                                  <th class="th_pre">Tên bệnh dịch</th>
                                                  <th class="text-center th_pre">Ngày bất đầu</th>
                                                  <th class="text-center th_pre">Ngày kết thúc</th>
                                                  <th class="th_pre">Nhân viên</th>
                                             </tr>
                                        </thead>
                                        <tbody>
                                             <tr v-if="epidemicTimesList.length < 1">
                                                  <td colspan="5" class="centerclass">Mùa vụ không trải qua lần bị bệnh dịch
                                                       nào.
                                                  </td>
                                             </tr>
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
                         </div> -->

                         <!-- <div class="row mt-4">
                              <h4 class="prediction-title">Hoạt động phun thuốc</h4>
                              <div class="tablePredictFrame">
                                   <table class="tablePredict">
                                        <thead>
                                             <tr>
                                                  <th class="text-center th_pre">Mã</th>
                                                  <th class="th_pre">Tên thuốc</th>
                                                  <th class="text-center th_pre">Liều lượng (lít/ha)</th>
                                                  <th class="text-center th_pre">Ngày bất đầu</th>
                                                  <th class="text-center th_pre">Ngày kết thúc</th>
                                                  <th class="th_pre">Nhân viên</th>
                                             </tr>
                                        </thead>
                                        <tbody>
                                             <tr v-if="sprayingTimesList.length < 1">
                                                  <td colspan="6" class="centerclass">Chưa có làn phun thuốc nào được thực
                                                       hiện
                                                       trên ruộng lúa</td>
                                             </tr>
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
                         </div> -->

                         <!-- <div class="row mt-4">
                              <h4 class="prediction-title">Các hoạt động khác</h4>
                              <div class="tablePredictFrame">
                                   <table class="tablePredict">
                                        <thead>
                                             <tr>
                                                  <th class="centerclass th_pre">STT</th>
                                                  <th class="centerclass th_pre">Mã</th>
                                                  <th class="th_pre">Tên hoạt động</th>
                                                  <th class="th_pre">Lần</th>
                                                  <th class="th_pre">Ngày bắt đầu</th>
                                                  <th class="th_pre">Ngày kết thúc</th>
                                                  <th class="th_pre">Nhân viên</th>
                                             </tr>
                                        </thead>
                                        <tbody>
                                             <tr v-if="activitiesDetailList.length < 1">
                                                  <td colspan="7" class="centerclass">Chưa có hoạt động nào được thực hiện
                                                       cho mùa
                                                       vụ </td>
                                             </tr>
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
                         </div> -->
                    </div>
               </div>
          </div>
          <div class="waitingDialog" v-if="predicting">
               <div>
                    <p class="labelConfirm mt-4 pt-4">Đang xử lý....</p>
               </div>
               <span v-show="predicting" class="spinner-border spinner-border-sm"></span>
          </div>
          <div class="resultDialog" v-if="result">
               <p style="color:#515151; text-align:center; margin-top: 30px; font-size: 20px;" class="labelConfirm"> Năng
                    suất dự đoán cho mùa vụ {{
                         this.riceCrop.RiceCropInformation_name }}<br>
                    <span class="result">{{ this.riceCrop.Prediction_yield }}</span> kg/ha
               </p>
               <button class="btnOK btn btn-sm btn-outline-secondary mb-3"
                    @click="result = !result, getPredictionList(), active = false">OK</button>
          </div>
     </div>
</template>

<script>
import { mapGetters, mapMutations } from "vuex";
import FertilizerTimesService from '@/services/fertilizerTimes.service';
import RiceCropInformationService from '@/services/riceCropInformation.service';
import EpidemicTimesService from '@/services/epidemicTimes.service';
import SprayingTimesService from '@/services/sprayingTimes.service';
import ActivityDetailsService from '@/services/activityDetails.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import PredictionService from "@/services/prediction.service";
import ContainService from "@/services/contain.service";

import moment from 'moment';
export default {
     name: "riceCropDetail",
     components: {
          Catalog,
          TopHeader,
          Preloader,
     },

     data() {
          return {
               openWeatherInfor: false,
               openFertilizer: false,
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               active: false,

               loading: true,
               riceCrop: {},
               fertilizerTimesList: [],
               epidemicTimesList: [],
               sprayingTimesList: [],
               activitiesDetailList: [],
               predictionList: [],
               weatherInfor: [],
               predicting: false,
               result: false,
               algorithm: "",
               total_amount_of_fertilizer_used: {
                    N: 0,
                    P: 0,
                    K: 0,
                    Total: 0,
               },
          }
     },
     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },
     created() {
          this.riceCrop.RiceCropInformation_id = this.$route.params.id;
          this.algorithm = this.$route.params.Algorithm;
          this.weatherInfor.loadding = false;
          this.initEmployeeState();
          this.retrieveRiceCrop();
          this.loadData();
     },
     methods: {
          ...mapMutations([
               "initEmployeeState"
          ]),

          async retrieveFertilizerTimesList() {
               const [err, respone] = await this.handle(
                    FertilizerTimesService.get(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần bón phân.") {
                         this.fertilizerTimesList = [];
                         this.total_amount_of_fertilizer_used = {
                              K: 0,
                              N: 0,
                              P: 0,
                              Total: 0,
                         }
                         var i = 0;
                         console.log(respone.data)
                         respone.data.forEach(fertizertimes => {


                              if (fertizertimes.FertilizerTimes_startDate < this.predictionList[0].Prediction_date) {
                                   this.fertilizerTimesList.push(fertizertimes);
                                   this.getContain(fertizertimes.Fertilizer_id, i);
                                   this.total_amount_of_fertilizer_used.Total += fertizertimes.FertilizerTimes_amount;
                                   i++;
                              }
                              fertizertimes.FertilizerTimes_startDate = new Date(fertizertimes.FertilizerTimes_startDate)

                         });
                    }
               }
               console.log(this.fertilizerTimesList)
               this.retrieveEpidemicTimesList();
          },

          async getContain(fertilizer_id, position) {
               const [err, respone] = await this.handle(
                    ContainService.getByFertilizerId(fertilizer_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.fertilizerTimesList[position].Contains = [];
                    if (respone.data != "Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!") {
                         this.fertilizerTimesList[position].Contains = respone.data;
                         this.fertilizerTimesList[position].QuantityUsed = {};
                         this.fertilizerTimesList[position].Contains.forEach(element => {
                              if (element.Nutrient_id == "K") {
                                   this.fertilizerTimesList[position].QuantityUsed.K = (this.fertilizerTimesList[position].FertilizerTimes_amount * (element.Contain_percent / 100)).toFixed(2);
                                   this.total_amount_of_fertilizer_used.K += parseFloat(this.fertilizerTimesList[position].QuantityUsed.K);
                              }
                              else if (element.Nutrient_id == "N") {
                                   this.fertilizerTimesList[position].QuantityUsed.N = (this.fertilizerTimesList[position].FertilizerTimes_amount * (element.Contain_percent / 100)).toFixed(2);
                                   this.total_amount_of_fertilizer_used.N += parseFloat(this.fertilizerTimesList[position].QuantityUsed.N);
                              }
                              else if (element.Nutrient_id == "P") {
                                   this.fertilizerTimesList[position].QuantityUsed.P = (this.fertilizerTimesList[position].FertilizerTimes_amount * (element.Contain_percent / 100)).toFixed(2);
                                   this.total_amount_of_fertilizer_used.P += parseFloat(this.fertilizerTimesList[position].QuantityUsed.P);
                              }
                         });
                         // this.total_amount_of_fertilizer_used.K = parseFloat(this.total_amount_of_fertilizer_used.K).toFixed(2);
                         // this.total_amount_of_fertilizer_used.N = parseFloat(this.total_amount_of_fertilizer_used.N).toFixed(2);
                         // this.total_amount_of_fertilizer_used.P = parseFloat(this.total_amount_of_fertilizer_used.P ).toFixed(2);
                    }
               }
          },

          toFixedNumber(number) {
               return parseFloat(number).toFixed(2);
          },

          async retrieveRiceCrop() {
               this.loading = true;
               const [err, respone] = await this.handle(
                    RiceCropInformationService.get(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCrop = respone.data;
               }
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
               this.getPredictionList();
          },

          async retrieveEpidemicTimesList() {
               const [err, respone] = await this.handle(
                    EpidemicTimesService.get(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần bị dịch bệnh.") {
                         this.epidemicTimesList = respone.data;
                    }
               }
               this.retrieveSprayingTimesList();
          },

          async retrieveSprayingTimesList() {
               const [err, respone] = await this.handle(
                    SprayingTimesService.get(this.riceCrop.RiceCropInformation_id)
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
                    ActivityDetailsService.findByName(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.activitiesDetailList = respone.data;
               }
          },

          async getPredictionList() {
               const [err, respone] = await this.handle(
                    PredictionService.findByRiceCropInformation(this.riceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.predictionList = respone.data;
                    this.retrieveFertilizerTimesList();
                    this.bubbleSort();
                    this.getWeather(false);
               }
          },

          async predictRiceYield() {
               this.predicting = true;
               this.result = false;
               if (this.weatherInfor.loadding) {
                    var infor = {};
                    infor.precipitation = this.weatherInfor.Precipitation;
                    infor.temperature = this.weatherInfor.Temperature;
                    infor.humitidity = this.weatherInfor.Humitidity;
                    infor.solarRadiation = this.weatherInfor.SolarRadiation;
                    infor.windSpeed = this.weatherInfor.WinSpeed;
                    infor.N = this.total_amount_of_fertilizer_used.N;
                    infor.K = this.total_amount_of_fertilizer_used.K;
                    infor.P = this.total_amount_of_fertilizer_used.P;
                    if (this.algorithm == "LinearRegression") {
                         infor.Algorithm_id = '1';
                    }
                    else {
                         infor.Algorithm_id = '2';
                    }
                    if (this.riceCrop.Crop_id == 'C00001') {
                         infor.crop = '1';
                    }
                    else if (this.riceCrop.Crop_id == 'C00002') {
                         infor.crop = '2';
                    }
                    else {
                         infor.crop = '3';
                    }
                    infor.area = this.riceCrop.Province_id;
                    const [err, respone] = await this.handle(
                         PredictionService.create(this.riceCrop.RiceCropInformation_id, infor)
                    );
                    if (err) {
                         console.log(err)
                    }
                    else {
                         this.riceCrop.Prediction_yield = respone.data.Prediction_yield;
                         this.riceCrop.Prediction_yield = Number(this.riceCrop.Prediction_yield).toFixed(2);
                         this.predicting = false;
                         this.result = true;

                         this.getPredictionList();
                         this.getWeather(false);
                    }
               }
          },

          async getWeather(ispredict) {
               this.weatherInfor.loadding = false;
               var lat = this.riceCrop.ArableLand_latitude;
               var lon = this.riceCrop.ArableLand_longitude;
               this.weatherInfor.Precipitation = 0;
               this.weatherInfor.totalTemperature = 0;
               this.weatherInfor.totalHumitidity = 0;
               this.weatherInfor.totalWindSpeed = 0;
               this.weatherInfor.totalSolarRadiation = 0;
               var end_date = ''
               if (ispredict) {
                    end_date = moment(new Date((new Date()).valueOf() - 1000 * 60 * 60 * 24)).format("YYYY-MM-DD");
               }
               else if (!ispredict && this.predictionList.length > 0) {
                    console.log("g")
                    end_date = moment(new Date((new Date(this.predictionList[0].Prediction_date))).valueOf() - 1000 * 60 * 60 * 24).format("YYYY-MM-DD");
               }
               if (ispredict || (!ispredict && this.predictionList.length > 0)) {
                    const start_date = moment(this.riceCrop.RiceCropInformation_sowingDate).format("YYYY-MM-DD");
                    let urlAPI1 = `https://archive-api.open-meteo.com/v1/archive?latitude=${lat}&longitude=${lon}&start_date=${start_date}&end_date=${end_date}&timezone=auto&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
                    let data = await fetch(urlAPI1).then(res => res.json())

                    this.weatherInfor.precipitationList = data.daily.precipitation_sum;
                    this.weatherInfor.temperatureList = data.daily.temperature_2m_mean;
                    this.weatherInfor.humitidityList = data.hourly;
                    this.weatherInfor.solarRadiation = data.daily.shortwave_radiation_sum;
                    this.weatherInfor.windSpeed = data.daily.windspeed_10m_max;
                    this.weatherInfor.dateList = data.daily.time;

                    var valueNull = [];
                    for (let index = this.weatherInfor.precipitationList.length - 1; index > 0; index--) {
                         if (this.weatherInfor.precipitationList[index] == null) {
                              const datenull = {};
                              datenull.index = index;
                              datenull.date = this.weatherInfor.dateList[index];
                              valueNull.push(datenull);
                         }
                         else {
                              break;
                         }
                    }
                    if (valueNull.length > 0) {
                         for (let index = this.weatherInfor.humitidityList.relativehumidity_2m.length - 1; index > 0; index--) {
                              var date = moment(new Date(this.weatherInfor.humitidityList.time[index])).format("YYYY-MM-DD")
                              if (date >= valueNull[valueNull.length - 1].date) {
                                   this.weatherInfor.humitidityList.relativehumidity_2m.pop();
                                   this.weatherInfor.humitidityList.time.pop();
                              }
                              else {
                                   break;
                              }
                         }
                         let urlAPI2 = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&start_date=${valueNull[valueNull.length - 1].date}&end_date=${valueNull[0].date}&timezone=GMT&hourly=relativehumidity_2m&daily=temperature_2m_mean&daily=precipitation_sum&daily=windspeed_10m_max&daily=shortwave_radiation_sum`;
                         let data2 = await fetch(urlAPI2).then(res => res.json())
                         var i = data2.daily.precipitation_sum.length - 1;
                         valueNull.forEach(valuenull => {
                              this.weatherInfor.precipitationList[valuenull.index] = data2.daily.precipitation_sum[i];
                              this.weatherInfor.temperatureList[valuenull.index] = data2.daily.temperature_2m_mean[i];
                              this.weatherInfor.windSpeed[valuenull.index] = data2.daily.windspeed_10m_max[i];
                              this.weatherInfor.solarRadiation[valuenull.index] = data2.daily.shortwave_radiation_sum[i];
                              i--;
                         });

                         this.weatherInfor.humitidityList.time = this.weatherInfor.humitidityList.time.concat(data2.hourly.time);
                         this.weatherInfor.humitidityList.relativehumidity_2m = this.weatherInfor.humitidityList.relativehumidity_2m.concat(data2.hourly.relativehumidity_2m);

                    }


                    this.weatherInfor.humitidityList.final = [];
                    for (let index = 0; index < this.weatherInfor.dateList.length; index++) {
                         let total = 0;
                         for (let i = index * 24; i < (index + 1) * 24; i++) {
                              total = total + this.weatherInfor.humitidityList.relativehumidity_2m[i];
                         }
                         this.weatherInfor.humitidityList.final.push((total / 24).toFixed(2));
                    }

                    i = 0;
                    this.weatherInfor.precipitationList.forEach(pre => {
                         this.weatherInfor.Precipitation += (Number(pre));
                         this.weatherInfor.totalTemperature += Number(this.weatherInfor.temperatureList[i]);
                         this.weatherInfor.totalWindSpeed += Number(this.weatherInfor.windSpeed[i]);
                         this.weatherInfor.totalSolarRadiation += Number(this.weatherInfor.solarRadiation[i]);
                         this.weatherInfor.totalHumitidity += Number(this.weatherInfor.humitidityList.final[i]);
                         i++;
                    });

                    this.weatherInfor.Temperature = (this.weatherInfor.totalTemperature / this.weatherInfor.temperatureList.length).toFixed(2);
                    this.weatherInfor.Humitidity = (this.weatherInfor.totalHumitidity / this.weatherInfor.dateList.length).toFixed(2);
                    this.weatherInfor.WinSpeed = (this.weatherInfor.totalWindSpeed / this.weatherInfor.windSpeed.length).toFixed(2);
                    this.weatherInfor.SolarRadiation = (this.weatherInfor.totalSolarRadiation / this.weatherInfor.solarRadiation.length).toFixed(2);
                    this.weatherInfor.Precipitation = Number(this.weatherInfor.Precipitation).toFixed(2);
               }
               this.weatherInfor.loadding = true;
               if (ispredict) {
                    this.predictRiceYield();
               }

          },

          async loadData() {
               this.loading = true;
               if (this.loading) {
                    setTimeout(() => {
                         this.loading = false;
                    }, 1000);
               }
          },

          getPrediction() {
               var prediction = {
                    yield: "00",
                    date: "",
               };
               if (this.algorithm == "LinearRegression") {
                    this.riceCrop.Algorithm_id = 1;
               }
               else {
                    this.riceCrop.Algorithm_id = 2;
               }

               if (this.predictionList.length > 0) {
                    for (let index = 0; index < this.predictionList.length; index++) {
                         const element = this.predictionList[index];
                         if (element.Algorithm_id == this.riceCrop.Algorithm_id) {
                              prediction.yield = element.Prediction_yield;
                              prediction.date = element.Prediction_date;
                              break;
                         }
                    }
               }
               return prediction;
          },

          async download_csv(csv, filename) {
               var csvFile;
               var downloadLink;

               // CSV FILE
               csvFile = new Blob(["\uFEFF" + csv], { type: "text/csv" });

               // Download link
               downloadLink = document.createElement("a");

               // File name
               downloadLink.download = filename;

               // We have to create a link to the file
               downloadLink.href = window.URL.createObjectURL(csvFile);

               // Make sure that the link is not displayed
               downloadLink.style.display = "none";

               // Add the link to your DOM
               document.body.appendChild(downloadLink);

               // Lanzamos
               downloadLink.click();
          },

          async export_table_to_csv(html, filename) {
               var csv = [];
               var rows = document.querySelectorAll(".dowload-table tr");

               for (var i = 0; i < rows.length; i++) {
                    var row = [], cols = rows[i].querySelectorAll("td, th");

                    for (var j = 0; j < cols.length; j++)
                         row.push(String(cols[j].innerHTML).replaceAll(',', ''));

                    csv.push(row.join(","));
               }
               // Download CSV
               this.download_csv(csv.join("\n"), filename);
          },

          async dowload() {
               var html = document.getElementById("weatherInfor");
               var date = '';
               if (this.predictionList[0].Prediction_date != '00') {
                    date = moment(this.predictionList[0].Prediction_date).format("DD-MM-YYYY");
               }

               this.export_table_to_csv(html, "Dữ liệu dự đoán năng suất lúa " + this.riceCrop.RiceCropInformation_name + " " + date + ".csv");
          },


          bubbleSort() {
               for (let i = 0; i < this.predictionList.length - 1; i++) {
                    for (let j = this.predictionList.length - 1; j > i; j--) {
                         if (this.predictionList[j].Prediction_date > this.predictionList[j - 1].Prediction_date) {
                              let t = this.predictionList[j];
                              this.predictionList[j] = this.predictionList[j - 1];
                              this.predictionList[j - 1] = t;
                         }
                    }
               }
          },


          //      import * as FileSaver from 'file-saver';
          // import * as XLSX from 'xlsx';

          // function downloadExcel() {

          //     /* create a new blank workbook */
          //     var wb = XLSX.utils.book_new();

          //     /* create a worksheet for books */
          //     var wsBooks = XLSX.utils.json_to_sheet(books);

          //     /* Add the worksheet to the workbook */
          //     XLSX.utils.book_append_sheet(wb, wsBooks, "Books");

          //     /* create a worksheet for person details */
          //     var wsPersonDetails = XLSX.utils.json_to_sheet(personDetails);

          //     /* Add the worksheet to the workbook */
          //     XLSX.utils.book_append_sheet(wb, wsPersonDetails, "PersonDetails");


          //     const fileType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=UTF-8';
          //     const excelBuffer = XLSX.write(wb, { bookType: 'xlsx', type: 'array' });
          //     const data1 = new Blob([excelBuffer], { type: fileType });
          //     FileSaver.saveAs(data1, "BookDetail Summary.xlsx");    
          // }

          // function convert(){
          //    let tbl1 = document.getElementsByTagName("table")[0]
          //    let tbl2 = document.getElementsByTagName("table")[1]

          //    let worksheet_tmp1 = XLSX.utils.table_to_sheet(tbl1);
          //    let worksheet_tmp2 = XLSX.utils.table_to_sheet(tbl2);

          //    let a = XLSX.utils.sheet_to_json(worksheet_tmp1, { header: 1 })
          //    let b = XLSX.utils.sheet_to_json(worksheet_tmp2, { header: 1 })

          //    a = a.concat(['']).concat(b)

          //    let worksheet = XLSX.utils.json_to_sheet(a, { skipHeader: true })

          //    const new_workbook = XLSX.utils.book_new()
          //    XLSX.utils.book_append_sheet(new_workbook, worksheet, "worksheet")
          //    XLSX.writeFile(new_workbook, 'tmp_file.xls')
          // }

          get_day_of_time(d1) {
               let ms1 = (new Date(d1)).getTime();
               var d2 = new Date();
               let ms2 = d2.getTime();
               return Math.ceil((ms2 - ms1) / (24 * 60 * 60 * 1000));
          },

          goToMap() {
               window.open(`https://www.google.com/maps/@${this.riceCrop.ArableLand_latitude},${this.riceCrop.ArableLand_longitude},15z?hl=vi-VN`);
          },

          formatDate(data) {
               if (data == null || data == "Invalid da") return "";
               return (moment(String(data)).format("DD-MM-YYYY"));
          },

     },

     mounted() {

     }

};

</script>

<style>
@import url(../../assets/mainStyle.css);
@import url(../../assets/predictionStyle.css);

.navbar-sub {
     position: fixed !important;
     z-index: 4;
}
</style>