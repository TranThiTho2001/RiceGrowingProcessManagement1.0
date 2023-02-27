<template>
    <Form @submit="$emit('addImage-submit', sanphamLocal)"  enctype="multipart/form-data" class="createForm">
        <div class="functionName">
            <span class="fa fa-plus-circle"> </span>
            <p style="display:inline"> Thêm sản phẩm mới </p>
        </div>
        <div class="row container-fluid">
                    <label for="image">Hình ảnh &nbsp; &nbsp;</label>
                                <input type="file" ref="file" name="image" @change="selectFile($event)" accept="image/*" enctype="multipart/form-data"
                                    class="" v-bind:aria-disabled="true">
                    <div class="row" >
                        <div class="col-md-5">
                            <img v-if="url!=''" :src="url" class="img-fluid">
                        </div>
                        <div class="col-md-7">
                        </div>
                    </div>
        </div>

        <div class="form-group">
            <span v-if="message2 == 'Thêm thành công'" class="fas fa-check-circle"
                style="color:#00BA13; text-align: center; margin-left: 44%;"></span>
            <span v-if="message2 == 'Thêm không thành công'" class="fas fa-times-circle"
                style="color:red; text-align: center;  margin-left: 42%;"></span>
            <p v-if="message2 == 'Thêm thành công'" class="textMessage2" style="color:#00BA13">{{ message2 }}</p>
            <p v-else class="textMessage2">{{ message2 }}</p><br>
            <p v-if="message2 == 'Thêm không thành công'" class="textMessage1" style="margin-left: 4%;">{{ message1 }}</p>
            <button class="btn btn-outline-secondary btnLuu">Lưu</button>
        </div>
    </form>

</template>

<script>

import { Form} from "vee-validate";
// import ImageService from '../../services/image'

export default {
    name: "SanPhamFormThem",
    components: {
        Form,
    },
    emits: ["addImage-submit", "author-delete"],
    props: ["newImage", "message1", "message2"],
    data() {

        return {
            sanphamLocal: this.newImage,
            danhmucActive: "",
            thuonghieuActive: "",
            fileImage: {},
            url:""
        };
    },
    methods: {

        goToQLDanhMuc() {
            this.$router.push("/QLDanhMuc");
        },

        async selectFile(event) {
            this.fileImage = event.target.files[0];
            this.sanphamLocal.SP_HinhAnh = "image_" + this.fileImage.name;
            console.log(this.fileImage.name);
            this.sanphamLocal.Image = this.fileImage;
            this.url = URL.createObjectURL(this.fileImage);
        },


        async show() {
            console.log(this.sanphamLocal);
        }
    }
};
</script>

<style>
/* @import '../../assets/QLSanPhamStyle.css' */
.createForm{
    position: absolute;
    width: 80%;
    background-color: aquamarine;

}

</style>