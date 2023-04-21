<template>

     <div class="container-fluid createNewEmployeeFrame">
          <div class="row">
               <div class="col-md-2"></div>
               <div class="col-md-8 col-sm-10">
                    <UpdateEmployeeForm :newEmployee="newEmployee" @updateEmployee-submit="updateEmployee"
                         :message1="message1" :message2="message2" />
               </div>
               <div class="col-md-2"></div>
          </div>
     </div>

</template>

<script>
import UpdateEmployeeForm from '../../components/administratorsComponent/updateEmployeeForm.vue';
import EmployeeService from '../../services/employee.service';
import moment from 'moment';

export default {
     name: "createNewEmployee",
     components: { UpdateEmployeeForm },
     data() {
          return {
               newEmployee: {},
               message1: " ",
               message2: " ",
          };
     },

     created() {
          this.newEmployee.Employee_id = this.$route.params.id;
     },

     methods: {
          async retrieveEmployee() {
               const [err, respone] = await this.handle(
                    EmployeeService.get(this.newEmployee.Employee_id)
               );
               if (err) {
                    console.log(err)
               }
               else {
                    this.newEmployee.Employee_id = respone.data.Employee_id;
                    this.newEmployee.Employee_name = respone.data.Employee_name;
                    this.newEmployee.Employee_major = respone.data.Employee_major;
                    this.newEmployee.Employee_password = "";
                    this.newEmployee.Employee_sex = respone.data.Employee_sex;
                    this.newEmployee.Employee_birthDate = respone.data.Employee_birthDate;
                    this.newEmployee.Employee_address = respone.data.Employee_address;
                    this.newEmployee.Role_id = respone.data.Role_id;
                    this.newEmployee.Employee_email = respone.data.Employee_email;
                    this.newEmployee.Employee_phoneNumber = respone.data.Employee_phoneNumber;
                    this.newEmployee.Employee_identityCardNumber = respone.data.Employee_identityCardNumber;
                    this.newEmployee.Employee_birthdate = respone.data.Employee_birthDate;
                    console.log(respone.data);
               }
          },

          async updateEmployee(data) {
               this.newEmployee.Employee_id = data.Employee_id;
               this.newEmployee.Employee_name = data.Employee_name;
               this.newEmployee.Employee_major = data.Employee_major;
               this.newEmployee.Employee_password = data.Employee_password;
               this.newEmployee.Employee_sex = data.Employee_sex;
               this.newEmployee.Employee_birthDate = data.Employee_birthdate;
               this.newEmployee.Employee_address = data.Employee_address;
               this.newEmployee.Role_id = data.Role_id;
               this.newEmployee.Employee_email = data.Employee_email;
               this.newEmployee.Employee_phoneNumber = data.Employee_phoneNumber;
               this.newEmployee.Employee_identityCardNumber = data.Employee_identityCardNumber;

               if (this.newEmployee.Role_id == "Quản lý" || this.newEmployee.Role_id == "01") {
                    this.newEmployee.Role_id = "01";
               }
               else if (this.newEmployee.Role_id == "Chuyên gia" || this.newEmployee.Role_id == "02") {
                    this.newEmployee.Role_id = "02";
               }
               else {
                    this.newEmployee.Role_id = "03";
               }

               if (this.newEmployee.Employee_sex == true || this.newEmployee.Employee_sex == "Nam") {
                    this.newEmployee.Employee_sex = "Nam";
               }
               else {
                    this.newEmployee.Employee_sex = "Nữ";
               }
               data.Employee_birthdate = (moment(String(data.Employee_birthdate)).format("YYYY-MM-DD")).slice(0, 10);
               this.newEmployee.Employee_birthDate = data.Employee_birthdate;
               const [error, response] = await this.handle(
                    EmployeeService.update(data.Employee_id, this.newEmployee)
               );
               if (error) {
                    console.log(error);
               } else if (response.data == "Đã xảy ra lỗi!!!") {
                    this.message1 = "Cập nhật không thành công."
               } else {
                    this.message2 = "Cập nhật thành công.";
                    this.newEmployee = response.data;
               }
          },

     },

     mounted() {
          this.retrieveEmployee();

     }
}

</script>

<style>

</style>