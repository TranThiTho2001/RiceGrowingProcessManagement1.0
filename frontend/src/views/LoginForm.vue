  
<template>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <div class="container-fluid loginFrame">
    <div class="row background" style="position: fixed; width: 100%; z-index: -10;"> <!-- background-->
      <div class="leftForm">
      </div>
      <div class="rightForm">
      </div>
    </div>
    <div class="form-center">
      <div class="form-login">
        <img src="../images/Rice3.png" class="img-fluid famerImage ">
        <div class="row" style="height: 100%;">
          <div class="iconFamer"> </div>
          <div class="content_loginForm ">
            <Form @submit="signin()" :validation-schema="schema" v-slot="{ isSubmitting }" class="container-fluid mt-5">
              <h1 class="title" style="text-align: center; margin-bottom: 10%;">ĐĂNG NHẬP</h1>
              <div class="form-group text-left ml-2" style="width: 97%;">
                <label for="username" class="labelTitle">Tên tài khoản</label>
                <Field name="username" type="text" class="form-control" placeholder="Nhập tên tài khoản"
                  v-model="employee.Employee_id" />
                <ErrorMessage name="username" class="error-feedback" />

              </div>

              <div class="form-group text-left ml-4 pr-2" style="margin-top:10%">
                <label for="password" class="labelTitle" style="margin-left: 7%;">Mật khẩu</label>
                <div class="row passField">
                  <Field v-if="!isOpenPassword" name="password" type="password" class="form-control "
                    placeholder="Nhập mật khẩu" v-model="employee.Employee_password" />
                  <Field v-if="employee.Employee_password == '' & isOpenPassword" name="password" type="text"
                    class="form-control " placeholder="Nhập mật khẩu" v-model="employee.Employee_password" />

                  <Field v-if="employee.Employee_password != '' & isOpenPassword" name="password" type="text"
                    class="form-control " placeholder="{{employee.Employee_password}}"
                    v-model="employee.Employee_password" />

                  <span v-if="!isOpenPassword" class="btn far fa-eye btnShowPassword"
                    @click="isOpenPassword = !isOpenPassword"></span>
                  <span v-else class="btn far fa-eye-slash btnHidePassword "
                    @click="isOpenPassword = !isOpenPassword"></span>
                    
                </div>
                <ErrorMessage name="password" class="error-feedback mt-1 mb-2" />
              </div>


              <div class="row text-center ml-4 pl-1" v-if="message"
                style=" color: red; text-align: center; font-size: 17px; margin-top: 4%;">
                {{ message }}
              </div>

              <div class="row ml-2 mb-5" style="width: 100%;">
                <div class="col-lg-12 text-center mt-4">
                  <button class="btn btnLogin" :disabled="isSubmitting" :class="{ 'submitting': isSubmitting }">
                    <span v-show="loading" class="spinner-border spinner-border-sm"></span>
                    <span>Đăng Nhập</span>
                  </button>
                </div>

              </div>
            </Form>
            <img src="../images/Rice4.png" class="img-fluid studentImage">
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>

import EmployeeService from '../services/employee.service';
import predictionService from '@/services/prediction.service';
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
import { mapGetters, mapMutations } from "vuex";

// import * as yup from "yup";
export default {
  name: 'LoginForm',
  components: {
    Form, Field, ErrorMessage
  },
  data() {
    const schema = yup.object().shape({
      username: yup.string().required("Tên tài khoản phải có giá trị."),
      // password: yup.string().required("Mật khẩu phải có giá trị."),
    });
    return {
      employee: {},
      loading: false,
      message: "",
      schema,
      isOpenPassword: false,
    }
  },
  computed: {
    ...mapGetters({
      currentUser: "loggedInEmployee",
    }),
  },
  created() {
    if (this.employeeLoggedIn) {
      console.log(this.currentUser);
      this.$router.push("/SystemManagement");
    }
  },


  methods: {
    // ----------------------------------------------------------------------Employee---------------------------------
    ...mapMutations([
      "initEmployeeState"
    ]),

    async retrieveEmployee() {
      const [err, respone] = await this.handle(
        EmployeeService.getAll()
      );
      if (err) {
        console.log(err)
      }
      else {
        console.log(respone.data);
        console.log(this.currentUser.Employee_id);
      }
    },

    async prediction() {

      const [err, respone] = await this.handle(
        predictionService.create("RCI0000001")
      );
      if (err) {
        console.log(err)
      }
      else {
        console.log(respone.data);
      }
    },
    async signin() {
      const [error, data] = await this.handle(
        this.$store.dispatch("login", this.employee)
      );
      if (error) {
        console.log(error);
        this.loading = false;
        this.message = "Tên tài khoản hoặc mật khẩu đăng nhập sai";
      } else {
        if (data.Role_id == "01") {
          this.$router.push("/EmployeeManager");
        }
        else if (data.Role_id == "02" || data.Role_id == "03") {
          this.$router.push("/Monitor");
        }

      }
    },




  },
  mounted() {
    this.employee.Employee_password = '';
    this.initEmployeeState();
  },
}
</script>

<style>
@import url("../assets/LoginForm.css");
</style>
