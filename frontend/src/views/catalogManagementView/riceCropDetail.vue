<template>
     <div class="container-fluid riceCropDetail">
          <div class="row riceCropDetailFrame">
               <div class="col-md-2">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>
               <div class="col-md-10 rightRiceCropDetail" :class="{ active: stylebac.active, noneactive: stylebac.none }">
                    <div class="row ml-2 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="col-md-10">
                              <h3 class="name">Theo dõi mùa vụ</h3>
                         </div>


                         <div class="col-md-2 text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>
                    <div class="row updateRiceCrop mr-2 ml-2 mb-1" style="width: 100%;">
                         <UpdateRiceCropForm :seedList="seedList" :newRiceCrop="newRiceCrop" :arableLandList="arableLandList"
                              @updateRiceCrop-submit="updateRiceCrop" :message1="message1" :message2="message2" />
                    </div>
                    <div class="row bottomrow ml-2 mr-2 pt-1">
                         <div class="col-sm-12">
                              <div class="row functionName mt-1 ml-2">
                                   <div class=" btn btn-midle text-center btnFertilizerTimes btnName"
                                        v-if="!isOpenTableFertilizerTimes" @click="setTable('btnFertilizerTimes')">Bón phân
                                   </div>
                                   <div class=" btn btn-midle text-center btnFertilizerTimes btnNameActive"
                                        v-if="isOpenTableFertilizerTimes">Bón phân</div>
                                   <div class=" btn btn-midle text-center btnSprayingTimes btnNameActive"
                                        v-if="isOpenTableSprayingTimes">Phun thuốc</div>
                                   <div class=" btn btn-midle text-center btnSprayingTimes btnName"
                                        v-if="!isOpenTableSprayingTimes" @click="setTable('btnSprayingTimes')">Phun thuốc
                                   </div>
                                   <div class=" btn btn-midle text-center btnActivities btnNameActive"
                                        v-if="isOpenTableOtherActivitiesTimes">Hoạt động khác</div>
                                   <div class=" btn btn-midle text-center btnActivities btnName"
                                        @click="setTable('btnActivities')" v-if="!isOpenTableOtherActivitiesTimes">Hoạt động
                                        khác</div>
                                   <div class=" btn btn-midle text-center btnEpidemic btnNameActive"
                                        v-if="isOpenTableEpidemicTimes">Tình bệnh dịch</div>
                                   <div class=" btn btn-midle text-center btnEpidemic btnName"
                                        v-if="!isOpenTableEpidemicTimes" @click="setTable('btnEpidemic')">Tình bệnh dịch
                                   </div>
                                   <div class="btn btn-midle text-center btnImage btnNameActive" v-if="isOpenImage">
                                        Hình ảnh
                                   </div>
                                   <div class="btn btn-midle text-center btnImage btnName" v-if="!isOpenImage"
                                        @click="setTable('btnImage')">
                                        Hình ảnh
                                   </div>
                                   <div class=" btn btn-midle text-center btnAttendee btnNameActive"
                                        v-if="isOpenTableMonitor && currentUser.Role_id == '02'">Người theo dõi</div>
                                   <div class=" btn btn-midle text-center btnAttendee btnName"
                                        v-if="!isOpenTableMonitor && currentUser.Role_id == '02'"
                                        @click="setTable('btnAttendee')">Người theo dõi</div>

                              </div>
                              <div class="row activitiesList ml-2 mr-2 pb-5" v-if="isOpenImage">
                                   <div class="col-sm-12">
                                        <div class="row">
                                             <button class="btnAddimage"
                                                  @click="isOpenCreateImage = !isOpenCreateImage, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">
                                                  Thêm
                                             </button>
                                        </div>
                                        <div class="row mt-2">
                                             <carousel :settings="settings" :breakpoints="breakpoints"
                                                  style="width:100%; height: 195px;">
                                                  <slide v-for="(image, i) in imagesList" :key="i">
                                                       <ImageComponent :images="image" />
                                                  </slide>
                                                  <template #addons>
                                                       <navigation v-if="imagesList.length > getWidth()" />
                                                       <!-- <pagination style="color: #00BA13;" />  -->
                                                  </template>
                                             </carousel>
                                        </div>
                                   </div>
                              </div>
                              <!-- ----------------------FertilizerTimes Tab-------------- -->
                              <div class="row activitiesList ml-2 mr-2 mt-2" v-if="isOpenTableFertilizerTimes">
                                   <input type="text" class="form-control inputSearch1" placeholder="Tìm"
                                        v-model="nameToSearch" @click="retrieveFertilizerTimesList()"
                                        @keyup.enter="searchNameFertilizer(nameToSearch)"
                                        @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                                   <button class="btnSearch1" @click="searchNameFertilizer(nameToSearch)"
                                        v-if="nameToSearch == '' && !isOpenSearch.open">
                                        <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                                   </button>
                                   <!-- :class="{ openSearch:isOpenSearch.open, closeSearch:isOpenSearch.close }"  -->
                                   <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                        <p class="item" v-for="fertilizerTimes in filteredFerilizerTimesList()"
                                             :key="fertilizerTimes.Fertilizer_id"
                                             @click="searchNameFertilizer(fertilizerTimes.Fertilizer_name)">
                                             {{ fertilizerTimes.Fertilizer_name }}</p>
                                   </div>
                                   <button class="btn mt-1 btnAdd "
                                        @click="isOpenCreateFertilizerTimesForm = !isOpenCreateFertilizerTimesForm, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">Thêm</button>
                                   <div class="tableFixHead">
                                        <table class="table">
                                             <thead>
                                                  <tr>
                                                       <th class="text-center ">Lần</th>
                                                       <th>Tên phân bón</th>
                                                       <th class="text-center ">Số lượng (kg/ha)</th>
                                                       <th class="text-center ">Ngày bất đầu</th>
                                                       <th class="text-center ">Ngày kết thúc</th>
                                                       <th class="">Nhân viên</th>
                                                       <th style="width: 2%;"></th>
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
                                                       <td class="">
                                                            <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                                                 aria-haspopup="true" aria-expanded="false">
                                                                 <i class="fas fa-ellipsis-v"></i>
                                                            </button>
                                                            <div class="dropdown-menu">
                                                                 <a class="dropdown-item action"
                                                                      @click="setFertilizerChoosen(fertilizer), isOpenUpdateFertilizerTimesForm = !isOpenUpdateFertilizerTimesForm, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">
                                                                      <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                                 </a>
                                                                 <a class="dropdown-item" href="#"
                                                                      @click="setFertilizerChoosen(fertilizer), setDelete('FertilizerTimes'), isOpenConfirm = !isOpenConfirm">
                                                                      <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                                 </a>

                                                            </div>
                                                       </td>
                                                  </tr>
                                             </tbody>
                                        </table>
                                   </div>

                              </div>

                              <!-- ----------------------SprayingTimes Tab-------------- -->
                              <div class="row activitiesList ml-2 mr-2 mt-2" v-if="isOpenTableSprayingTimes">
                                   <input type="text" class="form-control inputSearch1" placeholder="Tìm"
                                        v-model="nameToSearch" @click="retrieveSprayingTimesList()"
                                        @keyup.enter="searchNamePesticide(nameToSearch)"
                                        @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                                   <button class="btnSearch1" @click="searchNamePesticide(nameToSearch)"
                                        v-if="nameToSearch == '' && !isOpenSearch.open">
                                        <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                                   </button>
                                   <!-- :class="{ openSearch:isOpenSearch.open, closeSearch:isOpenSearch.close }"  -->
                                   <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                        <p class="item" v-for="(sprayingTimes, i) in filteredSprayingTimesList()" :key="i"
                                             @click="searchNamePesticide(sprayingTimes.Pesticide_name)">
                                             {{ sprayingTimes.Pesticide_name }}</p>
                                   </div>
                                   <button class="btn mt-1 btnAdd"
                                        @click="isOpenCreateSprayingTimesForm = !isOpenCreateSprayingTimesForm, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">Thêm</button>
                                   <div class="tableFixHead">
                                        <table class="table">
                                             <thead>
                                                  <tr>
                                                       <th class="text-center ">Mã</th>
                                                       <th>Tên thuốc</th>
                                                       <th class="text-center ">Liều lượng (lít/ha)</th>
                                                       <th class="text-center ">Ngày bất đầu</th>
                                                       <th class="text-center ">Ngày kết thúc</th>
                                                       <th class="">Nhân viên</th>
                                                       <th class=""></th>
                                                  </tr>
                                             </thead>
                                             <tbody>
                                                  <tr v-for="(sprayingTimes, i ) in (SprayingTimesList)" :key="i">
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
                                                       <td class="">
                                                            <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                                                 aria-haspopup="true" aria-expanded="false">
                                                                 <i class="fas fa-ellipsis-v"></i>
                                                            </button>
                                                            <div class="dropdown-menu">
                                                                 <a class="dropdown-item action"
                                                                      @click="setSprayingTimes(sprayingTimes), isOpenUpdateSprayingTimesForm = !isOpenUpdateSprayingTimesForm, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">
                                                                      <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                                 </a>
                                                                 <a class="dropdown-item" href="#"
                                                                      @click="setSprayingTimes(sprayingTimes), isOpenConfirm = !isOpenConfirm, setDelete('SprayingTimes')">
                                                                      <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                                 </a>

                                                            </div>
                                                       </td>
                                                  </tr>
                                             </tbody>
                                        </table>
                                   </div>
                              </div>

                              <!-- ----------------------EpidemicTimes Tab-------------- -->
                              <div class="row activitiesList ml-2 mr-2 mt-2" v-if="isOpenTableEpidemicTimes">
                                   <input type="text" class="form-control inputSearch1" placeholder="Tìm"
                                        v-model="nameToSearch" @click="retrieveEpidemicTimesList()"
                                        @keyup.enter="searchNameEpidemic(nameToSearch)"
                                        @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                                   <button class="btnSearch1" @click="searchNameEpidemic(nameToSearch)"
                                        v-if="nameToSearch == '' && !isOpenSearch.open">
                                        <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                                   </button>                                   <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                        <p class="item" v-for="(epidemicTimes, i) in filteredEpidemicTimesList()" :key="i"
                                             @click="searchNameEpidemic(epidemicTimes.Epidemic_name)">
                                             {{ epidemicTimes.Epidemic_name }}</p>
                                   </div>
                                   <button class="btn mt-1 btnAdd"
                                        @click="isOpenCreateEpidemicTimesForm = !isOpenCreateEpidemicTimesForm, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">Thêm</button>
                                   <div class="tableFixHead">
                                        <table class="table">
                                             <thead>
                                                  <tr>
                                                       <th class="text-center ">Lần</th>
                                                       <th>Tên bệnh dịch</th>
                                                       <th class="text-center ">Ngày bất đầu</th>
                                                       <th class="text-center ">Ngày kết thúc</th>
                                                       <th class="">Nhân viên</th>
                                                       <th class=""></th>
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
                                                       <td class="">
                                                            <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                                                 aria-haspopup="true" aria-expanded="false">
                                                                 <i class="fas fa-ellipsis-v"></i>
                                                            </button>
                                                            <div class="dropdown-menu">
                                                                 <a class="dropdown-item action"
                                                                      @click="setEpidemicChoosen(epidemic), isOpenUpdateEpidemicTimesForm = !isOpenUpdateEpidemicTimesForm, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">
                                                                      <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                                 </a>
                                                                 <a class="dropdown-item" href="#"
                                                                      @click="setEpidemicChoosen(epidemic), isOpenConfirm = !isOpenConfirm, setDelete('EpidemicTimes')">
                                                                      <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                                 </a>
                                                            </div>
                                                       </td>
                                                  </tr>
                                             </tbody>
                                        </table>
                                   </div>
                              </div>

                              <!-- ----------------------Monitor Tab-------------- -->
                              <div class="row activitiesList ml-2 mr-2 mt-2" v-if="isOpenTableMonitor">
                                   <input type="text" class="form-control inputSearch1" placeholder="Tìm"
                                        v-model="nameToSearch" @click="retrieveMonitorList()"
                                        @keyup.enter="searchNameMonitor(nameToSearch)"
                                        @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                                   <button class="btnSearch1" @click="searchNameMonitor(nameToSearch)"
                                        v-if="nameToSearch == '' && !isOpenSearch.open">
                                        <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                                   </button>                                   <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                        <p class="item" v-for="(monitor, i) in filteredMonitorList()" :key="i"
                                             @click="searchNameMonitor(monitor.Employee_name)">
                                             {{ monitor.Employee_name }}</p>
                                   </div>
                                   <button class="btn mt-1 btnAdd"
                                        @click="isOpenCreateMonitorForm = !isOpenCreateMonitorForm, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">Thêm</button>
                                   <div class="tableFixHead">
                                        <table class="table">
                                             <thead>
                                                  <tr>
                                                       <th class="text-center ">STT</th>
                                                       <th class="text-center ">Mã</th>
                                                       <th>Họ và Tên</th>
                                                       <th>Chuyên môn</th>
                                                       <th class="">Vai trò</th>
                                                       <th class=""></th>
                                                  </tr>
                                             </thead>
                                             <tbody>
                                                  <tr v-for="(monitor, i ) in (monitorList)" :key="i">
                                                       <td class="text-center" v-if="currentPage > 1">{{ i + ((currentPage -
                                                            1) *
                                                            elementsPerPage) + 1 }}
                                                       </td>
                                                       <td class="text-center" v-else>{{ i + 1 }}</td>
                                                       <td class="text-center">{{ monitor.Employee_id }}</td>
                                                       <td>{{ monitor.Employee_name }}</td>
                                                       <td>{{ monitor.Employee_major }}
                                                       </td>
                                                       <td class="">{{ monitor.Role_name }}</td>
                                                       <td class="">
                                                            <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                                                 aria-haspopup="true" aria-expanded="false">
                                                                 <i class="fas fa-ellipsis-v"></i>
                                                            </button>
                                                            <div class="dropdown-menu">
                                                                 <a class="dropdown-item" href="#"
                                                                      @click="setMonitorChoosen(monitor), isOpenConfirm = !isOpenConfirm, setDelete('Monitor')">
                                                                      <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                                 </a>
                                                            </div>
                                                       </td>
                                                  </tr>
                                             </tbody>
                                        </table>
                                   </div>
                              </div>

                              <!-- ----------------------OtherActivity Tab-------------- -->
                              <div class="row activitiesList ml-2 mr-2 mt-2" v-if="isOpenTableOtherActivitiesTimes">
                                   <input type="text" class="form-control inputSearch1" placeholder="Tìm"
                                        v-model="nameToSearch" @click="retrieveActivitiesDetail()"
                                        @keyup.enter="searchNameOtherActivity(nameToSearch)"
                                        @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                                   <button class="btnSearch1" @click="searchNameOtherActivity(nameToSearch)"
                                        v-if="nameToSearch == '' && !isOpenSearch.open">
                                        <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                                   </button>                                   <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                        <p class="item" v-for="(activityDetail, i) in filteredActivityDetailTimesList()" :key="i"
                                             @click="searchNameOtherActivity(activityDetail.OtherActivities_name)">
                                             {{ activityDetail.OtherActivities_name }}</p>
                                   </div>
                                   <button class="btn mt-1 btnAdd"
                                        @click="isOpenCreateActivitiesDetail = !isOpenCreateActivitiesDetail, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">Thêm</button>
                                   <div class="tableFixHead">
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
                                                       <th class=""></th>
                                                  </tr>
                                             </thead>
                                             <tbody>
                                                  <tr v-for="(activity, i ) in (activitiesDetailList)" :key="i">
                                                       <td class="text-center" v-if="currentPage > 1">{{ i + ((currentPage -
                                                            1) *
                                                            elementsPerPage) }}
                                                       </td>
                                                       <td class="text-center" v-else>{{ i }}</td>
                                                       <td class="text-center">{{ activity.OtherActivities_id }}</td>

                                                       <td>{{ activity.OtherActivities_name }}</td>
                                                       <td>{{ activity.ActivityDetails_times }}</td>
                                                       <td>{{ formatDate(activity.ActivityDetails_startDate) }}</td>
                                                       <td>{{ formatDate(activity.ActivityDetails_endDate) }}</td>
                                                       <td class="">{{ activity.Employee_name }}</td>
                                                       <td class="">
                                                            <button type="button" class="btn btn-sm" data-toggle="dropdown"
                                                                 aria-haspopup="true" aria-expanded="false">
                                                                 <i class="fas fa-ellipsis-v"></i>
                                                            </button>
                                                            <div class="dropdown-menu">
                                                                 <a class="dropdown-item action"
                                                                      @click="setActivityChoosen(activity), isOpenUpdateActivitiesDetail = !isOpenUpdateActivitiesDetail, stylebac.none = !stylebac.none, stylebac.active = !stylebac.active">
                                                                      <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                                 </a>
                                                                 <a class="dropdown-item" href="#"
                                                                      @click="setActivityChoosen(activity), isOpenConfirm = !isOpenConfirm, setDelete('ActivitiseDetail')">
                                                                      <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                                 </a>

                                                            </div>
                                                       </td>
                                                  </tr>
                                             </tbody>
                                        </table>
                                   </div>
                              </div>
                              <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->

                              <div class="confirmationDialog" v-if="isOpenConfirm">
                                   <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                                        class="labelConfirm">
                                        <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                                   </p>
                                   <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                                        @click="isOpenConfirm = !isOpenConfirm, isOpenMessage = !isOpenMessage, choosenDelete()">Xóa</button>
                                   <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                                        @click="isOpenConfirm = !isOpenConfirm">Hủy</button>
                              </div>

                              <div class="messageDialog" v-if="isOpenMessage">
                                   <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                                        class="labelThongBao">
                                        <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span>
                                        {{
                                             message
                                        }}
                                   </p>
                                   <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                                        @click="isOpenMessage = !isOpenMessage">OK</button>
                              </div>

                         </div>
                    </div>
               </div>
          </div>
          <CreateFertilizerTimesForm v-if="isOpenCreateFertilizerTimesForm" :newFertilizerTimes="newFertilizerTimes"
               :fertilizerList="fertilizerList" :developmentStageList="developmentStageList" :currentUser="currentUser"
               :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
               @addFertilizerTimes-submit="createFertilizerTimes" :message1="message1" :message2="message2" />
          <UpdateFertilizerTimesForm v-if="isOpenUpdateFertilizerTimesForm" :newFertilizerTimes="fertilizerTimesChoosen"
               :fertilizerList="fertilizerList" :developmentStageList="developmentStageList" :currentUser="currentUser"
               :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
               @updateFertilizerTimes-submit="updateFertilizerTimes" :message1="message1" :message2="message2" />

          <CreateSprayingTimesForm v-if="isOpenCreateSprayingTimesForm" :newSprayingTimes="newSprayingTimes"
               :pesticideList="pesticideList" :developmentStageList="developmentStageList" :currentUser="currentUser"
               :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
               @addSprayingTimes-submit="createNewSprayingTimes" :message1="message1" :message2="message2" />

          <UpdateSprayingTimesForm v-if="isOpenUpdateSprayingTimesForm" :newSprayingTimes="sprayingTimesChoosen"
               :pesticideList="pesticideList" :developmentStageList="developmentStageList" :currentUser="currentUser"
               :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
               @updateSprayingTimes-submit="updateSprayingTimes" :message1="message1" :message2="message2" />
          <CreateEpidemicTimesForm v-if="isOpenCreateEpidemicTimesForm" :newEpidemicTimes="newEpidemicTimes"
               :epidemicList="epidemicList" :developmentStageList="developmentStageList" :currentUser="currentUser"
               :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList" @addEpidemicTimes-submit="createEpidemicTimes"
               :message1="message1" :message2="message2" />

          <UpdateEpidemicTimesForm v-if="isOpenUpdateEpidemicTimesForm" :newEpidemicTimes="epidemicTimesChoosen"
               :epidemicList="epidemicList" :developmentStageList="developmentStageList" :currentUser="currentUser"
               :riceCropChoosen="newRiceCrop" :arableLandList="arableLandList"
               @updateEpidemicTimes-submit="updateEpidemicTimes" :message1="message1" :message2="message2" />
          <CreateMonitorForm v-if="isOpenCreateMonitorForm" :newMonitor="newMonitor" :employeeList="employeeList"
               :newRiceCrop="newRiceCrop" @addMonitor-submit="createNewMonitor" :message1="message1" :message2="message2" />

          <CreateImageForm v-if="isOpenCreateImage" :newImage="newImage" :message1="message1" :message2="message2"
               :newRiceCrop="newRiceCrop" @addImage-submit=createNewImage />

          <CreateActivitiiesDetailForm v-if="isOpenCreateActivitiesDetail" :newActivityDetail="newActivityDetail"
               :currentUser="currentUser" :developmentStageList="developmentStageList" :riceCropChoosen="newRiceCrop"
               @addOtherActivityTimes-submit="createNewActivitiesDetail" :message1="message1" :message2="message2" />
          <UpadteActivitiiesDetailForm v-if="isOpenUpdateActivitiesDetail" :newActivityDetail="activitiesDetailChoosen"
               :currentUser="currentUser" :developmentStageList="developmentStageList" :riceCropChoosen="newRiceCrop"
               @updateActivitiesDetail-submit="updateNewActivitiesDetail" :message1="message1" :message2="message2" />
     </div>
     <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>
</template>

<script >

import UpdateRiceCropForm from '@/components/catalogManagementComponents/updateRiceCropForm.vue';
import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import CropService from '@/services/crop.service';
import SeedService from '@/services/seed.service';
import ArableLandService from '@/services/arableLand.service';
import RiceCropService from '@/services/riceCropInformation.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import fertilizerService from '@/services/fertilizer.service';
import MonitorService from '@/services/monitor.service';
import developmentStageService from '@/services/developmentStage.service';
import CreateFertilizerTimesForm from '@/components/catalogManagementComponents/createNewFertilizerTimesForm.vue';
import PesticideService from '@/services/pesticide.service';
import EpidemicService from '@/services/epidemic.service';
import EpidemicTimesService from '@/services/epidemicTimes.service';
import CreateSprayingTimesForm from '@/components/catalogManagementComponents/createNewSprayingTimesForm.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import FertilizerTimesService from '@/services/fertilizerTimes.service';
import SprayingTimesService from '@/services/sprayingTimes.service';
import UpdateFertilizerTimesForm from '@/components/catalogManagementComponents/updateFertilizerTimesForm.vue';
import UpdateSprayingTimesForm from '@/components/catalogManagementComponents/updateSprayingTimesForm.vue';
import CreateEpidemicTimesForm from '@/components/catalogManagementComponents/createNewEpidemicTimesForm.vue';
import UpdateEpidemicTimesForm from '@/components/catalogManagementComponents/updateEpidemicTimesForm.vue';
import EmployeeService from '@/services/employee.service';
import CreateMonitorForm from '@/components/catalogManagementComponents/createNewMonitorForm.vue';
// import CreateImageForm from '@/components/catalogManagementComponents/createNewImageForm.vue';
import CreateImageForm from '@/components/catalogManagementComponents/SanPhamFormThem.vue';
import ImagesService from '@/services/images.service';
import ImageComponent from '@/components/catalogManagementComponents/imageComponent.vue';
import 'vue3-carousel/dist/carousel.css'
import { Carousel, Slide, Navigation } from 'vue3-carousel';
import ActivityDetailsService from '@/services/activityDetails.service';
import UpadteActivitiiesDetailForm from '@/components/catalogManagementComponents/updateActivitiesDetailForm.vue'
import CreateActivitiiesDetailForm from '@/components/catalogManagementComponents/createNewOtherActivityTimesForm.vue';
import axios from 'axios';
import otherActivitiesService from '@/services/otherActivities.service';
export default {
     name: "riceCropDetail",

     props: ["riceCrop"],

     components: {
          UpdateRiceCropForm,
          Catalog,
          ImageComponent,
          CreateFertilizerTimesForm,
          UpdateFertilizerTimesForm,
          CreateSprayingTimesForm,
          UpdateSprayingTimesForm,
          CreateEpidemicTimesForm,
          UpdateEpidemicTimesForm,
          CreateMonitorForm,
          CreateImageForm,
          CreateActivitiiesDetailForm,
          UpadteActivitiiesDetailForm,
          TopHeader,
          Carousel,
          Slide,
          Navigation,
     },

     data() {
          return {
               nameToSearch: "",
               activitiesList: [],
               newRiceCrop: {},
               employeeList: {},
               newMonitor: {},
               newOtherActivities: {},
               newFertilizerTimes: {},
               newSprayingTimes: {},
               newEpidemicTimes: {},
               newOtherActivitiesTimes: {},
               monitorList: [],
               cropList: [],
               seedList: [],
               pesticideList: [],
               arableLandList: [],
               developmentStageList: [],
               fertilizerTimesList: [],
               SprayingTimesList: [],
               epidemicList: [],
               epidemicTimesList: [],
               riceCropList: [],
               imagesList: [],
               otherActivitiesList: [],
               activitiesDetailList: [],
               message1: "",
               message2: "",
               isOpenTableFertilizerTimes: true,
               isOpenTableSprayingTimes: false,
               isOpenTableOtherActivitiesTimes: false,
               isOpenTableEpidemicTimes: false,
               isOpenTableMonitor: false,
               isOpenImage: false,
               isOpenCreateImage: false,
               newImage: {},
               isOpenCreateFertilizerTimesForm: false,
               isOpenUpdateFertilizerTimesForm: false,
               fertilizerTimesChoosen: {},
               isOpenCreateSprayingTimesForm: false,
               isOpenUpdateSprayingTimesForm: false,
               sprayingTimesChoosen: {},
               isOpenCreateEpidemicTimesForm: false,
               isOpenUpdateEpidemicTimesForm: false,
               epidemicTimesChoosen: {},
               isOpenCreateMonitorForm: false,
               newActivityDetail: {},
               isOpenCreateActivitiesDetail: false,
               isOpenUpdateActivitiesDetail: false,
               activitiesDetailChoosen: {},
               currentPage: 1,
               elementsPerPage: 4,
               ascending: false,
               previous: '<<',
               next: '>>',
               delete: "",
               isOpenConfirm: false,
               isOpenMessage: false,
               message: "",
               monitorChoosen: {},
               idImage: 0,
               settings: {
                    itemsToShow: 1,
                    snapAlign: 'center',

               },
               breakpoints: {
                    500: {
                         itemsToShow: 2,
                         snapAlign: 'left',
                    },
                    800: {
                         itemsToShow: 3,
                         snapAlign: 'left',
                    },

                    // 700px and up
                    1000: {
                         itemsToShow: 4.5,
                         snapAlign: 'left',
                    },
                    1200: {
                         itemsToShow: 5,
                         snapAlign: 'left',
                    },
                    // 1024 and up
                    1400: {
                         itemsToShow: 5.5,
                         snapAlign: 'start',
                    },
                    1500: {
                         itemsToShow: 4,
                         snapAlign: 'start',
                    },
                    1600: {
                         itemsToShow: 8,
                         snapAlign: 'start',
                    },

               },

               stylebac: {
                    active: true,
                    none: false,
               },

               isOpenSearch: {
                    open: false,
                    close: true,
               },

               cloneFertilizerTimesList: [],
               cloneSprayingTimesList: [],
               cloneEpidemicTimesList: [],
               cloneMonitorList: [],
               cloneActivityDetailList: [],
               cloneImageList: [],
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


     methods: {

          ...mapMutations([
               "initEmployeeState"
          ]),

          filteredFerilizerTimesList() {
               return this.cloneFertilizerTimesList.filter(fertilizerTimes => {
                    return fertilizerTimes.Fertilizer_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          filteredSprayingTimesList() {
               return this.cloneSprayingTimesList.filter(sprayingTimes => {
                    return sprayingTimes.Pesticide_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          filteredEpidemicTimesList() {
               return this.cloneEpidemicTimesList.filter(epidemic => {
                    return epidemic.Epidemic_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          filteredActivityDetailTimesList() {
               return this.cloneActivityDetailList.filter(activity => {
                    return activity.OtherActivities_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          filteredMonitorList() {
               return this.cloneMonitorList.filter(monitor => {
                    return monitor.Employee_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          filteredImagesList() {
               return this.cloneImageList.filter(image => {
                    return image.Images_date.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
          },

          async retrieveEmpoyeeList() {
               const [err, respone] = await this.handle(
                    EmployeeService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.employeeList = respone.data;
                    console.log(respone.data);
               }
          },

          async retrieveCropList() {
               const [err, respone] = await this.handle(
                    CropService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.cropList = respone.data;
                    console.log(respone.data);
               }
          },

          async retrieveEpidemicList() {
               const [err, respone] = await this.handle(
                    EpidemicService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.epidemicList = respone.data;
                    console.log(respone.data);
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
                    if (respone.data != "Không tìm thấy lần bị dịch bệnh.") {
                         this.epidemicTimesList = respone.data;
                         this.cloneEpidemicTimesList = respone.data;
                         this.newEpidemicTimes.EpidemicTimes_times = this.epidemicTimesList[this.epidemicTimesList.length - 1].EpidemicTimes_times + 1;
                    }
                    else {
                         this.newEpidemicTimes.EpidemicTimes_times = 1;
                    }

               }
          },

          async retrieveSeedList() {
               const [err, respone] = await this.handle(
                    SeedService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.seedList = respone.data;
                    console.log(respone.data);
               }
          },


          async retrieveArableLandList() {
               const [err, respone] = await this.handle(
                    ArableLandService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.arableLandList = respone.data;
                    console.log(respone.data);
               }
          },
          async retrieveRiceCropList() {
               const [err, respone] = await this.handle(
                    RiceCropService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.riceCropList = respone.data;
                    console.log(respone.data);
               }
          },
          async retrieveFertilizerList() {
               const [err, respone] = await this.handle(
                    fertilizerService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.fertilizerList = respone.data;
                    console.log(respone.data);
               }
          },

          async retrieveDvelopmentStageList() {
               const [err, respone] = await this.handle(
                    developmentStageService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.developmentStageList = respone.data;
                    console.log(respone.data);
               }
          },

          async retrievePesticideList() {
               const [err, respone] = await this.handle(
                    PesticideService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.pesticideList = respone.data;
                    console.log(respone.data);
               }
          },

          async retrieveFertilizerTimesList() {
               const [err, respone] = await this.handle(
                    FertilizerTimesService.get(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    if (respone.data != "Không tìm thấy lần bón phân.") {
                         this.fertilizerTimesList = respone.data;
                         this.cloneFertilizerTimesList = respone.data;
                         this.newFertilizerTimes.FertilizerTimes_times = this.fertilizerTimesList[this.fertilizerTimesList.length - 1].FertilizerTimes_times + 1;
                    }
                    else {
                         this.newFertilizerTimes.FertilizerTimes_times = 1;
                    }
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
                    if (respone.data != "Không tìm thấy lần phun thuốc mới.") {
                         this.SprayingTimesList = respone.data;
                         this.cloneSprayingTimesList = respone.data;
                         this.newSprayingTimes.SprayingTimes_times = this.SprayingTimesList[this.SprayingTimesList.length - 1].SprayingTimes_times + 1;
                    }
                    else {
                         this.newSprayingTimes.SprayingTimes_times = 1;
                    }
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
                    this.cloneMonitorList = this.monitorList;
               }
          },



          async retrieveActivitiesDetail() {
               const [err, respone] = await this.handle(
                    ActivityDetailsService.findByName(this.newRiceCrop.RiceCropInformation_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.activitiesDetailList = respone.data;
                    this.retrieveOtherActivities();
               }
          },

          async retrieveOtherActivities() {
               const [err, respone] = await this.handle(
                    otherActivitiesService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.cloneActivityDetailList = respone.data;                  
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
                    this.newRiceCrop.RiceCropInformation_harvestDate = (moment(String(respone.data.RiceCropInformation_harvestDate)).format("YYYY-MM-DD")).slice(0, 10);
                    this.newRiceCrop.RiceCropInformation_yield = respone.data.RiceCropInformation_yield;
                    this.newRiceCrop.Crop_id = respone.data.Crop_id;
                    this.newRiceCrop.Crop_name = respone.data.Crop_name;
                    this.newRiceCrop.ArableLand_id = respone.data.ArableLand_id;
                    console.log(respone.data);
               }
          },

          async updateRiceCrop(data) {
               this.message1 = " ";
               this.message2 = " ";
               this.seedList.forEach(element => {
                    if (data.Seed_name == element.Seed_name) {
                         data.Seed_id = element.Seed_id;
                    }
               });

               this.cropList.forEach(element => {
                    if (data.Crop_name == element.Crop_name) {
                         data.Crop_id = element.Crop_id;
                    }
               });


               if (data.RiceCropInformation_sowingDate != null) {
                    data.RiceCropInformation_sowingDate = (moment(String(data.RiceCropInformation_sowingDate)).format("YYYY-MM-DD")).slice(0, 10);
               }

               else {
                    data.RiceCropInformation_sowingDate = null;
               }
               if (data.RiceCropInformation_harvestDate != null) {
                    data.RiceCropInformation_harvestDate = (moment(String(data.RiceCropInformation_harvestDate)).format("YYYY-MM-DD")).slice(0, 10);
               }
               else {
                    data.RiceCropInformation_harvestDate = null;
               }
               var check = true;
               this.riceCropList.forEach(element => {
                    if (element.ArableLand_id == data.ArableLand_id) {
                         if (element.RiceCropInformation_harvestDate == null) {
                              check = false;
                              console.log("alo" + check);
                         }
                    }
               });
               if (check == true) {
                    const [error, respone] = await this.handle(
                         RiceCropService.update(data.RiceCropInformation_id, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveNewRiceCrop();
                    }
               }
               else {
                    this.message1 = "Cập nhật không thành công.";
               }
          },

          async setFertilizerChoosen(data) {
               this.fertilizerTimesChoosen = data;
               this.fertilizerTimesChoosen.Fertilizer_id = data.Fertilizer_id;
               this.developmentStageList.forEach(element => {
                    if (data.DevelopmentStage_id == element.DevelopmentStage_id) {
                         data.DevelopmentStage_name = element.DevelopmentStage_name;
                    }
               });
          },

          // FertilizerTime
          async createFertilizerTimes(data) {
               if (data.close == false) {
                    this.isOpenCreateFertilizerTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newFertilizerTimes = {};
                    this.newFertilizerTimes.FertilizerTimes_times = this.fertilizerTimesList[this.fertilizerTimesList.length - 1].FertilizerTimes_times + 1;
                    this.stylebac.none = false;
                    this.stylebac.active = true;
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    // console.log("development "+data.DevelopmentStage_id);
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.fertilizerList.forEach(element => {
                         if (element.Fertilizer_name == data.Fertilizer_name) {
                              data.Fertilizer_id = element.Fertilizer_id;
                         }
                    });
                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;


                    if (data.FertilizerTimes_startDate != null) {
                         data.FertilizerTimes_startDate = (moment(String(data.FertilizerTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.FertilizerTimes_startDate = null;
                    }
                    if (data.FertilizerTimes_endDate != null) {
                         data.FertilizerTimes_endDate = (moment(String(data.FertilizerTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.FertilizerTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         FertilizerTimesService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo lần bón phân mới.") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveFertilizerTimesList();

                    }

               }

          },

          async updateFertilizerTimes(data) {
               if (data.close == false) {
                    this.isOpenTable = true;
                    this.isOpenUpdateFertilizerTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.newFertilizerTimes = {};
                    this.newFertilizerTimes.FertilizerTimes_times = this.fertilizerTimesList[this.fertilizerTimesList.length - 1].FertilizerTimes_times + 1;
                    this.stylebac.none = false;
                    this.stylebac.active = true;
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    // console.log("development "+data.DevelopmentStage_id);
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.fertilizerList.forEach(element => {
                         if (element.Fertilizer_name == data.Fertilizer_name) {
                              data.Fertilizer_id = element.Fertilizer_id;
                         }
                    });
                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;


                    if (data.FertilizerTimes_startDate != null) {
                         data.FertilizerTimes_startDate = (moment(String(data.FertilizerTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.FertilizerTimes_startDate = null;
                    }
                    if (data.FertilizerTimes_endDate != null) {
                         data.FertilizerTimes_endDate = (moment(String(data.FertilizerTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.FertilizerTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         FertilizerTimesService.update(this.newRiceCrop.RiceCropInformation_id, data.Fertilizer_id, data.FertilizerTimes_times, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveFertilizerTimesList();
                    }

               }

          },

          async setDelete(data) {
               this.delete = data;
          },

          async choosenDelete() {
               if (this.delete == "FertilizerTimes") {
                    this.deleteFertilizerTimes();
               }
               else if (this.delete == "SprayingTimes") {
                    this.deleteSprayingTimes();
               }
               else if (this.delete == "EpidemicTimes") {
                    this.deleteEpidemicTimes();
               }
               else if (this.delete == "Monitor") {
                    this.deleteMonitor();
               }
               else if(this.delete == "ActivitiseDetail") {
                    this.deleteActivitiesDetail();
               }
          },

          async deleteFertilizerTimes() {
               const [error, respone] = await this.handle(
                    FertilizerTimesService.delete(this.newRiceCrop.RiceCropInformation_id, this.fertilizerTimesChoosen.Fertilizer_id, this.fertilizerTimesChoosen.FertilizerTimes_times)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa không thành công."
               } else if (respone.data == "Lỗi trong quá trình lần bón phân!!") {
                    this.message = "Xóa không thành công."
               } else {
                    this.message = "Đã xóa thành công.";
                    
               }
               this.delete = "";
               this.retrieveFertilizerTimesList();
          },

          // SprayingTimes
          async setSprayingTimes(data) {
               this.sprayingTimesChoosen = data;
          },

          async createNewSprayingTimes(data) {
               if (data.close == false) {
                    this.isOpenCreateSprayingTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newSprayingTimes = {};
                    if (this.sprayingTimes.length > 0) {
                         this.newSprayingTimes.SprayingTimes_times = this.SprayingTimesList[this.SprayingTimesList.length - 1].SprayingTimes_times + 1;

                    }
                    else {
                         this.newSprayingTimes.SprayingTimes_times = 1;
                    }
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    // console.log("development "+data.DevelopmentStage_id);
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.pesticideList.forEach(element => {
                         if (element.Pesticide_name == data.Pesticide_name) {
                              data.Pesticide_id = element.Pesticide_id;
                         }
                    });

                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;


                    if (data.SprayingTimes_startDate != null) {
                         data.SprayingTimes_startDate = (moment(String(data.SprayingTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.SprayingTimes_startDate = null;
                    }
                    if (data.SprayingTimes_endDate != null) {
                         data.SprayingTimes_endDate = (moment(String(data.SprayingTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.SprayingTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         SprayingTimesService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công.";
                    } else if (respone.data == "Không thể tạo lần phun thuốc mới.") {
                         this.message1 = "Thêm không thành công.";
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveSprayingTimesList();
                    }

               }

          },

          async updateSprayingTimes(data) {
               if (data.close == false) {
                    this.isOpenUpdateSprayingTimesForm = false;
                    this.isOpenTable = true;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newSprayingTimes = {};
                    this.newSprayingTimes.SprayingTimes_times = this.SprayingTimesList[this.SprayingTimesList.length - 1].SprayingTimes_times + 1;
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    // console.log("development "+data.DevelopmentStage_id);
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.pesticideList.forEach(element => {
                         if (element.Pesticide_name == data.Pesticide_name) {
                              data.Pesticide_id = element.Pesticide_id;
                         }
                    });

                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;


                    if (data.SprayingTimes_startDate != null) {
                         data.SprayingTimes_startDate = (moment(String(data.SprayingTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.SprayingTimes_startDate = null;
                    }
                    if (data.SprayingTimes_endDate != null) {
                         data.SprayingTimes_endDate = (moment(String(data.SprayingTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.SprayingTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         SprayingTimesService.update(this.newRiceCrop.RiceCropInformation_id, data.Pesticide_id, data.SprayingTimes_times, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.retrieveSprayingTimesList();
                    }

               }

          },

          async deleteSprayingTimes() {
               const [error, respone] = await this.handle(
                    SprayingTimesService.delete(this.newRiceCrop.RiceCropInformation_id, this.sprayingTimesChoosen.Pesticide_id, this.sprayingTimesChoosen.SprayingTimes_times)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa không thành công."
               } else if (respone.data == "Lỗi trong quá trình xóa lần phun thuốc!!") {
                    this.message = "Xóa không thành công."
               } else {
                    this.message = "Xóa thành công.";
                    this.retrieveSprayingTimesList();
               }
               this.delete = "";
          },

          // EidemicTimes
          async setEpidemicChoosen(data) {
               this.epidemicTimesChoosen = data;
          },

          async createEpidemicTimes(data) {
               if (data.close == false) {
                    this.isOpenCreateEpidemicTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newEpidemicTimes = {};
                    if (this.epidemicTimesList.length > 0) {
                         this.newEpidemicTimes.EpidemicTimes_times = this.epidemicTimesList[this.epidemicTimesList.length - 1].EpidemicTimes_times + 1;
                    }
                    else {
                         this.newEpidemicTimes.EpidemicTimes_times = this.epidemicTimesList[this.epidemicTimesList.length - 1].EpidemicTimes_times + 1;
                    }

               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    // console.log("development "+data.DevelopmentStage_id);
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.epidemicList.forEach(element => {
                         if (element.Epidemic_name == data.Epidemic_name) {
                              data.Epidemic_id = element.Epidemic_id;
                         }
                    });

                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;


                    if (data.EpidemicTimes_startDate != null) {
                         data.EpidemicTimes_startDate = (moment(String(data.EpidemicTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.EpidemicTimes_startDate = null;
                    }
                    if (data.EpidemicTimes_endDate != null) {
                         data.EpidemicTimes_endDate = (moment(String(data.EpidemicTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.EpidemicTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         EpidemicTimesService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Không thể tạo lần bị dịch bệnh mới.") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         this.retrieveEpidemicTimesList();
                    }

               }
          },

          async updateEpidemicTimes(data) {
               if (data.close == false) {
                    this.isOpenTable = true;
                    this.isOpenUpdateEpidemicTimesForm = false;
                    this.message1 = " ";
                    this.message2 = " ";
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newSprayingTimes = {};
                    this.newEpidemicTimes.EpidemicTimes_times = this.epidemicTimesList[this.epidemicTimesList.length - 1].EpidemicTimes_times + 1;
                    this.stylebac.none = false;
                    this.stylebac.active = true;
               }
               else {
                    this.message1 = " ";
                    this.message2 = " ";
                    // console.log("development "+data.DevelopmentStage_id);
                    this.developmentStageList.forEach(element => {
                         if (element.DevelopmentStage_name == data.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });

                    this.epidemicList.forEach(element => {
                         if (element.Epidemic_name == data.Epidemic_name) {
                              data.Epidemic_id = element.Epidemic_id;
                         }
                    });

                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;

                    if (data.EpidemicTimes_startDate != null) {
                         data.EpidemicTimes_startDate = (moment(String(data.EpidemicTimes_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.EpidemicTimes_startDate = null;
                    }
                    if (data.EpidemicTimes_endDate != null) {
                         data.EpidemicTimes_endDate = (moment(String(data.EpidemicTimes_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.EpidemicTimes_endDate = null;
                    }

                    const [error, respone] = await this.handle(
                         EpidemicTimesService.update(this.newRiceCrop.RiceCropInformation_id, data.Epidemic_id, data.EpidemicTimes_times, data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Cập nhật không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         console.log(respone.data);
                         this.retrieveEpidemicTimesList();
                    }

               }
          },

          async deleteEpidemicTimes() {
               const [error, respone] = await this.handle(
                    EpidemicTimesService.delete(this.newRiceCrop.RiceCropInformation_id, this.epidemicTimesChoosen.Epidemic_id, this.epidemicTimesChoosen.EpidemicTimes_times)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa không thành công."
               } else if (respone.data == "Lỗi trong quá trình xóa lần bị dịch bệnh!!") {
                    this.message = "Xóa không thành công."
               } else {
                    this.message = "Xóa thành công.";
                    console.log(respone.data);
                    this.retrieveEpidemicTimesList();
               }
               this.delete = "";
          },

          // Monitor
          async setMonitorChoosen(data) {
               this.monitorChoosen = data;
          },

          async createNewMonitor(data) {
               if (data.close == false) {
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.isOpenCreateMonitorForm = false;
                    this.retrieveMonitorList();
               }
          },

          async deleteMonitor() {
               const [error, response] = await this.handle(
                    MonitorService.delete(this.newRiceCrop.RiceCropInformation_id, this.monitorChoosen.Employee_id)
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         this.message = "Xóa không thành công.";
                    }
                    else if (response.data == "Lỗi trong quá trình xóa quyền giám sát!!") {
                         this.message = "Xóa không thành công";
                    }
                    else {
                         this.message = "Xóa thành công.";
                         this.retrieveMonitorList();
                    }
               }
               this.delete = "";
          },

          formatDate(data) {
               if (data == null) return "";
               return (moment(String(data)).format("DD-MM-YYYY")).slice(0, 10);
          },

          async setTable(data) {
               this.isOpenImage = false;
               this.isOpenTableEpidemicTimes = false;
               this.isOpenTableFertilizerTimes = false;
               this.isOpenTableMonitor = false;
               this.isOpenTableOtherActivitiesTimes = false
               this.isOpenTableSprayingTimes = false;
               this.isOpenImage = false;
               this.nameToSearch = "";
               if (data == "btnImage") {
                    this.isOpenImage = true;
               }
               else if (data == "btnFertilizerTimes") {
                    this.retrieveFertilizerTimesList();
                    this.isOpenTableFertilizerTimes = true;
               }
               else if (data == "btnSprayingTimes") {
                    this.retrieveSprayingTimesList();
                    this.isOpenTableSprayingTimes = true;
               }
               else if (data == "btnActivities") {
                    this.isOpenTableOtherActivitiesTimes = true;
               }
               else if (data == "btnEpidemic") {
                    this.retrieveEpidemicTimesList();
                    this.isOpenTableEpidemicTimes = true;
               }
               else if (data == "btnAttendee") {
                    this.isOpenTableMonitor = true;
                    this.retrieveMonitorList();
               }
          },

          // Images
          async getIdImage() {
               const [error, response] = await this.handle(
                    ImagesService.getAll()
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         console.log(error)
                    }
                    else {
                         const temp = response.data;
                         if (temp.length > 0) {
                              this.idImage = temp[temp.length - 1].Image_id + 1;
                         }
                         else {
                              this.idImage = 1;

                         }
                    }
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
                    }
               }
          },
          async retrieveImageID(link) {
               this.getIdImage();
               const data = {};
               data.Employee_id = this.currentUser.Employee_id;
               data.Image_link = link;
               const day = new Date();
               data.Image_id = this.idImage; console.log(this.idImage)
               data.Image_date = (day.getFullYear()) + "-" + (day.getMonth()) + "-" + (day.getDate()) + " " + (day.getHours()) + ":" + day.getMinutes() + ":" + day.getSeconds();
               console.log((day.getFullYear()) + "-" + (day.getMonth()) + "-" + (day.getDate()) + " " + (day.getHours()) + ":" + day.getMinutes() + ":" + day.getSeconds())
               data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
               const [error, response] = await this.handle(
                    ImagesService.create(data)
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         this.message = "Them không thành công.";
                    }
                    else if (response.data == "Không thể lưu hình ảnh.") {
                         this.message = "Xóa không thành công";
                    }
                    else {
                         this.message = "Xóa thành công.";
                    }
               }
               console.log(data);
          },

          async createNewImage(data) {
               if (data.close == false) {
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.isOpenCreateImage = false;
               }
               else {
                    if (data.Image != null) {
                         const formdata = require('form-data');
                         const formData = new formdata();
                         formData.append("image", data.Image);
                         console.log("HFWBEFE   `    ");
                         axios.post('http://localhost:8080/api/image', formData, {
                              headers: {
                                   'Content-Type': `multipart/form-data;`,
                              }
                         },
                         ).then((response) => {
                              fnSuccess(response);
                         }).catch((error) => {
                              fnFail(error);
                         });

                         const fnSuccess = (response) => {
                              this.retrieveImageID(response.data.Image_link);
                              this.message2 = "Thêmthành công";
                         };

                         const fnFail = (error) => {
                              console.log(error);
                              this.message2 = "Thêm không thành công";
                         };
                    }
                    else {
                         this.message1 = "Vui lòng chọn hình ảnh!!"
                    }
               }
          },

          // ActivityDetail
          async setActivityChoosen(data){
               this.activitiesDetailChoosen = data;
          },

          async createNewActivitiesDetail(data) {
               this.message1 = "";
               this.message2 = "";
               if (!data.close) {
                    this.isOpenUpdateActivitiesDetail = false;
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newActivityDetail = {};
               }
               else {
                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;
                    this.otherActivitiesList.forEach(element => {
                         if (data.OtherActivities_name == element.OtherActivities_name) {
                              data.OtherActivities_id = element.OtherActivities_id;
                         }
                    });
                    this.developmentStageList.forEach(element => {
                         if (data.DevelopmentStage_name == element.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });
                    console.log(data.ActivityDetails_startDate)
                    if (data.ActivityDetails_endDate != null) {
                         data.ActivityDetails_endDate = (moment(String(data.ActivityDetails_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.ActivityDetails_endDate = null;
                    }
                    if (data.ActivityDetails_startDate != null) {
                         data.ActivityDetails_startDate = (moment(String(data.ActivityDetails_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.ActivityDetails_startDate = null;
                    }
                    const [error, response] = await this.handle(
                         ActivityDetailsService.create(data)
                    );

                    if (response.data == error) {
                         this.message1 = "Thêm không thành công.";
                    }
                    else if (response.data == "Không thể tạo chi tiết hoạt động mới.") {
                         this.message1 = "Thêm không thành công.";
                    }
                    else {
                         this.message2 = "Thêm thành công.";
                    }

               }
          },

          async updateNewActivitiesDetail(data) {
               console.log("hsjkcdsqa")
               this.message1 = "";
               this.message2 = "";
               if (!data.close) {
                    this.isOpenUpdateActivitiesDetail = false;
                    this.stylebac.none = false;
                    this.stylebac.active = true;
                    this.newActivityDetail = {};
               }
               else {
                    data.RiceCropInformation_id = this.newRiceCrop.RiceCropInformation_id;
                    data.Employee_id = this.currentUser.Employee_id;
                    this.otherActivitiesList.forEach(element => {
                         if (data.OtherActivities_name == element.OtherActivities_name) {
                              data.OtherActivities_id = element.OtherActivities_id;
                         }
                    });
                    this.developmentStageList.forEach(element => {
                         if (data.DevelopmentStage_name == element.DevelopmentStage_name) {
                              data.DevelopmentStage_id = element.DevelopmentStage_id;
                         }
                    });
                    if (data.ActivityDetails_endDate != null) {
                         data.ActivityDetails_endDate = (moment(String(data.ActivityDetails_endDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.ActivityDetails_endDate = null;
                    }
                    if (data.ActivityDetails_startDate != null) {
                         data.ActivityDetails_startDate = (moment(String(data.ActivityDetails_startDate)).format("YYYY-MM-DD")).slice(0, 10);
                    }
                    else {
                         data.ActivityDetails_startDate = null;
                    }
                    //Ipdate
                    const [error, response] = await this.handle(
                         ActivityDetailsService.update(this.newRiceCrop.RiceCropInformation_id,data.OtherActivities_id, data.ActivityDetails_times,data)
                    );

                    if (response.data == error) {
                         this.message1 = "Cập nhật không thành công.";
                    }
                    else if (response.data == "Đã xảy ra lỗi trong quá trình cập nhật thông tin!") {
                         this.message1 = "Cập nhật không thành công.";
                    }
                    else {
                         this.message2 = "Cập nhật thành công.";
                    }
                    this.retrieveActivitiesDetail()
                    
               }
          },

          async deleteActivitiesDetail(){
               const [error, respone] = await this.handle(
                    ActivityDetailsService.delete(this.newRiceCrop.RiceCropInformation_id, this.activitiesDetailChoosen.OtherActivities_id, this.activitiesDetailChoosen.ActivityDetails_times)
               );
               if (error) {
                    console.log(error);
                    this.message = "Xóa không thành công."
               } else if (respone.data == "Lỗi trong quá trình lần bón phân!!") {
                    this.message = "Xóa không thành công."
               } else {
                    this.message = "Đã xóa thành công.";
                    this.retrieveActivitiesDetail()
               }
               this.delete = "";
          },

          getWidth() {
               var width = document.body.clientWidth;
               if (width > 500 && width < 800) {
                    return 2
               }
               else if (width >= 800 && width < 1000) {
                    return 3;
               }
               else if (width >= 100 && width < 1200) {
                    return 4.5;
               }
               else if (width >= 1200 && width < 1400) {
                    return 5;
               }
               else if (width >= 1400 & width < 1500) {
                    return 5.5;
               }
               else if (width >= 1500 && width < 1600) {
                    return 6;
               }
               else if (width >= 1600) {
                    return 8;
               }
          },

          // Search
          async searchNameEpidemic(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != "") {
                    this.epidemicTimesList = [];
                    this.cloneEpidemicTimesList.forEach(element => {
                         if (element.Epidemic_name == data) {
                              this.epidemicTimesList.push(element);
                         }
                    });
                    if (this.epidemicTimesList.length == 0) {

                         const [err, respone] = await this.handle(
                              EpidemicTimesService.getByName(this.nameToSearch, this.newRiceCrop.RiceCropInformation_id)
                         );
                         if (err) {
                              console.log(err)
                         }
                         else {
                              if (respone.data != "Không tìm thấy lần bị dịch bệnh.") {
                                   this.epidemicTimesList = respone.data;
                              }
                              else this.epidemicTimesList = [];
                         }
                    }
               }
               else {
                    this.retrieveEpidemicTimesList();
               }
          },

          async searchNameFertilizer(data) {
               this.nameToSearch = data;
               this.fertilizerTimesList = [];
               console.log(data)
               if (this.nameToSearch != "") {
                    this.cloneFertilizerTimesList.forEach(element => {
                         if (this.nameToSearch == element.Fertilizer_name) {
                              this.fertilizerTimesList.push(element)
                         }
                    });
                    if (this.fertilizerTimesList.length == 0) {
                         const [err, respone] = await this.handle(
                              FertilizerTimesService.getByName(this.nameToSearch, this.newRiceCrop.RiceCropInformation_id)
                         );
                         if (err) {
                              console.log(err)
                         }
                         else {
                              console.log(respone.data)
                              if (respone.data != "Không tìm thấy lần bón phân.") {
                                   this.fertilizerTimesList = respone.data;
                              }
                              else this.fertilizerTimesList = [];
                              console.log(this.fertilizerTimesList)
                         }
                    }

               }
               else {
                    this.retrieveFertilizerTimesList();
               }
          },

          async searchNamePesticide(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != "") {
                    this.SprayingTimesList = [];
                    this.cloneSprayingTimesList.forEach(element => {
                         if (element.Pesticide_name == data) {
                              this.SprayingTimesList.push(element);
                         }
                    });
                    if (this.SprayingTimesList.length == 0) {

                         const [err, respone] = await this.handle(
                              SprayingTimesService.getByName(this.nameToSearch, this.newRiceCrop.RiceCropInformation_id)
                         );
                         if (err) {
                              console.log(err)
                         }
                         else {
                              if (respone.data != "Không tìm thấy lần phun thuốc mới.") {
                                   this.SprayingTimesList = respone.data;
                              }
                              else this.SprayingTimesList = [];
                         }
                    }

               }
               else {
                    this.retrieveSprayingTimesList()
               }
          },

          async searchNameOtherActivity(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != "") {
                         const [err, respone] = await this.handle(
                              ActivityDetailsService.getByName(this.nameToSearch, this.newRiceCrop.RiceCropInformation_id)
                         );
                         if (err) {
                              console.log(err)
                         }
                         else {
                              this.activitiesDetailList = respone.data;
                         }
               }
               else {
                    this.retrieveActivitiesDetail()
               }
          },

          async searchNameMonitor(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != "") {
                    this.monitorList = [];
                    this.cloneMonitorList.forEach(element => {
                         if (element.Employee_name == data) {
                              this.monitorList.push(element);
                         }
                    });
                    if (this.monitorList.length == 0) {
                         const [err, respone] = await this.handle(
                              MonitorService.getByName(this.nameToSearch, this.newRiceCrop.RiceCropInformation_id)
                         );
                         if (err) {
                              console.log(err)
                         }
                         else {
                              this.monitorList = respone.data;
                         }
                    }
               }
               else {
                    this.retrieveMonitorList()
               }
          },
     },

     mounted() {
          this.initEmployeeState();
          this.retrieveArableLandList();
          this.retrieveCropList();
          this.retrieveDvelopmentStageList();
          this.retrieveFertilizerList();
          this.retrievePesticideList();
          this.retrieveSeedList();
          this.retrieveFertilizerTimesList();
          this.retrieveSprayingTimesList();
          this.retrieveMonitorList();
          this.retrieveNewRiceCrop();
          this.initEmployeeState();
          this.retrieveEpidemicList();
          this.retrieveEpidemicTimesList();
          this.retrieveRiceCropList();
          this.retrieveEmpoyeeList();
          this.retrieveImagesList();
          this.retrieveActivitiesDetail();
     }
};
</script>

<style>
@import url(../../assets/riceCropDetailStyle.css);

.btnAddimage {
     background-color: rgb(241, 248, 164);
     border-radius: 5px;
}

.riceCropDetail .categoryList .btnMonitor {
     display: block;
     width: 94%;
     font-size: 18px;
     background-color: #FFFA37;
     color: #5C5D22;
     border: none;
     font-family: Inter;
     border-radius: 14px;
}
</style>


<!-- <nav aria-label="...">
     <ul class="pagination " aria-controls="my-table">
          <li class="page-item disabled" v-if="currentPage == 1">
               <a class="page-link" href="#" aria-controls="my-table">{{ previous }}</a>
          </li>
          <li class="page-item " v-if="currentPage > 1">
               <a class="page-link" href="#"
                    @click="change_page('-', fertilizerTimesList)"
                    aria-controls="my-table">{{
                         previous }}</a>
          </li>
          <li class="page-item"><a class="page-link" href="#"
                    @click="change_page(currentPage - 1, monitorList)"
                    v-if="currentPage > 1">{{
                         currentPage - 1 }}</a></li>
          <li class="page-item active">
               <a class="page-link"
                    style="background-color: #EEEA41; border-color: #EEEA41;" href="#">{{
                         currentPage }} <span class="sr-only">(current)</span></a>
          </li>
          <li class="page-item"><a class="page-link" href="#"
                    v-if="currentPage < num_pages(fertilizerTimesList)"
                    @click="change_page(currentPage + 1, fertilizerTimesList)">{{
                         currentPage + 1
                    }}</a></li>
          <li class="page-item">
               <a class="page-link" href="#"
                    @click="change_page('+', fertilizerTimesList)"
                    v-if="currentPage < num_pages(fertilizerTimesList)">{{
                         next }}</a>
          </li>
          <li class="page-item disabled">
               <a class="page-link" href="#"
                    v-if="currentPage >= num_pages(fertilizerTimesList)">{{
                         next }}</a>
          </li>
     </ul>
</nav> -->