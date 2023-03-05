  
<template>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <div class="container-fluid loginFrame">
    <div class="row background" style="position: fixed; width: 100%; z-index: -10;"> <!-- background-->
      <div class="col-sm-6 leftForm">
      </div>
      <div class="col-sm-6 rightForm">
      </div>
    </div>
    <div class="form-center">
      <div class="form-login">
        <img src="../images/Rice3.png" class="famerImage">
        <div class="row" style="height: 100%;">
          <div class="col-sm-6 iconFamer"> </div>
          <div class="col-sm-6 content ">
            <Form @submit="signin()" :validation-schema="schema" v-slot="{ isSubmitting }" class="form container-fluid mt-5">
              <h1 class="title" style="text-align: center; margin-bottom: 10%;">ĐĂNG NHẬP</h1>
              <div class="form-group text-left ml-2" style="width: 97%;">
                <label for="username" class="labelTitle">Tên tài khoản</label>
                <Field name="username" type="text" class="form-control" placeholder="Nhập tên tài khoản đăng nhập"
                  v-model="employee.Employee_id" />
                <ErrorMessage name="username" class="error-feedback" />

              </div>

              <div class="form-group text-left ml-4 pr-3" style="margin-top:10%">
                <label for="password" class="labelTitle" style="margin-left: -10px;">Mật khẩu</label>
                <div class="row passField">
                  <Field v-if="!isOpenPassword" name="password" type="password" class=" form-control "
                    placeholder="Nhập mật khẩu" v-model="employee.Employee_password" />
                  <Field v-if="employee.Employee_password == '' & isOpenPassword" name="password" type="text"
                    class="form-control " placeholder="Nhập mật khẩu" v-model="employee.Employee_password" />

                  <Field v-if="employee.Employee_password != '' & isOpenPassword" name="password" type="text"
                    class="form-control " placeholder="{{employee.Employee_password}}"
                    v-model="employee.Employee_password" />

                  <span v-if="!isOpenPassword" class="btn far fa-eye btnHienMatKhau "
                    @click="isOpenPassword = !isOpenPassword"></span>
                  <span v-else class="btn far fa-eye-slash btnAnMatKhau "
                    @click="isOpenPassword = !isOpenPassword"></span>
                </div>

                <ErrorMessage name="password" class="error-feedback mt-1 mb-2" />
              </div>


              <p v-if="message" style=" color: red; text-align: center; font-size: 17px; margin-top: 4%;">
                {{ message }}
              </p>

              <div class="form-group mt-2 btn-login ">
                <button class="btn btnDangNhap" :disabled="isSubmitting"
                  :class="{ 'submitting': isSubmitting }">
                  <span v-show="loading" class="spinner-border spinner-border-sm"></span>
                  <span>Đăng Nhập</span>
                </button>
              </div>
            </Form>
            <img src="../images/Rice4.png" class="studentImage">
          </div>
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
    // this.retrieveEmployee();
    // this.getAPI();
  },
}
</script>

<style>
@import url("../assets/LoginForm.css");
</style>
