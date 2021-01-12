import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import "./main.css";
import VTooltip from "v-tooltip";
import axios from 'axios'
import VueAxios from 'vue-axios'

createApp(App)
  .use(router)
  .use(VTooltip)
  .use(VueAxios, axios)
  .mount("#app");
