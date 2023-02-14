<template>

    <div class="container-fluid createNewEmployeeFrame">
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8 col-sm-10">
                <CreateNewEmployeeForm :newEmployee="newEmployee" @addEmployee-submit="createEmployee"
                    :message1="message1" :message2="message2" />
            </div>
            <div class="col-md-2"></div>
        </div>
    </div>

</template>

<script>
import CreateNewEmployeeForm from '../../components/administratorsComponent/createNewEmployeeForm.vue';
import EmployeeService from '../../services/employee.service';
import moment from 'moment';

export default {
    name: "createNewEmployee",
    components: { CreateNewEmployeeForm },
    data() {
        return {
            newEmployee: {},
            message1: " ",
            message2: " ",
        };
    },
    methods: {
        async createEmployee(data) {
            this.message1 = "";
            this.message2 = "";
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
                EmployeeService.create(data)
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
                this.newEmployee = respone.data;
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
            }
        },

    },


}

</script>

<style>

</style>