import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import "./main.css";
import VTooltip from "v-tooltip";

createApp(App)
  .use(router)
  .use(VTooltip)
  .mount("#app");
