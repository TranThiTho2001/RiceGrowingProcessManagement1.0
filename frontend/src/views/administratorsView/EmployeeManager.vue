<template>
     <div class="EmployeeManagerFrame container-fluid">
          <div class="row EmployeeManager">
               <div class="col-sm-2">
                    <div class="row">
                         <Catalog />
                    </div>
               </div>

               <div class="col-sm-10 rightEmployeeManager">
                    <div class="row ml-2 pt-3 mb-5 pb-1 mr-2 topRight">
                         <div class="col-md-2">
                              <h3 class="name">Nhân viên</h3>
                         </div>
                         <div class="col-md-8">
                              <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                                   @click="retrieveEmployeeList()" @keyup.enter="searchName(nameToSearch)"
                                   @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                              <button class="btnSearch1" @click="searchName(nameToSearch)"
                                   v-if="nameToSearch == '' && !isOpenSearch.open">
                                   <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                              </button>
                              <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                                   <p class="item" v-for="employee in filteredList()" :key="employee.Employee_id"
                                        @click="searchName(employee.Employee_name)">
                                        {{ employee.Employee_name }}</p>
                              </div>
                         </div>

                         <div class="col-md-2 text-right">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row  ml-2 mr-2 mt-4 pt-3 pb-3">
                         <div class="col-sm-12 text-right">
                              <button class="btnCreate pt-1 pb-1"
                                   @click="isOpenCreateEmployeeForm = !isOpenCreateEmployeeForm">
                                   <i class="fas fa-plus-circle"></i>Thêm Nhân Viên</button>
                         </div>
                    </div>

                    <div class="row employeeList  ml-2 mr-2 justify-content-center">
                         <table class="table mt-4 ml-2 mr-2">
                              <thead>
                                   <tr>
                                        <th class="text-center">STT</th>
                                        <th class="text-center">Mã</th>
                                        <th>Họ và Tên</th>
                                        <th>Số điện thoại</th>
                                        <th>Chuyên môn</th>
                                        <th>Vai trò</th>
                                        <th></th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="(employee, i ) in get_rows(employeeList)" :key="i">
                                        <td class="text-center" v-if="currentPage > 1">{{ i + ((currentPage - 1) *
                                             elementsPerPage) + 1 }}
                                        </td>
                                        <td class="text-center" v-else>{{ i + 1 }}</td>
                                        <td class="text-center">{{ employee.Employee_id }}</td>
                                        <td>{{ employee.Employee_name }}</td>
                                        <td>{{ employee.Employee_phoneNumber }}</td>
                                        <td>{{ employee.Employee_major }}</td>
                                        <td>{{ employee.Role_name }}</td>
                                        <td class="">
                                             <button type="button" class="btn btn-sm btnMore" data-toggle="dropdown"
                                                  aria-haspopup="true" aria-expanded="false">
                                                  <i class="fas fa-ellipsis-v"></i>
                                             </button>
                                             <div class="dropdown-menu">
                                                  <a class="dropdown-item action"
                                                       @click="setEmployeeChoosen(employee), isOpenUpdateEmployeeForm = !isOpenUpdateEmployeeForm">
                                                       <span class="fas fa-edit actionIcon"></span> Chỉnh sửa
                                                  </a>
                                                  <a class="dropdown-item" href="#"
                                                       @click="setEmployeeChoosen(employee), isOpenXacNhan = !isOpenXacNhan">
                                                       <span class="fas fa-trash-alt actionIcon"></span> Xóa
                                                  </a>
                                             </div>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </div>
                    <div class="row mt-2 ml-2 mr-2" style="display: flex; justify-content: center;">

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
     <div v-if="isOpenSearch.open" class="outside" @click.passive="away()"></div>
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
               cloneEmployeeList: [],
               nameToSearch: "",
               isOpenSearch: {
                    open: false,
                    close: true,
               },
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

          filteredList() {
               return this.cloneEmployeeList.filter(employee => {
                    return employee.Employee_name.toLowerCase().includes(this.nameToSearch.toLowerCase())
               })
          },

          away() {
               this.isOpenSearch.open = false;
               this.isOpenSearch.close = true;
          },

          async retrieveEmployeeList() {
               const [err, respone] = await this.handle(
                    employeeService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.employeeList = respone.data;
                    this.cloneEmployeeList = respone.data;
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

          async searchName(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != '') {
                    this.employeeList = [];
                    this.employeeList.forEach(element => {
                         if (element.Employee_name == data) {
                              this.employeeList.push(element);
                         }
                    });
                    if (this.employeeList.length == 0) {
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
                    }
               }
               else {
                    this.retrieveEmployeeList();
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

nav {
     position: absolute;
     display: inline !important;
}

nav .pagination .active .page-link {
     background: #ABD2C8 !important;
     border: 1px solid #FAFAFC !important;
     box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25) !important;
     border-radius: 15px !important;
     margin-left: 10px !important;
     margin-right: 10px !important;
     color: #FFFED8 !important;

     text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     /* width: 40px !important; */
}

nav .pagination .page-item .page-link {
     color: #6D6E73;
     border: none;
     text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 700;
     background-color: #EAEAEA;
     font-size: 20px;
     z-index: -2;
}
</style>
   

