import VueRouter from 'vue-router';
import App from "./app";
import HomeContainerNew from "./components/home_container_new"

const routes = [
  {path: '/', component: HomeContainerNew},
  {payh: '/app', component: App}
]

export default new VueRouter({
  mode: 'history',
  routes
})