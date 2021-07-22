import { createModule } from 'vuexok'
import axios from "axios";
import User from "@/models/user"

export const auth = createModule('auth', {
  namespaced: true,

  state: {
    status: {
      loggedIn: false
    },
    user: null as User | null,
  },

  actions: {
    async login(_, user: User): Promise<User> {
      try {
        const response = await axios.post('auth/token/login', {
          username: user.name, password: user.password
        }, { withCredentials: false });
        user.token = response.data.auth_token;
        delete user.password;
        auth.mutations.loginSuccess(user);
        return await Promise.resolve(user);
      } catch (error) {
        auth.mutations.loginFailure();
        return await Promise.reject(error);
      }
    },

    async logout(): Promise<void> {
      await axios.post('auth/token/logout');
      auth.mutations.logout();
    }
  },

  mutations: {
    loginSuccess(state, user: User): void {
      state.status.loggedIn = true;
      state.user = user;
      axios.defaults.headers.common['Authorization'] = `Token ${user.token}`;
    },
    loginFailure(state): void {
      state.status.loggedIn = false;
      state.user = null;
      delete axios.defaults.headers.common['Authorization'];
    },
    logout(state): void {
      state.status.loggedIn = false;
      state.user = null;
      delete axios.defaults.headers.common['Authorization'];
    }
  },
})