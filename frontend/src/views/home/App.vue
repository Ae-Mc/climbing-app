<template>
  <v-layout fill-height>
    <v-app-bar color="primary" app dark dense>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      <v-app-bar-title>Скалолазание ИТМО</v-app-bar-title>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer" app>
      <v-list dense nav>
        <v-list-item link>
          <v-list-item-icon
            ><v-icon large>mdi-account</v-icon></v-list-item-icon
          >
          <v-list-item-content>
            <v-list-item-title> login </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
      <v-list dense nav slot="append">
        <v-list-item link>
          <v-list-item-icon
            ><v-icon large>mdi-account</v-icon></v-list-item-icon
          >
          <v-list-item-content>
            <v-list-item-title> Login </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-main>
      <v-row class="fill-height">
        <v-col sm="2" cols="12"></v-col>
        <v-col cols="12" sm="8">
          <router-view />
        </v-col>
        <v-col sm="2" cols="12"></v-col>
      </v-row>
    </v-main>
  </v-layout>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "MainApp",

  data: () => ({
    drawer: true
  })
});
</script>

