import { addTrack } from '@/store/modules/addTrack'
import { auth } from '@/store/modules/auth'
import { data } from '@/store/modules/data'

import Vue from 'vue'
import Vuex, { Module } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

const store = new Vuex.Store({
  strict: true,
  plugins: [createPersistedState()]
})

const storeState = store.state as {
  auth?: Module<1, 2>, data?: Module<1, 2>, addTrack?: Module<1, 2>
};

auth.register(store, { preserveState: !!storeState.auth })
data.register(store, { preserveState: !!storeState.data })
addTrack.register(store, { preserveState: !!storeState.addTrack })

export default store;