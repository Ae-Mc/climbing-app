import mutations from '@/store/mutations'
import axios from "axios";
import User from "@/models/user"

export const auth = {
  namespaced: true,

  state: {
    status: {
      loggedIn: false
    },
    user: null,
  },

  actions: {
    async login({ commit }: any, user: User) {
      try {
        const response = await axios.post('auth/token/login', {
          username: user.name, password: user.password
        }, { withCredentials: false });
        user.token = response.data.auth_token;
        delete user.password;
        commit(mutations.LOGIN_SUCCESS, user);
        return await Promise.resolve(user);
      } catch (error) {
        commit(mutations.LOGIN_FAILURE);
        return await Promise.reject(error);
      }
    },

    async logout({ commit }: any) {
      await axios.post('auth/token/logout');
      commit(mutations.LOGOUT);
    }
  },

  mutations: {
    [mutations.LOGIN_SUCCESS](state: any, user: User) {
      state.status.loggedIn = true;
      state.user = user;
      axios.defaults.headers.common['Authorization'] = `Token ${user.token}`;
    },
    [mutations.LOGIN_FAILURE](state: any) {
      state.status.loggedIn = false;
      state.user = null;
      delete axios.defaults.headers.common['Authorization'];
    },
    [mutations.LOGOUT](state: any): void {
      state.status.loggedIn = false;
      state.user = null;
      delete axios.defaults.headers.common['Authorization'];
    }
  },
}