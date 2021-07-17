import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import { auth } from './modules/auth'
import { data } from './modules/data'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: { auth, data },
  plugins: [createPersistedState()]
})