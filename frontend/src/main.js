import { createApp } from 'vue'
import App from './App.vue'
import { handle } from "./common/promise";
import "bootstrap/dist/css/bootstrap.min.css";
import "@fortawesome/fontawesome-free/css/all.min.css";
import router from "./router";
import store from './store';


createApp(App)
     .mixin({
          methods: {
               handle,
          }
     })
     .use(router)
     .use(store)
     .mount('#app');
