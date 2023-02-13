<template>
     
     <HelloWorld msg="Welcome to Your Vue.js App" />
   </template>
   
   <script>
   import HelloWorld from '../../components/HelloWorld.vue'
   import employeeService from '../../services/employee.service';
   export default {
     name: 'App',
     components: {
       HelloWorld
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
         }
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
   

