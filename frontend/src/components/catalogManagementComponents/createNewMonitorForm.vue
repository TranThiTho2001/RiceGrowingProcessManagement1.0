<template>
     <div @submit="newmonitor.close = true, $emit('addMonitor-submit', newmonitor)" :validation-schema="schema"
          class="form createMonitorForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle" @click="newmonitor.close = false, $emit('addMonitor-submit', newmonitor)"
                    style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName">
                    QUẢN LÝ QUYỀN THEO DÕI MÙA VỤ
               </p>

          </div>
          <div class="row ml-2 mr-2">
               <input type="text" class="form-control col-sm-4 pt-2 inputSearch" placeholder="Tìm theo tên"
                    style="border-radius:10px" v-model="nameToSearch" @keyup.enter="searchName" />
               <button class=" btnSearch pt-2" @click="searchName">
                    <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
               </button>
               <div class="tableFixHead tableEmployee" style="height: 550px!important; " v-if="loaded">
                    <table class="table  mt-3" aria-placeholder="my-table">
                         <thead>
                              <th class="text-center">STT</th>
                              <th class="text-center">Mã</th>
                              <th>Họ và tên</th>
                              <th>Chuyên môn</th>
                              <th>Vai trò</th>
                              <th class="text-center">Tùy chọn</th>
                         </thead>
                         <tbody>
                              <tr v-for="(employee, i) in employeelist" :key="i">
                                   <td class="text-center">{{ i + 1 }}</td>
                                   <td class="text-center">{{ employee.Employee_id }}</td>
                                   <td>{{ employee.Employee_name }}</td>
                                   <td>{{ employee.Employee_major }}</td>
                                   <td>{{ employee.Role_name }}</td>
                                   <td class="text-center">
                                        <button class="btnMonitor btnPermission" v-if="!employee.Employee_monitor"
                                             @click="CreateNewMonitor(employee)">
                                             Cấp quyền theo dõi
                                        </button>
                                        <button class="btnMonitoring" v-if="employee.Employee_monitor"
                                             @click="deleteMonitor(employee)">
                                             Đang theo dõi
                                        </button>
                                   </td>
                              </tr>
                         </tbody>
                    </table>
               </div>
          </div>


          <div class="row ">
               <div class="col-sm-12 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         {{ message2 }}</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }} </span>
               </div>
          </div>
     </div>
</template>
 
<script>
import EmployeeService from '@/services/employee.service';
import MonitorService from '@/services/monitor.service';

export default {
     name: "createMonitorForm",
     components: {

     },
     emits: ["addMonitor-submit"],
     props: ["newMonitor", "message1", "message2", "employeeList", "newRiceCrop"],
     data() {
          return {
               newmonitor: this.newMonitor,
               employeelist: this.employeeList,
               nameToSearch: "",
               monitorList: [],
               newriceCrop: this.newRiceCrop,
               loaded: false,
          };
     },

     methods: {
          async searchName() {
               const [error, response] = await this.handle(EmployeeService.findByNameofPartil(this.nameToSearch));
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.employeelist = response.data;
                         console.log(response.data)
                    }
                    else {
                         console.log(response.data)
                    }

               }
          },

          async retrieveMonitor() {
               const [error, response] = await this.handle(
                    MonitorService.getAll()
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data != null) {
                         this.monitorList = response.data;
                         this.getMonitor()
                    }
               }
          },

          async CreateNewMonitor(data) {
               data.RiceCropInformation_id = this.newriceCrop.RiceCropInformation_id;
               const [error, response] = await this.handle(
                    MonitorService.create(data)
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == "Không thể tạo quyền theo dõi mới.") {
                         this.message = "Không thể tạo quyền theo dõi mới.";
                    }
                    else {
                         this.retrieveMonitor();
                    }
               }
          },

          async deleteMonitor(data) {
               data.RiceCropInformation_id = this.newriceCrop.RiceCropInformation_id;
               const [error, response] = await this.handle(
                    MonitorService.delete(data.RiceCropInformation_id, data.Employee_id)
               );
               if (error) {
                    console.log(error);
               } else {
                    if (response.data == error) {
                         this.message = "Xóa không thành công.";
                    }
                    else if (response.data == "Lỗi trong quá trình xóa quyền giám sát!!") {
                         this.message = "Xóa không thành công";
                    }
                    else {
                         this.message = "Xóa thành công.";
                         this.retrieveMonitor();
                    }
               }
          },

          async getMonitor() {
               this.employeelist.forEach(employee => {
                    employee.Employee_monitor = false;
                    this.monitorList.forEach(monitor => {
                         if (employee.Employee_id == monitor.Employee_id) {
                              if (monitor.RiceCropInformation_id == this.newriceCrop.RiceCropInformation_id) {
                                   employee.Employee_monitor = true;
                              }
                         }
                    });
               });
               this.loaded = true;
          },

     },

     mounted() {
          this.retrieveMonitor();
     }
};
</script>
 
<style>
.createMonitorForm {
     margin: auto;
     padding: 20px;
     background: #FAFAFC !important;
     box-shadow: 0px 4px 24px -1px rgba(0, 0, 0, 0.3);
     backdrop-filter: blur(37.5px);
     border-radius: 5px;
     width: 90%;
     position: relative;
     top:80px;
     transition: all 5s ease-in-out;
}

@media only screen and (max-width: 1430px) {
     .createMonitorForm {
          left: 10%;
     }
}

.createMonitorForm .table tbody td {
     font-size: 16px;
     padding: 4px 2px 4px 2px !important;
     font-family: 'Roboto';
     font-style: normal;
     color: #1C1C1F;
}

.createMonitorForm .table tbody tr:hover {
     background-color: rgb(248, 246, 190);
     font-weight: 500;
}

.createMonitorForm .functionName {
     font-size: 25px;
     font-weight: 600;

}

.createMonitorForm nav {
     float: right;
}

.createMonitorForm nav .pagination .page-link {
     color: #5C5D22;
     font-size: 17px;
}

.createMonitorForm .btnMonitor {
     background: #EEEA41;
     box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.25);
     border: none;
     border-radius: 10px;
     color: #5C5D22;
     font-weight: 500;
     font-family: 'Roboto';
     font-size: 17px;
     padding: 4px 8px 4px 8px;
     width: 160px;
}

.createMonitorForm .btnMonitor:hover {
     background: #cac71d;
}

.createMonitorForm .btnMonitoring:hover {
     background: #cac71d;
}

.createMonitorForm .btnMonitoring {
     border: none;
     color: #5C5D22;
     border-radius: 10px;
     background: #ABD2C8;
     box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.25);
     font-weight: 500;
     font-family: 'Roboto';
     font-size: 17px;
     padding: 4px 8px 4px 8px;
     width: 160px;
}

.createMonitorForm .inputSearch {
     background: linear-gradient(0deg, #FFFFFF, #FFFFFF), #EAEAEA;
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     font-size: 16px;
     color: #84858A;
     font-family: 'Roboto';
     font-style: normal;
     font-weight: 400;
}

.createMonitorForm .btnSearch {
     position: absolute;
     left: 31%;
     border-radius: 10px;
     border: none;
     background: none;
}

.createMonitorForm .btnSearch .fa-search {
     border: none;
}
</style>