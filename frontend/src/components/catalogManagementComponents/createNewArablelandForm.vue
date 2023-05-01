<template>
     <Form @submit="newarableLand.close = true, $emit('addArableLand-submit', newarableLand)" :validation-schema="schema"
          class="form container-fluid createArableLandForm ">
          <div class="row">
               <div class="col-sm-12 text-right">
                    <i class="fas fa-times-circle"
                         @click="newarableLand.close = false, $emit('addArableLand-submit', newarableLand)"
                         style="font-size: 25px; padding-top:-5px; color:#B3B4BA;"></i>
               </div>
          </div>
          <div class="row">
               <p class="col-sm-12 text-center functionName">THÊM MẪU RUỘNG MỚI</p>
          </div>
          <div class="row content">
               <div class="col-sm-6 mt-2">
                    <div class="form-group">
                         <label for="id" class="mt-2">Mã mẫu ruộng <span style="color: red">*</span></label>
                         <Field name="id" type="name" class="form-control" v-model="newarableLand.ArableLand_id"
                              placeholder="Nhập mã mẫu ruộng..." />
                         <ErrorMessage name="id" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="area" class="mt-3">Diện tích (đơn vị ha) <span style="color: red">*</span></label>
                         <Field name="area" class="form-control" v-model="newarableLand.ArableLand_area"
                              placeholder="Diện tích..." />
                         <ErrorMessage name="area" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="soil" class="mt-3">Phân loại <span style="color: red">*</span></label>
                         <Field name="soil" v-model="newarableLand.Soil_name" style="width: 100%; position: relative;">
                              <select class="form-control" v-model="newarableLand.Soil_name" name="soil" for="soil"
                                   style="background: #FAFAFC;box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);  width: 100%;">
                                   <option v-for="(soil, i) in soillist" :key="i">{{ soil.Soil_name }}</option>
                              </select>
                         </Field>
                         <ErrorMessage name="soil" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="owner" class="">Chủ sở hữu <span style="color: red">*</span></label>
                         <Field name="owner" class="form-control" v-model="newarableLand.ArableLand_owner"
                              placeholder="Chủ sở hữu..." />
                         <ErrorMessage name="owner" class="error-feedback" />
                    </div>
               </div>
               <div class="col-sm-6">

                    <div class="form-group">
                         <label for="latitude" class="mt-3">Vĩ độ <span style="color: red">*</span> </label>
                         <Field name="latitude" class="form-control" v-model="newarableLand.ArableLand_latitude"
                              placeholder="Vĩ độ..." />
                         <span class="btn btnlocation" @click="getLocation(), searching = true;"><i
                                   class="fas fa-map-marker-alt" v-if=" !searching "></i> Vị trí hiện tại
                              <span v-show=" searching " class="spinner-border spinner-border-sm"></span></span>
                         <ErrorMessage name="latitude" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="longitude" class="mt-3">Kinh độ <span style="color: red">*</span></label>
                         <Field name="longitude" class="form-control" v-model=" newarableLand.ArableLand_longitude "
                              placeholder="Kinh độ..." />
                         <span class="btn btnlocation2" @click=" getLocation(), searching = true; "><i
                                   class="fas fa-map-marker-alt" v-if=" !searching "></i> Vị trí hiện tại
                              <span v-show=" searching " class="spinner-border spinner-border-sm"></span></span>
                         <ErrorMessage name="longitude" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="province" class="mt-3">Tỉnh<span style="color: red">*</span></label>
                         <Field name="province" v-model=" newarableLand.Province_name "
                              style="width: 100%; position: relative;">
                              <select class="form-control" v-model=" newarableLand.Province_name " name="province"
                                   for="province" @change=" select() " style=" width: 100%;">
                                   <option
                                        v-for="(              province, i              ) in               provincelist              "
                                        :key=" i ">
                                        {{
                                        province.Province_name
                                        }}
                                   </option>
                              </select>
                         </Field>
                         <ErrorMessage name="province" class="error-feedback" />
                    </div>

                    <div class="form-group">
                         <label for="location" class="">Vị trí mẫu ruộng <span style="color: red">*</span></label>
                         <Field name="location" class="form-control" v-model=" newarableLand.ArableLand_location "
                              placeholder="Nhập vị trí mẫu ruộng..." />
                         <ErrorMessage name="location" class="error-feedback" />
                    </div>
               </div>
          </div>

          <Gmap-Map ref="myMapRef" :center="center" :zoom=" zoom " style="width: 100%; height: 600px">
               <GMapHeatmap :data=" heatData "></GMapHeatmap>
          </Gmap-Map>

          <!-- <GmapAutocomplete id="auto_complete_map" ref="location" v-validate=" 'required|min:5' " class="form-control"
               name="location" :value=" location " :placeholder=" $t('enter a location') " aria-required="true"
               :disabled=" $parent.canEditProperty() " @place_changed=" setPlace " @keydown.enter.prevent />
          <has-error :form=" form " field="auto_complete_map" />
          <GmapMap ref="map" class="my-3" :center=" center " :zoom=" zoom " style="width: 100%; height: 300px"
               @click=" clickMap ">
               <GmapMarker v-for="(     m, index     ) in      markers     " :key=" index " :position=" m.position "
                    @click=" center = m.position " />
          </GmapMap> -->
          <div class="row ">
               <div class="col-sm-12 mt-2 mb-3 text-center">
                    <span v-if=" message2 == 'Thêm thành công.' " class="fas fa-check-circle"
                         style="color:#00BA13; text-align: center; display: inline;"></span>
                    <span v-if=" message1 == 'Thêm không thành công.' " class="fas fa-times-circle"
                         style="color:red; text-align: center; display: inline;"></span>
                    <span v-if=" message2 == 'Thêm thành công.' " class="textMessage2 mt-2 mb-2" style="color:black;">
                         Thêm thông tin mẫu ruộng thành công</span>
                    <span v-if=" message1 == 'Thêm không thành công.' " class="textMessage1 pt-2 pb-2"> Thêm thông tin
                         mẫu
                         ruộng không thành công
                    </span>
               </div>
          </div>
          <div class="row mb-4">
               <div class="col-sm-12 text-center">
                    <button class="btn btn-outline-secondary btnLuu col-sm-2">Lưu</button>
               </div>
          </div>

     </form>
</template>
 
<script>
import { ref, watch } from "vue";
// import { setupContainsLatLng } from '../util/is-point-within-polygon.js'
import * as yup from "yup";
import { Form, Field, ErrorMessage } from "vee-validate";
// import VueGoogleMaps from '@fawmi/vue-google-maps'
// import { setupContainsLatLng } from './setupContainsLatLng';
export default {
     name: "createArableLandForm",
     components: {
          Form,
          Field,
          ErrorMessage,
     },
     emits: ["addArableLand-submit"],
     props: ["newArableLand", "message1", "message2", "provinceList", "soilList"],
     mounted() {
          let recaptchaScript = document.createElement('script')
          recaptchaScript.setAttribute('src', 'https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap')
          document.head.appendChild(recaptchaScript)
          this.geolocate();

     },
     data() {

          const schema = yup.object().shape({
               id: yup
                    .string()
                    .required("Mã mẫu ruộng phải có giá trị")
                    .min(10, "Mã phải gồm 10 ký tự")
                    .max(10, "Mã mẫu ruộng phải gồm 10 ký tự"),
               location: yup
                    .string()
                    .required("Vị trí mẫu ruộng phải có giá trị"),
               area: yup
                    .number()
                    .required("Diện tích mẫu ruộng phải có giá trị"),
               owner: yup
                    .string()
                    .required("Chủ sở hữu mẫu ruộng phải có giá trị"),
               soil: yup
                    .string()
                    .required("Loại đất phải có giá trị"),
               latitude: yup
                    .string()
                    .required("Vĩ độ của mẫu ruộng phải có giá trị"),
               longitude: yup
                    .string()
                    .required("Kinh độ của mẫu ruộng phải có giá trị"),
               province: yup
                    .string()
                    .required("Tỉnh phải được chọn"),
          });
          return {
               newarableLand: this.newArableLand,
               provincelist: this.provinceList,
               soillist: this.soilList,
               searching: false,
               schema,

          };
     },
     setup() {
    const center = {lat: 52.2985593, lng: 104.2455337}
    const zoom = 12
    const myMapRef = ref();
    const heatData = ref([])
    const google=window.google;
    watch(myMapRef, googleMap => {
      if (googleMap) {
          this.$refs.myMapRef.$mapPromise.then(()=> {
          heatData.value = [
            {location: new google.maps.LatLng({lat: 52.2985593, lng: 104.2455337})},
          ];
        })
      }
    });

    return {
      center,
      zoom,
      heatData,
      myMapRef
    }
  },
     methods: {
          // setPlace(place) {
          //      this.markers.splice(0, this.markers.length);
          //      this.places.splice(0, this.places.length);
          //      this.currentPlace = place;
          //      this.updateLocation(place.formatted_address);

          //      this.addMarker();
          // },

          // addMarker() {
          //      if (this.currentPlace) {
          //           const marker = {
          //                lat: this.currentPlace.geometry.location.lat(),
          //                lng: this.currentPlace.geometry.location.lng(),
          //           };

          //           this.markers.push({ position: marker });
          //           this.places.push(this.currentPlace);
          //           this.center = marker;
          //           this.zoom = 17;
          //           this.currentPlace = null;
          //      }
          // },
          // clickMap(location) {
          //      const marker = location.latLng;
          //      // this.markers.clear()
          //      this.markers.splice(0, this.markers.length);
          //      this.places.splice(0, this.places.length);
          //      this.markers.push({ position: marker });
          //      // this.places.push(this.currentPlace)
          //      // this.center = marker
          //      // this.zoom = 17
          //      this.currentPlace = null;
          //      const geocoder = new google.maps.Geocoder();
          //      geocoder
          //           .geocode({ location: location.latLng })
          //           .then((response) => {
          //                if (response.results[0]) {
          //                     this.updateLocation(response.results[0].formatted_address);
          //                     this.getLoc(location.latLng);
          //                } else {
          //                     window.alert("No results found");
          //                }
          //           })
          //           .catch((e) => window.alert("Geocoder failed due to: " + e));
          // },

          // geolocate: function () {
          //      const oldLocation = this.location;
          //      if (oldLocation.length > 0) {
          //           const _this = this;
          //           const geocoder = new google.maps.Geocoder();
          //           geocoder.geocode({ address: oldLocation }, function (results, status) {
          //                if (status == google.maps.GeocoderStatus.OK) {
          //                     // const lat = results[0].geometry.location.lat()
          //                     // const lng = results[0].geometry.location.lng()
          //                     // const placeName = results[0].address_components[0].long_name
          //                     if (results.length > 0) {
          //                          _this.setPlace(results[0]);
          //                     }
          //                }
          //           });
          //      } else {
          //           navigator.geolocation.getCurrentPosition((position) => {
          //                this.center = {
          //                     lat: position.coords.latitude,
          //                     lng: position.coords.longitude,
          //                };
          //           });
          //      }
          // },

          // updateLocation: function (newLocation) {
          //      this.location = newLocation;
          //      this.$emit("eventname", newLocation);
          // },
          // getLoc: function (location) {
          //      // this.location =  this.markers
          //      this.longitude = location.lng();
          //      this.latitude = location.lat();
          //      this.$emit("getlog", location);
          // },

          select() {
               console.log(this.newarableLand.Province_id)
          },
          getLocation() {
               if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(this.showPosition);
               } else {
                    console.log("Geolocation is not supported by this browser.");
               }
          },
          showPosition(position) {
               this.searching = true;
               setTimeout(() => {
                    this.newarableLand.ArableLand_latitude = position.coords.latitude;
                    this.newarableLand.ArableLand_longitude = position.coords.longitude;
                    this.searching = false;
               }, 2000);
          }
     }
};
</script>
 
<style>
@import url(../../assets/arablelandStyle.css);

.btnlocation {
     border-radius: 10px !important;
     background: none;
     /* box-shadow: 0px 7px 7px rgba(0, 0, 0, 0.25); */
     font-size: 16px !important;
     font-family: 'Roboto';
     font-weight: 500 !important;
     border: none;
     color: #008B8E;
     position: absolute;
     top: 50px;
     left: 75%;
     z-index: 3;
}

.btnlocation2 {
     border-radius: 10px !important;
     background: none;
     /* box-shadow: 0px 7px 7px rgba(0, 0, 0, 0.25); */
     font-size: 16px !important;
     font-family: 'Roboto';
     font-weight: 500 !important;
     border: none;
     color: #008B8E;
     position: absolute;
     top: 140px;
     left: 75%;
     z-index: 3;
}

@media only screen and (max-width: 990px) {
     .btnlocation {
          border-radius: 10px !important;
          background: none;
          /* box-shadow: 0px 7px 7px rgba(0, 0, 0, 0.25); */
          font-size: 16px !important;
          font-family: 'Roboto';
          font-weight: 500 !important;
          border: none;
          color: #008B8E;
          position: absolute;
          top: 50px;
          left: 62% !important;
          z-index: 3;
     }
}

@import url(../../assets/mainStyle.css);
</style>
