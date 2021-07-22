<template>
  <v-app>
    <v-app-bar color="primary" app dark dense>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      <v-app-bar-title>Скалолазание ИТМО</v-app-bar-title>
      <v-spacer />
      <div v-if="status.loggedIn">
        <span
          >Вы вошли как <b>{{ user.name }}</b></span
        >
        <v-icon @click="logout" class="ml-4"> mdi-logout </v-icon>
      </div>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer" app>
      <v-list dense nav>
        <v-list-item link to="/tracks">
          <v-list-item-icon><v-icon large>mdi-home</v-icon></v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title> Главная </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item link to="/categories">
          <v-list-item-icon>
            <v-icon large>mdi-format-list-bulleted</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title> Категории </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item link to="/about">
          <v-list-item-icon
            ><v-icon large>mdi-information</v-icon></v-list-item-icon
          >
          <v-list-item-content>
            <v-list-item-title> О сайте </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
      <v-list dense nav slot="append">
        <v-list-item link to="/login" v-if="!status.loggedIn">
          <v-list-item-icon>
            <v-icon large>mdi-account-circle</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title> Вход </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <!-- <v-list-item link to="/register" v-if="!status.loggedIn">
          <v-list-item-icon>
            <v-icon large>mdi-account-plus</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title> Регистрация </v-list-item-title>
          </v-list-item-content>
        </v-list-item> -->
      </v-list>
    </v-navigation-drawer>

    <v-main>
      <router-view />
    </v-main>

    <v-footer app dark color="primary" inset>
      <v-col class="text-center">
        &copy; 2021 <strong>Александр Макурин</strong> (aka Ae_Mc)
      </v-col>
    </v-footer>
  </v-app>
</template>

<script lang="ts">
import axios from "axios";
import Vue from "vue";
import { mapState } from "vuex";
import { auth } from "./store/modules/auth";

export default Vue.extend({
  name: "RootApp",
  computed: mapState("auth", {
    status: "status",
    user: "user"
  }),
  data: () => ({
    drawer: false
  }),
  mounted() {
    if (this.status.loggedIn) {
      axios.defaults.headers.common[
        "Authorization"
      ] = `Token ${this.user.token}`;
    }
  },
  methods: {
    logout() {
      auth.actions.logout().then(() => {
        if (this.$router.currentRoute.meta?.requiresAuth) {
          this.$router.push("/login");
        }
      });
    }
  }
});
</script>
