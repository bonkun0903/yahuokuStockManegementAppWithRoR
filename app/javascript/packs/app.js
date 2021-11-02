import Vue from "vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from "../app.vue";
import HomeContainerNew from "../components/home_container_new"
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify);
const vuetify = new Vuetify({
  icons: {
    iconfont: 'mdi'
  }
});

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    vuetify,
    render: h => h(HomeContainerNew)
  }).$mount();
  document.body.appendChild(app.$el);
});
