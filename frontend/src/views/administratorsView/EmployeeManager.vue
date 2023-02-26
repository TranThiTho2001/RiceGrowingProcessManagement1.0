<template>
     <div class="EmployeeManagerFrame container-fluid">
          <div class="row EmployeeManager">
               <div class="col-sm-2">
                    <div class="row">
                         <Catalog :currentUserid="currentUser.Employee_id" />
                    </div>
               </div>

               <div class="col-sm-10 leftEmployeeManager">
                    <div class="row mr-2 mt-2 mb-4">
                         <div class="col-md-7 pr-5">
                              <div class="row">
                                   <input type="text" class="form-control col-sm-8 ml-4 pt-2 inputSearch"
                                        placeholder="Tìm theo tên" style="border-radius:10px" v-model="nameToSearch"
                                        @keyup.enter="searchName" />
                                   <button class=" btnSearch pt-2" @click="searchName">
                                        <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                                   </button>
                              </div>
                         </div>
                         <div class="col-md-3"></div>
                         <div class="col-md-2 pl-5 text-right">
                              <div class="row">
                                   <TopHeader :currentUserid="currentUser.Employee_id" />
                              </div>
                         </div>
                    </div>

                    <div class="row mr-2 ml-2">
                         <div class="col-sm-12 text-center">
                              <h2>DANH SÁCH NHÂN VIÊN</h2>
                         </div>
                    </div>

                    <div class="row mr-2 ml-2 mt-4 mb-3 ">
                         <div class="col-sm-12 text-right">
                              <button class="btnCreate pt-1 pb-1"
                                   @click="isOpenCreateEmployeeForm = !isOpenCreateEmployeeForm">
                                   <i class="fas fa-plus-circle"></i>Thêm Nhân Viên</button>
                         </div>
                    </div>

                    <div class=" row employeeList ml-2 mr-2">
                         <table class="table">
                              <thead>
                                   <tr>
                                        <th class="text-center">STT</th>
                                        <th class="text-center">Mã</th>
                                        <th>Họ và Tên</th>
                                        <th>Số điện thoại</th>
                                        <th>Chuyên môn</th>
                                        <th>Vai trò</th>
                                        <th>Tùy chọn</th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(employee, i ) in get_rows(employeeList)" :key="i">
                                        <td class="text-center" v-if="currentPage > 1">{{ i + ((currentPage - 1) * elementsPerPage) }}
                                        </td>
                                        <td class="text-center" v-else>{{ i }}</td>
                                        <td class="text-center">{{ employee.Employee_id }}</td>
                                        <td>{{ employee.Employee_name }}</td>
                                        <td>{{ employee.Employee_phoneNumber }}</td>
                                        <td>{{ employee.Employee_major }}</td>
                                        <td>{{ employee.Role_name }}</td>
                                        <td>
                                   <tr class="actions">
                                        <span @click="setEmployeeChoosen(employee), isOpenUpdateEmployeeForm = !isOpenUpdateEmployeeForm"><span
                                                  class="fas fa-edit pl-2"></span>
                                        </span>
                                        <span @click="setEmployeeChoosen(employee), isOpenXacNhan = !isOpenXacNhan"><span
                                                  class="fas fa-trash-alt pl-4"></span></span>
                                   </tr>
                                   </td>
                                   </tr>
                              </tbody>
                         </table>
                         <nav aria-label="...">
                              <ul class="pagination " aria-controls="my-table">
                                   <li class="page-item disabled" v-if="currentPage == 1">
                                        <a class="page-link" href="#" aria-controls="my-table">{{ previous }}</a>
                                   </li>
                                   <li class="page-item " v-if="currentPage > 1">
                                        <a class="page-link" href="#" @click="change_page('-', employeeList)"
                                             aria-controls="my-table">{{
                                                  previous }}</a>
                                   </li>
                                   <li class="page-item"><a class="page-link" href="#"
                                             @click="change_page(currentPage - 1, employeeList)" v-if="currentPage > 1">{{
                                                  currentPage - 1 }}</a></li>
                                   <li class="page-item active">
                                        <a class="page-link" style="background-color: #EEEA41; border-color: #EEEA41;"
                                             href="#">{{
                                                  currentPage }} <span class="sr-only">(current)</span></a>
                                   </li>
                                   <li class="page-item"><a class="page-link" href="#"
                                             v-if="currentPage < num_pages(employeeList)"
                                             @click="change_page(currentPage + 1, employeeList)">{{ currentPage + 1 }}</a>
                                   </li>
                                   <li class="page-item">
                                        <a class="page-link" href="#" @click="change_page('+', employeeList)"
                                             v-if="currentPage < num_pages(employeeList)">{{
                                                  next }}</a>
                                   </li>
                                   <li class="page-item disabled">
                                        <a class="page-link" href="#" v-if="currentPage >= num_pages(employeeList)">{{
                                             next }}</a>
                                   </li>
                              </ul>
                         </nav>
                    </div>

                    <CreateNewEmployeeForm v-if="isOpenCreateEmployeeForm" :newEmployee="newEmployee"
                         @addEmployee-submit="createEmployee" :message1="message1" :message2="message2" />
                    <UpdateEmployeeForm v-if="isOpenUpdateEmployeeForm" :newEmployee="employeeChoosen"
                         @updateEmployee-submit="updateEmployee" :message1="message1" :message2="message2" />
               </div>

          </div>

          <!-- danh sach so trang hien thi -->

          <!-- ------------------------------Bang xac nhan xoa nhan vien ----------------------------- -->

          <div class="confirmationDialog" v-if="isOpenXacNhan">
               <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelXacNhan">
                    <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
               </p>
               <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                    @click="isOpenXacNhan = !isOpenXacNhan, isOpenThongBao = !isOpenThongBao, deleteEmployee(employeeChoosen.Employee_id)">Xóa</button>
               <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                    @click="isOpenXacNhan = !isOpenXacNhan">Hủy</button>
          </div>

          <div class="messageDialog" v-if="isOpenThongBao">
               <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                    <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{ message }}
               </p>
               <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                    @click="isOpenThongBao = !isOpenThongBao">OK</button>
          </div>
     </div>
</template>
   
<script>

import employeeService from '../../services/employee.service';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue'
import CreateNewEmployeeForm from '../../components/administratorsComponent/createNewEmployeeForm.vue';
import UpdateEmployeeForm from '../../components/administratorsComponent/updateEmployeeForm.vue';
import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";

export default {
     name: 'EmployeeManager',
     components: {
          Catalog,
          TopHeader,
          CreateNewEmployeeForm,
          UpdateEmployeeForm,
     },
     data() {
          return {
               employeeList: [],
               isOpenXacNhan: false,
               isOpenThongBao: false,
               message: "",
               employeeChoosen: {},
               currentPage: 1,
               elementsPerPage: 6,
               ascending: false,
               previous: '<<',
               next: '>>',
               newEmployee: {},
               message1: " ",
               message2: " ",
               isOpenCreateEmployeeForm: false,
               isOpenUpdateEmployeeForm: false,
          }
     },

     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },

     created() {
          this.initEmployeeState();
     },

     methods: {
          ...mapMutations([
               "initEmployeeState"
          ]),

          async retrieveEmployeeList() {
               const [err, respone] = await this.handle(
                    employeeService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.employeeList = respone.data;
                    var temp = (String(this.employeeList[this.employeeList.length - 1].Employee_id)).split("");
                    var id = "";
                    for (let index = 0; index < temp.length; index++) {
                         const element = temp[index];
                         if (element != "E" && element != "E" & element != "0") {
                              for (let i = index; i < temp.length; i++) {
                                   id = id.concat(temp[i]);
                              }
                              break;
                         }
                    }
                    if (id < 9) {
                         this.newEmployee.Employee_id = "EE00000" + String(Number(id) + 1);
                    }
                    else if (id >= 9 && id < 99) {
                         this.newEmployee.Employee_id = "EE0000" + String(Number(id) + 1);
                    }
                    else if (id >= 99 && id < 999) {
                         this.newEmployee.Employee_id = "EE000" + String(Number(id) + 1);
                    }
                    else {
                         this.newEmployee.Employee_id = "EE00" + String(Number(id) + 1);
                    }
               }
          },

          async goToCreateNewEmployee() {
               this.$router.push("/CreateNewEmployee");
          },

          async goToUpdateEmployee(employeeId) {
               this.$router.push({ name: 'UpdateEmployee', params: { id: employeeId } })
          },

          async setEmployeeChoosen(employee) {
               this.employeeChoosen = employee;
               this.employeeChoosen.Employee_password = "";
          },

          async createEmployee(data) {
               this.message1 = "";
               this.message2 = "";
               if (data.close == false) {
                    this.newEmployee = {},
                    this.isOpenCreateEmployeeForm = false;
               }
               else {
                    if (data.Role_id == "Quản lý") {
                         data.Role_id = "01";
                    }
                    else if (data.Role_id == "Chuyên gia") {
                         data.Role_id = "02";
                    }
                    else {
                         data.Role_id = "03";
                    }

                    if (data.Employee_sex == true) {
                         data.Employee_sex = "Nam";
                    }
                    else {
                         data.Employee_sex = "Nữ";
                    }
                    data.Employee_birthDate = (moment(String(data.Employee_birthDate)).format("YYYY-MM-DD")).slice(0, 10);
                    const [error, respone] = await this.handle(
                         employeeService.create(data)
                    );
                    if (error) {
                         console.log(error);
                         this.message1 = "Thêm không thành công."
                    } else if (respone.data == "Đã xảy ra lỗi!!!") {
                         this.message1 = "Thêm không thành công."
                    } else {
                         this.message2 = "Thêm thành công.";
                         console.log(this.message2);
                         console.log(respone.data)
                         this.newEmployee = {};
                         this.retrieveEmployeeList();
                    }
               }
          },

          async updateEmployee(data) {
               if (data.close == false) {
                    this.isOpenUpdateEmployeeForm = false
               }
               else {
                    if (data.Role_name == "Quản lý") {
                         this.newEmployee.Role_id = "01";
                    }
                    else if (data.Role_name == "Chuyên gia") {
                         data.Role_id = "02";
                    }
                    else if (data.Role_name == "Nhân viên") {
                         data.Role_id = "03";
                    }

                    if (data.Employee_sex == true || data.Employee_sex == "Nam") {
                         data.Employee_sex = "Nam";
                    }
                    else {
                         data.Employee_sex = "Nữ";
                    }
                    data.Employee_birthDate = (moment(String(data.Employee_birthDate)).format("YYYY-MM-DD")).slice(0, 10);

                    const [error, response] = await this.handle(
                         employeeService.update(data.Employee_id, data)
                    );
                    if (error) {
                         console.log(error);
                    } else if (response.data == "Đã xảy ra lỗi!!!") {
                         this.message1 = "Cập nhật không thành công."
                    } else {
                         this.message2 = "Cập nhật thành công.";
                         this.newEmployee = response.data;
                         this.retrieveEmployeeList();
                    }
               }

          },

          async deleteEmployee(employeeId) {
               const [err, respone] = await this.handle(
                    employeeService.delete(employeeId)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    console.log(respone.data);
                    this.message = respone.data;
                    this.retrieveEmployeeList();
               }
          },

          async searchName() {
               const [error, response] = await this.handle(
                    employeeService.findByName(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.employeeList = response.data;
                         console.log(response.data)
                    }
                    else {
                         console.log(response.data)
                    }

               }
          },

          //  so hang của danh sach danh muc
          get_rows(list) {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return list.slice(start, end);

          },

          // So trang cua danh sach danh muc
          num_pages(list) {
               return Math.ceil(list.length / this.elementsPerPage);
          },

          async change_page(page, list) {
               if (page == '-' && this.currentPage > 1) {
                    this.currentPage -= 1;
                    this.get_rows(list);
               }
               else if (page == '+' && this.currentPage < this.num_pages(list)) {
                    this.currentPage += 1;
                    this.get_rows(list);
               }
               else {
                    this.currentPage = page;
                    this.get_rows(list);
               }
          },

     },

     mounted() {
          this.retrieveEmployeeList()
     },
}
</script>
   
<style>
@import url(../../assets/employeeStyle.css);
</style>
   

