<template>
     <Form @submit="newotherActivities.close = true, $emit('updateOtherActivities-submit', newotherActivities)"
          :validation-schema="schema" class="form  container-fluid updateOtherActiviesForm">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle"
                         @click="newotherActivities.close = false, $emit('updateOtherActivities-submit', newotherActivities)"
                         style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>

          <div class="row">
               <p class="col-sm-12 text-center functionName">
                    CẬP NHẬT THÔNG TIN LẦN THỰC HIỆN HOẠT ĐỘNG CỦA MÙA VỤ
               </p>
          </div>

          <div class="row content">
               <div class="col-sm-12">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã hoạt động<span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newotherActivities.OtherActivities_id"
                              placeholder="Nhập mã hoạt động..." disabled="true" />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="name" class="mt-3">Tên hoạt động <span style="color: red">*</span></label>
                         <Field name="name" class="form-control" v-model="newotherActivities.OtherActivities_name"
                              placeholder="Nhập tên hoạt động..." />
                         <ErrorMessage name="name" class="error-feedback" />
                    </div>

               </div>
          </div>

          <div class="row ">
               <div class="col-sm-12 mt-2 mb-3 text-center">
                    <span v-if="message2 == 'Cập nhật thành công.'" class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if="message2 == 'Cập nhật thành công.'" class="textMessage2 mt-2 mb-2" style="color:black;">
                         Cập nhật thông tin hoạt động thành công</span>
                    <span v-if="message1 == 'Cập nhật không thành công.'" class="textMessage1 pt-2 pb-2"> Cập nhật thông tin
                         hoạt động không thành công </span>
               </div>
          </div>

          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu">Lưu</button>
               </div>

          </div>
     </form>
</template>
 
<script>
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";

export default {
     name: "updateOtherActivitiesForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["updateOtherActivities-submit"],
     props: ["newOtherActivities", "message1", "message2"],
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã hoạt động có giá trị"),
               name: yup
                    .string()
                    .required("Tên hoạt động phải có giá trị"),
          });
          return {
               newotherActivities: this.newOtherActivities,
               schema,
          };
     },

     methods: {

     }
};
</script>
 
<style>

@import url(../../assets/mainStyle.css);
.activitiesManagement .createOtherActiviesForm,
.activitiesManagement .updateOtherActiviesForm {
    margin-left:30% ;
    padding: 20px;
    background: #FAFAFC;
    box-shadow: 0px 4px 24px -1px rgba(0, 0, 0, 0.3);
    backdrop-filter: blur(37.5px);
    border-radius: 5px;
    width: 40%;
    position: relative;
    top:120px;
    transition: all 5s ease-in-out;
}

@media only screen and (max-width: 1430px) {
    .activitiesManagement .createOtherActiviesForm,
    .activitiesManagement .updateOtherActiviesForm {
        margin-left: 20%;
        width: 60%;

    }
}

.riceCropDetail .createOtherActiviesForm{
    border: 0.5px solid #b8b5b5;
    border-radius: 10px;
    position: absolute;
    top: calc(-80px);
    left: 0%;
    width: 40%;
    z-index: 12;
}

.dp__theme_light {
     --dp-background-color: #FAFAFC;
     --dp-border-radius: 10px;
     --dp-text-color: #2F3033;
     --dp-hover-color: #f3f3f3;
     --dp-hover-text-color: #212121;
     --dp-hover-icon-color: #959595;
     --dp-primary-color: #1976d2;
     --dp-primary-disabled-color: #6bacea;
     --dp-primary-text-color: #f8f5f5;
     --dp-secondary-color: #c0c4cc;
     --dp-border-color: #ddd;
     --dp-menu-border-color: #ddd;
     --dp-border-color-hover: #aaaeb7;
     --dp-disabled-color: #f6f6f6;
     --dp-scroll-bar-background: #f3f3f3;
     --dp-scroll-bar-color: #959595;
     --dp-success-color: #76d275;
     --dp-success-color-disabled: #a3d9b1;
     --dp-icon-color: #959595;
     --dp-danger-color: #ff6f60;
     --dp-marker-color: #ff6f60;
     --dp-tooltip-color: #fafafa;
     --dp-disabled-color-text: #8e8e8e;
     --dp-highlight-color: rgb(25 118 210 / 10%);
}

.dp__input {
     background-color: var(--dp-background-color);
     border-radius: 10px !important;
     font-family: 'Roboto';
     font-style: normal;
     font-size: 18px;
     font-weight: 500;
     border: 1px solid var(--dp-border-color);
     outline: none;
     transition: border-color .2s cubic-bezier(0.645, 0.045, 0.355, 1);
     width: 100%;
     height: 80%;
     font-size: 1rem;
     line-height: 1.5rem;
     padding: 6px 12px;
     color: var(--dp-text-color);
     box-shadow: inset 0px 4px 4px rgba(0, 0, 0, 0.25);
     box-sizing: border-box;
}</style>