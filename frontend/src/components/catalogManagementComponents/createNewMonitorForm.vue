<template>
     <div @submit="newmonitor.close = true, $emit('addMonitor-submit', newmonitor)" :validation-schema="schema"
          class="container createMonitorForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times" @click="newmonitor.close = false, $emit('addMonitor-submit', newmonitor)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName">
                    <span class="fas fa-edit actionIcon"></span>Thêm Nhân Viên Theo Dõi Ruộng Lúa
               </p>

          </div>
          <div class="row content">
               <input type="text" class="form-control col-sm-4 ml-4 pt-2 inputSearch" placeholder="Tìm theo tên"
                    style="border-radius:10px" v-model="nameToSearch" @keyup.enter="searchName" />
               <button class=" btnSearch pt-2" @click="searchName">
                    <span class="fa fa-search" style="font-size:18px; color: #7E7E7E;"></span>
               </button>
               <table class="table ml-4 mr-4 mt-3" aria-placeholder="my-table">
                    <thead>
                         <td class="text-center">STT</td>
                         <td class="text-center">Mã</td>
                         <td>Họ và tên</td>
                         <td>Chuyên môn</td>
                         <td>Vai trò</td>
                         <td class="text-center">Tùy chọn</td>
                    </thead>
                    <tbody>
                         <tr v-for="(employee, i) in get_rows()" :key="i">
                              <td class="text-center" v-if="currentPage > 1">{{ i + ((currentPage - 1) * elementsPerPage) }}
                              </td>
                              <td class="text-center" v-else>{{ i }}</td>
                              <td class="text-center">{{ employee.Employee_id }}</td>
                              <td>{{ employee.Employee_name }}</td>
                              <td>{{ employee.Employee_major }}</td>
                              <td>{{ employee.Role_name }}</td>
                              <td class="text-center">
                                   <button class="btnMonitor" v-if="!employee.Employee_monitor"
                                        @click="CreateNewMonitor(employee)">
                                        Cấp quyền theo dõi
                                   </button>
                                   <button class="btnMonitoring" v-if="employee.Employee_monitor">
                                        Đang theo dõi
                                   </button>
                              </td>
                         </tr>
                    </tbody>
               </table>
          </div>

          <div class="row">
               <div class="col-sm-12 pr-4">
                    <nav aria-label="...">
                         <ul class="pagination " aria-controls="my-table">
                              <li class="page-item disabled" v-if="currentPage == 1">
                                   <a class="page-link" href="#" aria-controls="my-table">{{ previous }}</a>
                              </li>
                              <li class="page-item " v-if="currentPage > 1">
                                   <a class="page-link" href="#" @click="change_page('-')" aria-controls="my-table">{{
                                        previous }}</a>
                              </li>
                              <li class="page-item"><a class="page-link" href="#" @click="change_page(currentPage - 1)"
                                        v-if="currentPage > 1">{{ currentPage - 1 }}</a></li>
                              <li class="page-item active">
                                   <a class="page-link" style="background-color: #EEEA41; border-color: #EEEA41;" href="#">{{
                                        currentPage }} <span class="sr-only">(current)</span></a>
                              </li>
                              <li class="page-item"><a class="page-link" href="#" v-if="currentPage < num_pages()"
                                        @click="change_page(currentPage + 1)">{{ currentPage + 1 }}</a></li>
                              <li class="page-item">
                                   <a class="page-link" href="#" @click="change_page('+')"
                                        v-if="currentPage < num_pages()">{{
                                             next }}</a>
                              </li>
                              <li class="page-item disabled">
                                   <a class="page-link" href="#" v-if="currentPage >= num_pages()">{{ next }}</a>
                              </li>
                         </ul>
                    </nav>
               </div>
          </div>

          <div class="row ">
               <div class="col-sm-2"></div>
               <div class="col-sm-8 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Thêm thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Thêm thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         {{ message2 }}</span>
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }} </span>
               </div>
               <div class="col-sm-2"></div>
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
               currentPage: 1,
               elementsPerPage: 5,
               ascending: false,
               previous: '<<',
               next: '>>',
               monitorList: [],
               newriceCrop: this.newRiceCrop,
          };
     },

     methods: {
          async searchName() {
               const [error, response] = await this.handle(EmployeeService.findByName(this.nameToSearch));
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
                         this.get_rows();
                    }
               }
          },

          async getMonitor() {
               this.employeelist.forEach(employee => {
                    console.log(this.newRiceCrop.RiceCropInformation_id)
                    employee.Employee_monitor = false;
                    this.monitorList.forEach(monitor => {
                         if (employee.Employee_id == monitor.Employee_id) {
                              if (monitor.RiceCropInformation_id == this.newriceCrop.RiceCropInformation_id) {
                                   employee.Employee_monitor = true;
                                   console.log("cjfce")
                              }
                         }
                    });
               });
          },

          get_rows() {
               var start = (this.currentPage - 1) * this.elementsPerPage;
               var end = start + this.elementsPerPage; console.log(this.employeelist.slice(start, end))
               this.getMonitor()
               return this.employeelist.slice(start, end);

          },

          // So trang cua danh sach danh muc
          num_pages() {
               console.log(this.employeelist.length / this.elementsPerPage)
               return Math.ceil(this.employeelist.length / this.elementsPerPage);

          },

          async change_page(page) {
               if (page == '-' && this.currentPage > 1) {
                    this.currentPage -= 1;
                    this.get_rows();
               }
               else if (page == '+' && this.currentPage < this.num_pages()) {
                    this.currentPage += 1;
                    this.get_rows();
               }
               else {
                    this.currentPage = page;
                    this.get_rows();
               }
          },
     },

     mounted() {
          this.retrieveMonitor();
     }
};
</script>
 
<style>
.createMonitorForm {
     position: absolute;
     width: 80%;
     height: 80vh;
     top: 15%;
     left: 20%;
     background-color: rgb(254, 254, 254);
     border:solid 1px #84858A;
     border-radius: 10px;
}

.createMonitorForm .table thead td {
     background-color: rgb(245, 242, 162);
     font-size: 18px;
     font-weight: 600;
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
     box-shadow: 0px 7px 7px rgba(0, 0, 0, 0.25);
     border: none;
     border-radius: 10px;
     color: #5C5D22;
     font-weight: 700;
     font-family: 'Roboto';
}

.createMonitorForm .btnMonitor:hover {
     background: #cac71d;
     box-shadow: 0px 7px 7px rgba(0, 0, 0, 0.25);
     border: none;
     border-radius: 10px;
     color: #5C5D22;
     font-weight: 700;
     font-family: 'Roboto';
}

.createMonitorForm .btnMonitoring:hover {
     background: #cac71d;
     box-shadow: 0px 7px 7px rgba(0, 0, 0, 0.25);
     border: none;
     border-radius: 10px;
     color: #5C5D22;
     font-weight: 700;
     font-family: 'Roboto';
}

.createMonitorForm .btnMonitoring {
     background: #e9e89d;
     box-shadow: 0px 7px 7px rgba(0, 0, 0, 0.25);
     border: none;
     border-radius: 10px;
     color: #5C5D22;
     font-weight: 700;
     font-family: 'Roboto';
     width: 150px;
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
     left: 32%;
     border-radius: 10px;
     border: none;
     background: none;
}

.createMonitorForm .btnSearch .fa-search {
     border: none;
}
</style>