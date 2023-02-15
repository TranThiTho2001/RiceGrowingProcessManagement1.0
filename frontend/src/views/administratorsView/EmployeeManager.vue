<template>
     <div class="EmployeeManagerFrame container">
          <div class="row">
               <div class="col-sm-2">
                    <button @click="goToCreateNewEmployee()">Tạo mới</button>
               </div>
          </div>
          <div class="row" style="width: 100%;" v-if="!isOpenChoosePage && employeeList.length > 3">
               <div class="btnChoosePage">
                    <p style="display: inline-block; padding-top: 4px;text-align: right;" class="soTrang">Trang &nbsp;
                    </p>
                    <div class="numberPage">
                         <div class="dropdown">
                              <button class="dropbtn">{{ currentPage }}
                                   <span class="fas fa-chevron-down"></span></button>
                              <div class="dropdown-content">
                                   <a class="dropdown-item" v-for="(i, j) in num_pages() " :key="j"
                                        v-bind:class="[i == currentPage ? 'active' : '']" v-on:click="change_page(i)"
                                        aria-controls="my-table"> {{ i }}</a>
                              </div>
                         </div>
                    </div>
               </div>
          </div>
          <div class=" row employeeList">
               <table class="table">
                    <thead>
                         <tr>
                              <th>Mã</th>
                              <th>Họ và Tên</th>
                              <th>Số điện thoại</th>
                              <th>Chuyên môn</th>
                              <th>Vai trò</th>
                              <th>Tùy chọn</th>
                         </tr>
                    </thead>
                    <tbody>
                         <tr v-for="(employee, i ) in get_rows()" :key="i">
                              <td>{{ employee.Employee_id }}</td>
                              <td>{{ employee.Employee_name }}</td>
                              <td>{{ employee.Employee_phoneNumber }}</td>
                              <td>{{ employee.Employee_major }}</td>
                              <td>{{ employee.Role_name }}</td>
                              <td>
                                   <tr class="actions" style="border: none;">
                                        <td @click="goToUpdateEmployee(employee.Employee_id)"><span class="fas fa-edit"></span>
                                        </td>
                                        <td @click="setEmployeeChoosen(employee), isOpenXacNhan = !isOpenXacNhan"><span
                                             class="fas fa-trash-alt"></span></td>
                                   </tr>
                              </td>
                         </tr>
                    </tbody>
               </table>
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
export default {
     name: 'EmployeeManager',
     components: {

     },
     data() {
          return {
               employeeList: [],
               isOpenXacNhan: false,
               isOpenThongBao: false,
               message: "",
               employeeChoosen: {},
               currentPage: 1,
               elementsPerPage: 3,
               ascending: false,
          }
     },

     methods: {
          async retrieveEmployeeList() {
               const [err, respone] = await this.handle(
                    employeeService.getAll()
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.employeeList = respone.data;
                    console.log(respone.data);
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

          //  so hang của danh sach danh muc
          get_rows() {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage;
               return this.employeeList.slice(start, end);
          },

          // So trang cua danh sach danh muc
          num_pages() {
               return Math.ceil(this.employeeList.length / this.elementsPerPage);

          },

          async change_page(page) {
               this.currentPage = page;
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
   

