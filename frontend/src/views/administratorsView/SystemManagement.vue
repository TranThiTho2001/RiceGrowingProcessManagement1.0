<template>
  <button @click="goToEmployeeManager()">Quản trị người dùng</button>

</template>
   
<script>

import employeeService from '../../services/employee.service';
export default {
  name: "SystemManagement",
  components: {

  },
  data() {
    return {
      employee: [],
      random: "",
    }
  },

  methods: {
    async retrieveEmployee() {
      const [err, respone] = await this.handle(
        employeeService.getAll()
      );
      if (err) {
        console.log(err)
      }
      else {
        this.employee = respone.data;
      }
    },

    async goToEmployeeManager(){
      this.$router.push('/EmployeeManager');
    }
  },
  mounted() {
    this.retrieveEmployee();
   this.random= Math.random().toString(36).slice(5);
  },
}
</script>
   
<style>
#app {

}
</style>
   

