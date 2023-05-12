<template>
     <div class="EmployeeManagerFrame container-fluid pr-4" style="background-color: #EAEAEA;height: max-content;">
          <div class="row" v-if="loading" style="height: max-content; min-height: 100vh; background-color: #FFFFFF">
               <Preloader color="red" scale="0.4" />
          </div>

          <div v-if="!loading" class="row EmployeeManager" style="height: 100vmin;">
               <button v-if="openMenu.isOpenMenuIcon" class="fas fa-bars iconmenu2"
                    @click="openMenu.openMenu = true, openMenu.isCloseMenu = true, openMenu.isOpenMenuIcon = false"></button>
               <button v-if="openMenu.isCloseMenu" class="fas fa-bars iconmenu1"
                    @click="openMenu.openMenu = false, openMenu.isCloseMenu = false, openMenu.isOpenMenuIcon = true"></button>
               <div class="left" :class="{ navbarresponsive: openMenu.openMenu }">
                    <Catalog />
               </div>

               <div class="right rightEmployeeManager">
                    <div class="mb-4  pt-2 topRight" style="margin-left: 20px; margin-right: 10px;">
                         <div class="nameclass" style="min-height:60px; width: max-content;">
                              <h3 class="name" :class="{ name2: isOpenInput2 }" style="font">Quản trị người dùng</h3>
                         </div>
                         <div class="text-right mt-3">
                              <div class="row">
                                   <TopHeader />
                              </div>
                         </div>
                    </div>

                    <div class="row row-inputSearch">
                         <input type="text" class="form-control inputSearch1" placeholder="Tìm" v-model="nameToSearch"
                              @click="retrieveEmployeeList, isOpenInput1 = true"
                              @keyup.enter="searchName(nameToSearch), away()"
                              @focusin="isOpenSearch.open = !isOpenSearch.open, isOpenSearch.close = !isOpenSearch.close" />
                         <button class="btnSearch1" @click="searchName(nameToSearch), away()">
                              <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
                         </button>

                         <div :class="{ openSearch: isOpenSearch.open, closeSearch: isOpenSearch.close }">
                              <p class="item" v-for="employee in filteredList()" :key="employee.Employee_id"
                                   @click="searchName(employee.Employee_name)">
                                   {{ employee.Employee_name }}</p>
                         </div>

                         <div class="selection-component1">
                              <label class="labelRole">Vị trí</label>
                              <select class="selectRole" v-model="filter.role" @change="searchByRole()">
                                   <option class="optionRole" v-for="role in roles" :value="role" :key="role">{{ role }}
                                   </option>
                              </select>

                              <label class="labelSex">Giới tính</label>
                              <select class="selectSex" v-model="filter.sex" @change="searchBySex()">
                                   <option class="optionSex" value="Tất cả" selected="true">Tất cả</option>
                                   <option class="optionSex" value="Nữ">Nữ</option>
                                   <option class="optionSex" value="Nam">Nam</option>
                              </select>
                         </div>

                         <button class="btn btnCreate"
                              @click="isOpenCreateEmployeeForm = !isOpenCreateEmployeeForm, retrieveRoleList()">
                              <i class="fas fa-plus-circle" style="font-size: 15px;"></i> Thêm nhân viên
                         </button>
                    </div>

                    <div class="scrollTable">
                         <div class="scrollTable-content">
                              <table class="table employeeList">
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
                                        <tr v-for="(employee, i ) in (employeeList)" :key="i">
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
                                                            @click="setEmployeeChoosen(employee), retrieveRoleList(), isOpenUpdateEmployeeForm = !isOpenUpdateEmployeeForm">
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
                    </div>

                    <div class="overlay2" v-if="isOpenCreateEmployeeForm">
                         <CreateNewEmployeeForm :newEmployee="newEmployee" :roleList="roleList"
                              @addEmployee-submit="createEmployee" :message1="message1" :message2="message2" />
                    </div>

                    <div class="overlay2" v-if="isOpenUpdateEmployeeForm">
                         <UpdateEmployeeForm :newEmployee="employeeChoosen" :roleList="roleList"
                              @updateEmployee-submit="updateEmployee" :message1="message1" :message2="message2" />
                    </div>
               </div>
          </div>

          <!-- ------------------------------confirm ----------------------------- -->
          <div class="overlay2" v-if="isOpenXacNhan">
               <div class="confirmationDialog">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelXacNhan">
                         <span class="fas fa-trash-alt" style="color:red"></span> Bạn chắc chắn muốn xóa?
                    </p>
                    <button class="btnYes btn btn-sm btn-outline-secondary pl-3 pr-3"
                         @click="isOpenXacNhan = !isOpenXacNhan, isOpenThongBao = !isOpenThongBao, deleteEmployee(employeeChoosen.Employee_id)">Xóa</button>
                    <button class="btnNo btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenXacNhan = !isOpenXacNhan">Hủy</button>
               </div>
          </div>

          <div class="overlay2" v-if="isOpenThongBao">
               <div class="messageDialog">
                    <p style="color:#515151; text-align:center; margin-top: 50px; font-size: 20px;" class="labelThongBao">
                         <span class="fas fa-check-circle" style="color:#00BA13; text-align: center;"></span> {{ message }}
                    </p>
                    <button class="btnOK btn btn-sm btn-outline-secondary pl-3 pr-3 ml-4"
                         @click="isOpenThongBao = !isOpenThongBao">OK</button>
               </div>
          </div>
     </div>
     <div v-if="isOpenSearch.open || isOpenInput2" class="outside" @click.passive="away()"></div>
</template>
   
<script>

import moment from 'moment';
import { mapGetters, mapMutations } from "vuex";
import roleService from '@/services/role.service';
import employeeService from '../../services/employee.service';
import Preloader from '@/components/catalogManagementComponents/Preloader.vue';
import Catalog from '../../components/catalogManagementComponents/catalog.vue';
import TopHeader from '@/components/catalogManagementComponents/topHeader.vue';
import UpdateEmployeeForm from '../../components/administratorsComponent/updateEmployeeForm.vue';
import CreateNewEmployeeForm from '../../components/administratorsComponent/createNewEmployeeForm.vue';

export default {
     name: 'EmployeeManager',
     components: {
          Catalog,
          TopHeader,
          CreateNewEmployeeForm,
          UpdateEmployeeForm,
          Preloader,
     },
     data() {
          return {
               employeeList: [],
               isOpenXacNhan: false,
               isOpenThongBao: false,
               message: "",
               employeeChoosen: {},
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
               isOpenInput2: false,
               isOpenInput1: false,
               openMenu: {
                    openMenu: false,
                    isOpenMenuIcon: true,
                    isCloseMenu: false,
               },
               newEmployeeId: '',
               roleList: [],
               filter: {},
               roles: [],
               loading: false,
          }
     },

     computed: {
          ...mapGetters({
               currentUser: "loggedInEmployee",
          }),

     },

     created() {
          this.initEmployeeState();
          this.retrieveRoleList();
          this.filter.role = "Tất cả";
          this.filter.sex = "Tất cả"
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
               this.isOpenInput1 = false;
               this.isOpenInput2 = false;
          },

          async retrieveRoleList() {
               const [err, respone] = await this.handle(
                    roleService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.roleList = respone.data;
                    this.getRole();
               }
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
                         this.newEmployeeId = "EE00000" + String(Number(id) + 1);
                    }
                    else if (id >= 9 && id < 99) {
                         this.newEmployee.Employee_id = "EE0000" + String(Number(id) + 1);
                         this.newEmployeeId = "EE0000" + String(Number(id) + 1);
                    }
                    else if (id >= 99 && id < 999) {
                         this.newEmployee.Employee_id = "EE000" + String(Number(id) + 1);
                         this.newEmployeeId = "EE000" + String(Number(id) + 1);
                    }
                    else {
                         this.newEmployee.Employee_id = "EE00" + String(Number(id) + 1);
                         this.newEmployeeId = "EE00" + String(Number(id) + 1);
                    }

                    var randomstring = Math.random().toString(36).slice(-8);
                    this.newEmployee.Employee_password = randomstring;
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
                         this.newEmployee.Employee_id = this.newEmployeeId;
                    this.newEmployee.Employee_password = Math.random().toString(36).slice(-8);
                    this.isOpenCreateEmployeeForm = false;
               }
               else {
                    this.roleList.forEach(role => {
                         if (role.Role_name == data.Role_name) {
                              data.Role_id = role.Role_id
                         }
                    });

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
                         this.newEmployee = {};
                         this.retrieveEmployeeList();
                    }
               }
          },

          async updateEmployee(data) {
               this.message1 = "";
               this.message2 = "";
               if (data.close == false) {
                    this.isOpenUpdateEmployeeForm = false;
                    this.newEmployee = {};
                    this.newEmployee.Employee_id = this.newEmployeeId;
               }
               else {
                    this.roleList.forEach(role => {
                         if (role.Role_name == data.Role_name) {
                              data.Role_id = role.Role_id
                         }
                    });

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
                    this.message = respone.data;
                    this.retrieveEmployeeList();
               }
          },

          async searchName(data) {
               this.nameToSearch = data;
               if (this.nameToSearch != '') {
                    this.employeeList = [];
                    this.cloneEmployeeList.forEach(element => {
                         if (element.Employee_name == data) {
                              this.employeeList.push(element);
                         }
                    });
                    if (this.employeeList.length == 0) {
                         const [error, response] = await this.handle(
                              employeeService.findByNameofAll(this.nameToSearch));
                         if (error) {
                              console.log(error);
                         } else {
                              if (response.data != null) {
                                   this.employeeList = response.data;
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

          async searchByRole() {
               if (this.filter.role == "Tất cả") {
                    this.employeeList = [];
                    this.employeeList = this.cloneEmployeeList;
               }
               else {
                    this.employeeList = [];
                    this.cloneEmployeeList.forEach(employee => {
                         if (employee.Role_name == this.filter.role) {
                              this.employeeList.push(employee);
                         }
                    });
               }
          },

          async searchBySex() {
               if (this.filter.sex == "Tất cả" && this.filter.role == "Tất cả") {
                    this.employeeList = [];
                    this.employeeList = this.cloneEmployeeList;
               }
               else if (this.filter.sex == "Tất cả" && this.filter.role != "") {
                    this.employeeList = [];
                    this.cloneEmployeeList.forEach(employee => {
                         if (employee.Role_name == this.filter.role) {
                              this.employeeList.push(employee);
                         }
                    });
               }
               else if (this.filter.sex != "Tất cả" && this.filter.role == "Tất cả") {
                    this.employeeList = [];
                    this.cloneEmployeeList.forEach(employee => {
                         if (employee.Employee_sex == this.filter.sex) {
                              this.employeeList.push(employee);
                         }
                    });
               }
               else {
                    this.employeeList = [];
                    this.cloneEmployeeList.forEach(employee => {
                         if (employee.Employee_sex == this.filter.sex && employee.Role_name == this.filter.role) {
                              this.employeeList.push(employee);
                         }
                    });
               }
          },

          async getRole() {
               if (this.roleList.length > 0) {
                    this.roles = [];
                    this.roles[0] = "Tất cả";
                    this.roleList.forEach(role => {
                         this.roles.push(role.Role_name);
                    });
               }
               else {
                    this.retrieveRoleList();
                    this.roles = [];
                    this.roles[0] = "Tất cả";
                    this.roleList.forEach(role => {
                         this.roles.push(role.Role_name);
                    });
               }
               return this.roles;
          }
     },

     mounted() {
          this.retrieveEmployeeList();
     },
}
</script>
   
<style>
@import url(../../assets/employeeStyle.css);
@import url(../../assets/mainStyle.css);

.EmployeeManagerFrame .dropdown-item:focus,
.EmployeeManagerFrame .dropdown-item:hover {
     background-color: #ABD2C8;
}

.EmployeeManagerFrame .navigationBar .btnEmployee {
     display: block;
     width: 88%;
     font-size: 17px;
     background: #FFFA37;
     box-shadow: 4px 4px 2px rgba(0, 0, 0, 0.25);
     border-radius: 20px;
     color: #5C5D22;
     border: none;
     font-family: 'Roboto';
     font-style: normal;
     border-radius: 14px;
}
</style>
   

