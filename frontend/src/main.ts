import axios from 'axios';
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store';
import vuetify from './plugins/vuetify'

Vue.config.productionTip = false;
Vue.prototype.$debug = false;

axios.defaults.baseURL = Vue.prototype.$debug ? "http://192.168.1.2:8000" : "https://climbing.ae-mc.ru";
axios.defaults.withCredentials = true;
axios.defaults.headers.post = {
  'Content-Type': 'multipart/form-data'
}

new Vue({
  router,
  vuetify,
  store: store,
  render: h => h(App)
}).$mount('#app')
