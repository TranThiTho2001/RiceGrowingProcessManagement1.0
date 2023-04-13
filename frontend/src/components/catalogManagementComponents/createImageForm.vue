<template>
    <Form @submit="newimage.close = true, $emit('addImage-submit', newimage)" enctype="multipart/form-data"
        class="form createImageForm containe-fluid">
        <div class="row">
            <div class="col-sm-12 text-right">
                <i class="fas fa-times" @click="newimage.close = false, $emit('addImage-submit', newimage)"
                    style="font-size: 25px; padding: 10px;"></i>
            </div>
        </div>
        <div class="functionName row mb-3">
            <div class="col-sm-12 text-center">
            <i class="fa fa-plus-circle pt-2" style="font-size: 25px;"> </i>
            <p class="title">THÊM HÌNH ẢNH</p>
        </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-center ">
                    <input type="file" ref="file" name="image" @change="selectFile($event)" accept="image/*"
                        enctype="multipart/form-data" class="ml-5 pl-5" v-bind:aria-disabled="true">
                <div class="row rowImage mt-2">
                    <div class="col-md-2"></div>
                    <div class="col-md-8 text-center">
                        <img v-if="url != ''" :src="url" class="img-fluid" style="max-height: 300px;">
                    </div>
                    <div class="col-md-2"></div>

                </div>
            </div>
        </div>

        <div class="form-group row">
            <div class="col-sm-12 text-center">
                <span v-if="message2 == 'Thêm thành công'" class="fas fa-check-circle"
                    style="color:#00BA13;"></span>
                <span v-if="message2 == 'Thêm không thành công'" class="fas fa-times-circle"
                    style="color:red;"></span>
                <p v-if="message2 == 'Thêm thành công'" class="textMessage2" style="color:#00BA13">{{ message2 }}</p>
                <p v-else class="textMessage2">{{ message2 }}</p><br>
                <p v-if="message2 == 'Thêm không thành công'" class="textMessage1">{{ message1 }}</p>
                <p v-if="message1 == 'Vui lòng chọn hình ảnh!!'">{{ message1 }}
                </p>
            </div>
        </div>
        <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu col-sm-2">Lưu</button>
               </div>
          </div>
    </Form>
</template>

<script>

import { Form } from "vee-validate";

export default {
    name: "CreateImageForm",
    components: {
        Form,
    },
    emits: ["addImage-submit", "author-delete"],
    props: ["newImage", "message1", "message2", "newRiceCrop"],
    data() {

        return {
            newimage: this.newImage,
            newriceCrop: this.newRiceCrop,
            fileImage: {},
            url: ""
        };
    },
    methods: {

        async selectFile(event) {
            this.fileImage = event.target.files[0];
            this.newimage.SP_HinhAnh = this.newriceCrop.RiceCropInformation_id + this.fileImage.name;
            console.log(this.fileImage.name);
            this.newimage.Image = this.fileImage;
            this.url = URL.createObjectURL(this.fileImage);
        },

    }
};
</script>

<style>
.createImageForm {
    position: absolute;
    width: 50%;
    height: 520px;
    top: 18%;
    left: 22%;
    border-radius: 10px;
}

.createImageForm .rowImage {
    height: 280px;
}

.createImageForm .title{
    display: inline;
    text-align: center;
    font-size: 24px;
    font-weight: 600;
}
 .form-group .textMessage2,
 .form-group .textMessage1{
     display: inline;
     font-size: 18px;
     font-family: Inter;
}

</style>