<template>
     <div class="EmployeeManagerFrame container">
          <div class="row">
               <div class="col-sm-2">
                    <button @click="goToCreateNewEmployee()">Tạo mới</button>
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
                         <tr v-for="(employee, i) in employeeList" :key="i">
                              <td>{{ employee.Employee_id }}</td>
                              <td>{{ employee.Employee_name }}</td>
                              <td>{{ employee.Employee_phoneNumber }}</td>
                              <td>{{ employee.Employee_major }}</td>
                              <td>{{ employee.Role_name }}</td>
                              <td>
                                   <tr class="actions">
                                        <td @click="goToUpdateEmployee(employee.Employee_id)"><span class="fas fa-edit"></span></td>
                                        <td><span class="fas fa-trash-alt"></span></td>
                                   </tr>
                              </td>
                         </tr>
                    </tbody>
               </table>
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

          async goToCreateNewEmployee(){
               this.$router.push("/CreateNewEmployee");
          },

          async goToUpdateEmployee(employeeId){
               this.$router.push({ name: 'UpdateEmployee', params: { id: employeeId }} )
          }

          
     },

     mounted() {
          this.retrieveEmployeeList()
     },
}
</script>
   
<style>
#app {
     font-family: Avenir, Helvetica, Arial, sans-serif;
     -webkit-font-smoothing: antialiased;
     -moz-osx-font-smoothing: grayscale;
     text-align: center;
     color: #2c3e50;
     margin-top: 60px;
}
</style>
   

