import axios from 'axios';
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store';
import vuetify from './plugins/vuetify'

Vue.config.productionTip = false;
Vue.prototype.$debug = true;

axios.defaults.baseURL = "http://localhost:8000";
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
