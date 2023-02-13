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
        console.log(respone.data);
        console.log("alomalo")
      }
    },

    async goToEmployeeManager(){
      this.$router.push('/EmployeeManager');
    }
  },
  mounted() {
    this.retrieveEmployee();
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
   

