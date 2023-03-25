<template>
     <Form @submit="newepidemic.close = true, $emit('addEpidemic-submit', newepidemic)" :validation-schema="schema"
          class="form container createEpidemicForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times" @click="newepidemic.close = false, $emit('addEpidemic-submit', newepidemic)"
                         style="font-size: 25px; "></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName"><i class="fas fa-plus-circle"></i> Cập nhật thông
                    tin giống lúa mới
               </p>
          </div>
          <div class="row content">
               <div class="col-sm-6 mt-2">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã <span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newepidemic.Epidemic_id"
                              placeholder="Nhập mã bệnh dịch..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>


                    <div class="form-group">
                         <label for="time" class="mt-3">Thời điểm xuất hiện</label>
                         <Field name="time" class="form-control" v-model="newepidemic.Epidemic_timeOfDevelopment"
                              placeholder="Nhập thời điểm xuất hiện...." />
                         <ErrorMessage name="time" class="error-feedback" />
                    </div>

                    <div class="form-group ">
                         <label for="environment" class="mt-4 pt-2">Môi trường phát triển <span style="color: red">*</span></label>
                         <Field name="environment" class="form-control"
                              v-model="newepidemic.Epidemic_developmentEnvironment" as="textarea" style="height: 120px;"
                              placeholder="Nhập môi trường phát triển..." />
                         <ErrorMessage name="environment" class="error-feedback" />
                    </div>
               </div>

               <div class="col-sm-6 ">
                    <div class="form-group">
                         <label for="name" class="mt-3">Tên <span style="color: red">*</span></label>
                         <Field name="name" class="form-control" v-model="newepidemic.Epidemic_name"
                              placeholder="Nhập tên bệnh dịch..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="classtify" class="mt-3">Phân loại <span style="color: red">*</span></label>
                         <Field name="classtify" v-model="newepidemic.EpidemicsClassification_name">
                              <select class="form-control" v-model="newepidemic.EpidemicsClassification_name" name="classtify" for="classtify">
                                   <option  for="classtify">Côn trùng</option>
                                   <option>Dịch bệnh</option>
                                   <option >Nấm hại</option>
                                   <option >Sâu bệnh</option>
                              </select>
                        </Field>
                         <ErrorMessage name="classtify" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="harm" class="mt-3">Tác hại <span style="color: red">*</span></label>
                         <Field name="harm" class="form-control" v-model="newepidemic.Epidemic_Harm" as="textarea"
                              style="height: 120px;" placeholder="Nhập tác hại..." />
                         <ErrorMessage name="harm" class="error-feedback" />
                    </div>

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
                    <span v-if="message1 == 'Thêm không thành công.'" class="textMessage1 pt-2 pb-2"> {{ message1 }}
                    </span>
               </div>
               <div class="col-sm-2"></div>
          </div>
          <div class="row mb-4">
               <div class="col-sm-5"></div>
               <button class="btn btn-outline-secondary btnLuu col-sm-2">Lưu</button>
               <div class="col-sm-5"></div>
          </div>

     </form>

</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";

export default {
     name: "createEpidemicForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["addEpidemic-submit"],
     props: ["newEpidemic", "message1", "message2"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã bệnh dịch phải có giá trị")
                    .min(10, "Mã bệnh dịch phải gồm 10 ký tự")
                    .max(10, "Mã bệnh dịch phải gồm 10 ký tự"),
               name: yup
                    .string()
                    .required("Tên bệnh dịch phải có giá trị"),
               environment: yup
                    .string()
                    .required("Đặc tính của bệnh dịch phải có giá trị"),
               time: yup
                    .string()
                    .required("Nhà cung cấp bệnh dịch phải có giá trị"),
               harm: yup
                    .string()
                    .required("Tác hại bệnh dịch phải có giá trị"),
               classtify: yup
                    .string()
                    .required("Phân loại bệnh dịch phải có giá trị")
          });
          return {
               newepidemic: this.newEpidemic,
               schema,
          };
     },

     methods: {
     
     }
};
</script>
 
<style>
@import url(../../assets/epidemicStyle.css);
</style>