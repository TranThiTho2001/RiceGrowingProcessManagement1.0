<template>
  <div id="app">

    <router-view />
  </div>
</template>
   
<script>
import { mapGetters, mapMutations } from "vuex";
export default {
  name: 'App',
  data() {
    return {
      //  currentUser: null
    };
  },
  computed: {
    ...mapGetters({
      currentUser: "loggedInEmployee",
    }),

  },
  methods: {
    ...mapMutations([
      "initEmployeeState"
    ]),
  },
  created() {
    this.initEmployeeState();
  },
}
</script> 
   

<style> #app {
   max-width: 100%;
 }
 .content .error-feedback {
      color: red;
      float: right;
 }

.content .form-group label,
.content .form-group label {
      float: left;
      font-family: 'Roboto';
      font-style: normal;
      font-weight: 600;
      font-size: 18px;
 }
 .content .form-group .selectBox,
 .content .form-group .selectBox {
      width: 100%;
      height: 38px;
      border: 1px solid #ced4da;
      border-radius: 4px;
 }
.content .form-group input,
 .content .form-group input {
      float: left;
 }

.content .form-group .form-control,
.content .form-group .form-control {
      background-color: #FAFAFC;
      box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
      font-size: 17px;
      border-radius: 10px;
      color: #2F3033;
      font-family: 'Roboto';
      font-style: normal;
      font-weight: 500;
      height: 35px;
      vertical-align: middle;
 }

 .functionName,
 .functionName {
      font-family: 'Roboto';
      font-size: 24px;
 }

.form-group .textMessage1,
 .form-group .textMessage2 {
      text-align: center;
      display: inline;
      font-size: 18px;
      font-family: 'Roboto';
 }

 .btnLuu,
 .btnLuu {
      background-color: rgb(4, 105, 4);
      color: #f0f0f0;
      font-size: 20px;
      text-align: center;
 }
</style>   
