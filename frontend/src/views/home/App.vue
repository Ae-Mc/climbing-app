<template>
  <v-layout fill-height class="pa-4">
    <v-row justify="center">
      <router-view />
    </v-row>
  </v-layout>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "MainApp"
});
</script>

