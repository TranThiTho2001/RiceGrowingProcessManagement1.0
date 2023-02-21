
<template>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <div class="container-fluid loginFrame">
    <div class="row loginForm">
      <div class="col-sm-6 leftForm">
        <div class="row mt-5">
          <div class="col-sm-5"></div>
          <div class="col-sm-7 iconFamer text-right">
            <img src="../images/Rice3.png" class="famerImage ">
          </div>
        </div>
      </div>
      <div class="col-sm-6 rightForm">
        <div class="row mt-5">
          <div class="col-sm-7 content">
            <div class="row mt-5">
              <Form @submit="signin()" :validation-schema="schema" v-slot="{ isSubmitting }" class="form container-fluid">
                <h1 class="title"  style="text-align: center; margin-bottom: 10%;">ĐĂNG NHẬP</h1>
                <div class="form-group text-left">
                  <label for="username" class="labelTitle">Tên tài khoản đăng nhập</label>
                  <Field name="username" type="text" class="form-control form-control-pass" placeholder="Nhập tên tài khoản đăng nhập"
                    v-model="employee.Employee_id" />
                  <ErrorMessage name="username" class="error-feedback" />

                </div>

                <div class="form-group text-left pl-3 pr-3" style="margin-top:10%">
                  <label for="password" class="labelTitle" style="margin-left: -10px;">Mật khẩu</label>
                  <div class="row passField">
                    <Field v-if="!isOpenPassword" name="password" type="password" class=" form-control col-md-10 "
                      placeholder="Nhập mật khẩu" v-model="employee.Employee_password" />
                    <Field v-if="employee.Employee_password == '' & isOpenPassword" name="password" type="text"
                      class="form-control col-md-10 ml-2" placeholder="Nhập mật khẩu" v-model="employee.Employee_password" />

                    <Field v-if="employee.Employee_password != '' & isOpenPassword" name="password" type="text"
                      class="form-control col-md-10" placeholder="{{employee.Employee_password}}"
                      v-model="employee.Employee_password" />

                    <span v-if="!isOpenPassword" class="btn far fa-eye btnHienMatKhau col-md-2"
                      @click="isOpenPassword = !isOpenPassword"></span>
                    <span v-else class="btn far fa-eye-slash btnAnMatKhau col-md-2"
                      @click="isOpenPassword = !isOpenPassword"></span>
                  </div>

                  <ErrorMessage name="password" class="error-feedback mt-1 mb-2" />
                </div>


                <p v-if="message" style=" color: red; text-align: center; font-size: 17px; margin-top: 4%;">
                  {{ message }}
                </p>

                <div class="form-group mt-3 btn-login ">
          
                  <button class="btn btn-sm btn-outline-secondary btn-block btnDangNhap" :disabled="isSubmitting"
                    :class="{ 'submitting': isSubmitting }">
                    <span v-show="loading" class="spinner-border spinner-border-sm"></span>
                    <span>Đăng Nhập</span>
                  </button>
                </div>
              </Form>
            </div>
            <img src="../images/Rice4.png" class="studentImage">
          </div>
          <div class="col-sm-5"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import EmployeeService from '../services/employee.service';

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
      password: yup.string().required("Mật khẩu phải có giá trị."),
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
      console.log(this.employee)
      const [err, respone] = await this.handle(
        EmployeeService.getAll()
      );
      if (err) {
        console.log(err)
      }
      else {
        // this.employee = respone.data;
        console.log(respone.data);
        console.log(this.currentUser.Employee_id);


      }
    },

    async signin() {
      const [error, data] = await this.handle(
        this.$store.dispatch("login", this.employee)
      );
      if (error) {
        console.log(error);
        this.loading = false;
        this.message = "Số điện thoại hoặc mật khẩu đăng nhập sai";
      } else {
        console.log("login thanh coong!!!")
        console.log(data);
        if (data.Role_id == "01") {
          this.$router.push("/SystemManagement");
        }

        else if (data.Role_id == "02") {
          this.$router.push("/HomePage");
        }

      }
    },


  },
  mounted() {
    this.employee.Employee_password = '';
    this.initEmployeeState();
    this.retrieveEmployee();
  },
}
</script>

<style>
@import url("../assets/LoginForm.css");
</style>
