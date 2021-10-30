import Vue from "vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from "../app.vue";
import HomeContainer from "../components/home_container"

Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    vuetify,
    render: h => h(HomeContainer)
  }).$mount();
  document.body.appendChild(app.$el);

  console.log(app);
});
