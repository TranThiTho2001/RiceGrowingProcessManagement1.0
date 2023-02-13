<template>

    <div class="container-fluid createNewEmployeeFrame">
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8 col-sm-10">
                <CreateNewEmployeeForm :newEmployee="newEmployee" @addEmployee-submit="craeteEmployee"
                    :message1="message1" :message2="message1" />
            </div>
            <div class="col-md-2"></div>
        </div>
    </div>

</template>

<script>
import CreateNewEmployeeForm from '../../components/createNewEmployeeForm.vue';
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
        async craeteEmployee(data) {
            console.log("lahsjba")
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
            const [error, response] = await this.handle(
                EmployeeService.create(data)
            );
            if (error) {
                console.log(error);
            } else {
                console.log(response.data);
                this.message2 = "Thêm thành công";
            }
        },

    },


}

</script>

<style>

</style>