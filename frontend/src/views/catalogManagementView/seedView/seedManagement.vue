<template>
     <div class="container-fluid seedManagement pr-4 pl-4" style="background-color: #ebfff3;">
          <div class="row seedManagementFrame">
               <div class="col-md-2 col-sm-12 leftSeedManagement">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>
               <div class="col-md-10 rightSeedManagement">
                    <div class="row mt-3 mb-4" >
                         <div class="col-sm-12">
                         <h2 class="text-center">GIỐNG LÚA</h2>
                    </div>
                    </div>
                    <div class="row" >
                         <div class="btnChoosePage col-sm-10">
                              <p style="display: inline-block; padding-top: 4px;text-align: right;" class="soTrang">
                                   Trang &nbsp;</p>
                              <div class="numberPage">
                                   <div class="dropdown">
                                        <button class="dropbtn">{{ currentPage }}
                                             <span class="fas fa-chevron-down"></span></button>
                                        <div class="dropdown-content">
                                             <a class="dropdown-item" v-for="(i, j) in num_pages() " :key="j"
                                                  v-bind:class="[i == currentPage ? 'active' : '']"
                                                  v-on:click="change_page(i)" aria-controls="my-table"> {{ i }}</a>
                                        </div>
                                   </div>
                              </div>
                         </div>
                         <div class="col-sm-2">
                              <button class="btn btnCreate"><i class="fas fa-plus-circle"></i>Thêm giống lúa</button>
                         </div>
                    </div>
                    <div class=" row seedList mt-3 ml-2 mr-2">
                         <table class="table mt-3 ml-2 mr-2">
                              <thead>
                                   <tr>
                                        <th>Mã</th>
                                        <th>Tên</th>
                                        <th>Nhà cung cấp</th>
                                        <th>Đặc tính</th>
                                        <th>Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(seed, i ) in get_rows()" :key="i">
                                        <td>{{ seed.Seed_id }}</td>
                                        <td>{{ seed.Seed_name }}</td>
                                        <td>{{ seed.Seed_supplier }}</td>
                                        <td>{{ seed.Seed_characteristic }}</td>
                                        <td >
                                             <tr class="actions row  mr-4 ml-1" style="border-top: 1px solid #ebfff3;">
                                                  <a class="col-md-6 action mt-2" @click="goToUpdateEmployee(seed.Seed_id)">
                                                       <span class="fas fa-edit actionIcon"></span>
                                                  </a>
                                                  <a class="col-md-6 action mt-2" @click="setEmployeeChoosen(seed), isOpenXacNhan = !isOpenXacNhan">
                                                       <span class="fas fa-trash-alt actionIcon"></span>
                                                  </a>
                                             </tr>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>
                    <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->

                    <div class="confirmationDialog" v-if="isOpenXacNhan">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelXacNhan">
                              <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                         </p>
                         <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                              @click="isOpenXacNhan = !isOpenXacNhan, isOpenThongBao = !isOpenThongBao, deleteEmployee(employeeChoosen.Employee_id)">Xóa</button>
                         <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                              @click="isOpenXacNhan = !isOpenXacNhan">Hủy</button>
                    </div>

                    <div class="messageDialog" v-if="isOpenThongBao">
                         <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;"
                              class="labelThongBao">
                              <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{
                                   message
                              }}
                         </p>
                         <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                              @click="isOpenThongBao = !isOpenThongBao">OK</button>
                    </div>
               </div>
          </div>
     </div>
</template>

<script>

import Catalog from '../../../components/catalogManagementComponents/catalog.vue';
import { mapGetters, mapMutations } from "vuex";
import SeedService from '../../../services/seed.service';
export default {
     name: "SeedManagement",
     components: {
          Catalog,
     },

     data() {
          return {
               currentPage: 1,
               elementsPerPage: 3,
               ascending: false,
               seedList: [],
          }
     },

     computed: {

          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },
     methods: {
          ...mapMutations([
               "initEmployeeState"
          ]),

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
          //  so hang của danh sach danh muc
          get_rows() {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return this.seedList.slice(start, end);
          },

          // So trang cua danh sach danh muc
          num_pages() {
               return Math.ceil(this.seedList.length / this.elementsPerPage);

          },

          async change_page(page) {
               this.currentPage = page;
          },
     },

     created() {
          this.initEmployeeState();
     },

     mounted(){
          this.retrieveSeedList();
     }
}
</script>

<style>
@import url(../../../assets/seedStyle.css);
</style>