import Vue from "vue";
import Vuetify from "vuetify"; // 追加
import "vuetify/dist/vuetify.min.css"; // 追加
import App from "../app.vue";
import HomeContainer from "../components/home_container"

Vue.use(Vuetify); // 追加
const vuetify = new Vuetify(); // 追加

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    vuetify, // 追加
    render: h => h(HomeContainer)
  }).$mount();
  document.body.appendChild(app.$el);

  console.log(app);
});
