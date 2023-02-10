
<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <button @click="add()">Them </button>
  <button @click="update()">cap nhat</button>
  <button @click="findbyname()">Tim theo ten</button>
  <button @click="change()">mat khau</button>
  <button @click="signin()">Đang nhap</button>
</template>

<script>

import RoleService from './services/role.service';
import CropService from './services/crop.service';
import SeedService from './services/seed.service';
import SoilService from './services/soil.service';
import MonitorService from './services/monitor.service';
import EpidemicService from './services/epidemic.service';
import EmployeeService from './services/employee.service';
import PesticideService from './services/pesticide.service';
import FertilizerService from './services/fertilizer.service';
import ArableLandService from './services/arableLand.service';
import EpidemicTimesService from './services/epidemicTimes.service';
import OtherActivitiesService from './services/otherActivities.service';
import ActivityDetailsService from './services/activityDetails.service';
import DevelopmentStageService from './services/developmentStage.service';
import RiceCropInformationService from './services/riceCropInformation.service';
import EpidemicsClassificationService from './services/epidemicsClassification.service';

import { mapGetters, mapMutations } from "vuex";
// import * as yup from "yup";
export default {
  name: 'App',
  components: {
  },
  data() {
    return {
      employeelist: [],
      newemployee: {},
      employeeid: {},
      role: [],
      employee: {}
    }
  },
  computed: {
    ...mapGetters({
      currentUser: "loggedInEmployee",
    }),
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
        this.employeelist = respone.data;
        console.log(respone.data);
        console.log(this.currentUser.Employee_id)
      }
    },

    async signin() {
      const employee = {};
      employee.Employee_id = "C0000002";
      employee.Employee_password = "12345678";
      const [error, data] = await this.handle(
        this.$store.dispatch("login", employee)
      );
      if (error) {
        console.log(error);
        this.loading = false;
        this.message = "Số điện thoại hoặc mật khẩu đăng nhập sai";
      } else {
        console.log("login thanh coong!!!")
        console.log(data)
      }
    },
    async getbyid(id) {
      const [err, respone] = await this.handle(
        EmployeeService.get(id)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("by id: ")
        this.employee = respone.data;
        console.log(respone.data);
      }
    },

    async add() {
      this.newemployee.name = 'Vo van anh';
      this.newemployee.sex = "nam";
      this.newemployee.major = "ky su";
      this.newemployee.id = "C0000004";
      this.newemployee.roleId = "01";
      this.newemployee.address = "Cần Thơ";
      this.newemployee.phoneNumber = "0777888992";
      this.newemployee.identityCardNumber = "123456789";
      this.newemployee.password = "12345678";
      const [err, respone] = await this.handle(
        EmployeeService.create(this.newemployee)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Create new employee ok: ")
        console.log(respone.data);
      }
    },

    async update() {

      // this.employee.name = this.employee.Employee_name;
      // this.employee.sex = this.employee.Employee_sex;
      this.employee.name = "Võ vũ Duy Thanh";
      this.employee.sex = "Nam"
      this.employee.major = "Nông nghiệp";
      this.employee.roleId = "02";
      this.employee.identityCardNumber = "123456789015";
      this.employee.phoneNumber = "0777888945";
      this.employee.address = "Vĩnh Long";
      const [err, respone] = await this.handle(
        EmployeeService.update("C0000002", this.employee)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log(respone.data);
      }
    },

    async findbyname() {
      const [err, respone] = await this.handle(
        EmployeeService.findByName("anh")
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("by name: ")
        console.log(respone.data);
      }
    },

    async change() {
      const data = {};
      data.password = "12345678";
      data.id = "C0000003";
      const [err, respone] = await this.handle(
        EmployeeService.changePassword("C0000003", data)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("change: ")
        console.log(respone.data);
      }
    },
    // ----------------------------------------------------------------------Employee---------------------------------
    // ----------------------------------------------------------------------Role---------------------------------
    async retrieveRole() {
      const [err, respone] = await this.handle(
        RoleService.get('01')
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Role: ")
        console.log(respone.data);
      }
    },
    // ----------------------------------------------------------------------Role---------------------------------
    // ----------------------------------------------------------------------Crop---------------------------------
    async retrieveCrop() {
      const [err, respone] = await this.handle(
        CropService.findByName("thu")
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Crop by name: ")
        console.log(respone.data);
      }
    },
    // ----------------------------------------------------------------------Crop---------------------------------
    // ----------------------------------------------------------------------Seed---------------------------------
    async retrieveSeed() {
      const lua = {};
      lua.id = "SD00000002";
      lua.name = "VNR20";
      lua.characteristic = "Chiều cao cây 95 - 100 cm, lá đòng hơi to bản, đứng, đẻ nhánh khỏe, tập trung, gọn khóm. Giống VNR20 thấp cây chống đổ tốt, chịu thâm canh, chống chịu trung bình với một số sâu bệnh hại chính, phạm vi thích ứng rộng.";
      lua.supplier = "Công ty cổ phần tập đoàn giống cây trồng Việt Nam";
      const [err, respone] = await this.handle(
        SeedService.update("SD00000002", lua)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Seed by name: ")
        console.log(respone.data);
      }
    },
    // ----------------------------------------------------------------------Soil---------------------------------
    async retrieveSoil() {
      const soil = {};
      soil.id = "SL00000002";
      soil.name = "Đất phù sa xa sông cv";
      const [err, respone] = await this.handle(
        SoilService.delete("SL00000002")
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Soil by name: ")
        console.log(respone.data);
      }
    },
    // ----------------------------------------------------------------------Soil---------------------------------
    async retrieveArableLand() {
      const arableLand = {};
      arableLand.id = "AL00000002";
      // arableLand.location = "Cần Thơ";
      // arableLand.soilId = "SL00000001"
      // arableLand.area = "14000";
      // arableLand.owner = "Phan Vân Thanh";
      const [err, respone] = await this.handle(
        ArableLandService.delete(arableLand.id)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("ArableLand by name: ")
        console.log(respone.data);
      }
    },

    // ----------------------------------------------------------------------EpidemicsClassification---------------------------------
    async retrieveEpidemicsClassificationd() {

      const [err, respone] = await this.handle(
        EpidemicsClassificationService.get("EC000001")
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("EpidemicsClassification: ")
        console.log(respone.data);
      }
    },

    // ----------------------------------------------------------------------Epidemic---------------------------------
    async retrieveEpidemic() {
      const epidemic = {};
      epidemic.id = "EC00000002";
      epidemic.name = "Rầy nâu";
      epidemic.timeOfDevelopment = "Quanh năm";
      epidemic.developmentEnvironment = "Sống quanh gốc lúa ngay phần bẹ lá, phía trên mặt nước. Việc sử dụng quá mức urê và phân bón nitơ và thuốc sâu có thể dẫn đến bùng phát rầy nâu bằng cách tăng khả năng sinh sản của chúng, và bằng cách giảm các thiên địch của rầy nâu. Khí hậu ấm nóng, ẩm độ cao, mưa nắng xen kẽ và cấy nhiều giống nhiễm rầy thường phát sinh gây hại nặng";
      epidemic.Harm = "Tác hại trực tiếp của rầy nâu là chích hút nhựa, làm cho cây lúa suy yếu, phát triển kém, lá vàng úa, rụi dần và khô héo đi gọi là “cháy rầy”. Tác hại gián tiếp của rầy nâu là truyền các bệnh siêu vi khuẩn cho lúa như bệnh lúa cỏ, lùn xoắn lá, vàng lùn. Rầy nâu nhỏ truyền bệnh lùn sọc đen";
      epidemic.classificationId = "EC000001";
      const [err, respone] = await this.handle(
        EpidemicService.creat(epidemic)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Epidemic: ")
        console.log(respone.data);
      }
    },

    // ----------------------------------------------------------------------Pesticide---------------------------------
    async retrievePesticide() {
      const pesticide = {};
      pesticide.id = "PE00000002";
      pesticide.name = "Butyl 10wp";
      pesticide.supplier = "Công ty cổ phần bảo vệ thực vật Sài Gòn";
      const [err, respone] = await this.handle(
        PesticideService.create(pesticide)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Pesticide: ")
        console.log(respone.data);
      }
    },

    // ----------------------------------------------------------------------Fertilizer---------------------------------
    async retrieveFertilizer() {
      const fertilizer = {};
      fertilizer.id = "FR00000002";
      fertilizer.name = "NPK Hà Lan 20-0-10+TE";
      fertilizer.supplier = "Công ty cổ phần phân bón Hà Lan";
      const [err, respone] = await this.handle(
        FertilizerService.update(fertilizer.id, fertilizer)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Fertilizer: ")
        console.log(respone.data);
      }
    },


    // ----------------------------------------------------------------------OtherActivities---------------------------------
    async retrieveOtherActivities() {
      // const otheractivities = {};
      // otheractivities.id = "OA03";
      // otheractivities.name = "Bơm nước ra ngoài ruộng";
      const [err, respone] = await this.handle(
        OtherActivitiesService.delete("OA03")
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Other Activities: ")
        console.log(respone.data);
      }
    },

    // ----------------------------------------------------------------------RiceCropInformation---------------------------------
    async retrieveRiceCropInformation() {
      const riceCropInformation = {};
      riceCropInformation.id = "RCI0000001";
      riceCropInformation.name = "Vụ hè thu năm 2023";
      riceCropInformation.Seed_id = "SD00000001";
      riceCropInformation.sowingDate = "2023-05-2";
      riceCropInformation.ArableLand_id = "AL00000001";
      riceCropInformation.Crop_id = "C00002";
      const [err, respone] = await this.handle(
        RiceCropInformationService.update(riceCropInformation.id, riceCropInformation)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Rice Crop Information: ")
        console.log(respone.data);
      }
    },

    // ----------------------------------------------------------------------Monitor---------------------------------
    async retrieveMonitor() {
      const monitor = {};
      monitor.Employee_id = "EE000003";
      monitor.RiceCropInformation_id = "RCI0000001";
      const [err, respone] = await this.handle(
        MonitorService.findByName(monitor.Employee_id)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Monitor: ")
        console.log(respone.data);
      }
    },

    // ----------------------------------------------------------------------developmentStage---------------------------------
    async retrieveDevelopmentStage() {
      const developmentStage = {};
      developmentStage.id = "EE000003";
      developmentStage.name = "RCI0000001";
      const [err, respone] = await this.handle(
        DevelopmentStageService.get("DS000001")
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("development stage: ")
        console.log(respone.data);
      }
    },

    // ----------------------------------------------------------------------ActivityDetails---------------------------------
    async retrieveActivityDetails() {
      const activityDetails = {};
      activityDetails.RiceCropInformation_id = "RCI0000001";
      activityDetails.OtherActivities_id = "OA01";
      activityDetails.startDate = "2023-05-03";
      activityDetails.endDate = "2023-05-03";
      activityDetails.Employee_id = "EE000002";
      activityDetails.times = "1";
      console.log(activityDetails)
      const [err, respone] = await this.handle(
        ActivityDetailsService.get(activityDetails.RiceCropInformation_id)
      );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Activity Detail: ")
        console.log(respone.data);
      }
    },

    // ----------------------------------------------------------------------EpidemicTimes---------------------------------
    async retrieveEpidemicTimes() {
      const epidemicTimes = {};
      epidemicTimes.RiceCropInformation_id = "RCI0000001";
      epidemicTimes.Epidemics_id = "EC00000001";
      epidemicTimes.startDate = "2023-05-03";
      epidemicTimes.endDate = "2023-05-04";
      epidemicTimes.Employee_id = "EE000002";
      epidemicTimes.times = "1";
      epidemicTimes.DevelopmentStage_id = "DS000001";
      console.log(epidemicTimes)
      const [err, respone] = await this.handle(
        // EpidemicTimesService.update(epidemicTimes.RiceCropInformation_id, epidemicTimes.Epidemics_id, epidemicTimes.times, epidemicTimes)
        // EpidemicTimesService.delete(epidemicTimes.RiceCropInformation_id, epidemicTimes.Epidemics_id, epidemicTimes.times)
        EpidemicTimesService.create(epidemicTimes)
        );
      if (err) {
        console.log(err)
      }
      else {
        //this.employee = respone.data;
        console.log("Epidemic Times: ")
        console.log(respone.data);
      }
    },
  },
  mounted() {
    this.initEmployeeState();
    this.retrieveEmployee();
    this.retrieveCrop();
    this.retrieveRole();
    // this.retrieveSeed();
    // this.retrieveSoil();
    //  this.retrieveArableLand();
    // this.retrieveEpidemicsClassificationd()
    // this.retrieveEpidemic();
    // this.retrievePesticide();
    // this.retrieveFertilizer();
    // this.retrieveOtherActivities();
    // this.retrieveRiceCropInformation();
    // this.retrieveMonitor();
    // this.retrieveDevelopmentStage();
    // this.retrieveActivityDetails();
    // this.retrieveEpidemicTimes();
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
