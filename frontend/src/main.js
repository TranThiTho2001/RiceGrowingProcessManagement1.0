import { createApp } from 'vue'
import App from './App.vue'
import { handle } from "./common/promise";
import "bootstrap/dist/css/bootstrap.min.css";
import bootstrap from 'bootstrap';
import "@fortawesome/fontawesome-free/css/all.min.css";
import Dropdown from 'bootstrap';"vue-simple-search-dropdown/dist/vue-simple-search-dropdown.min.js"
import router from "./router";
import store from "./store";
import  VueGoogleMaps from '@fawmi/vue-google-maps'

createApp(App)
    .mixin({
        methods: {
            handle,
        }
    })
    .use(store)
    .use(router)
    .use(Dropdown)
    .use(bootstrap)
    .use(VueGoogleMaps, {
        load: {
            key: 'AIzaSyDO2_uZUeRlDyBZmuYBByCne7KW4SzAj8s',
            libraries: "visualization",
        },

    })
    .mount('#app');

