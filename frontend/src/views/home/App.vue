<template>
  <v-row justify="center">
    <v-col cols="12" lg="3"> </v-col>
    <v-col cols="12" lg="6">
      <v-layout fill-height class="pa-4">
        <router-view />
      </v-layout>
    </v-col>
    <v-col cols="12" lg="3"> </v-col>
  </v-row>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "MainApp"
});
</script>

