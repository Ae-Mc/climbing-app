<template>
  <v-container class="center">
    <v-progress-circular indeterminate color="primary" v-if="loading" />
    <v-chip
      v-else-if="isError"
      class="error"
      filter-icon="mdi-reload"
      input-value="true"
      filter
      @click="loadCategories"
    >
      Не удалось загрузить категории
    </v-chip>
    <div v-else>
      <v-row
        v-for="i in ((categories.length / cols) | 0) +
        (categories.length % cols > 0 ? 1 : 0)"
        :key="i"
        justify="space-between"
      >
        <v-col v-for="j in cols" :key="j" :cols="undefined">
          <div v-if="(i - 1) * cols + j - 1 < categories.length">
            <v-card class="pa-1" rounded="xl">
              <center>{{ categories[(i - 1) * cols + j - 1].name }}</center>
            </v-card>
          </div>
          <div v-else />
        </v-col>
      </v-row>
    </div>
  </v-container>
</template>

<script lang="ts">
import Vue from "vue";
import axios from "axios";

export default Vue.extend({
  name: "Categories",
  data: () => ({
    categories: [],
    loading: true,
    isError: false
  }),
  mounted() {
    this.loadCategories();
  },
  computed: {
    cols() {
      const { md, lg, xl } = this.$vuetify.breakpoint;
      return xl ? 12 : lg ? 6 : md ? 7 : 5;
    }
  },
  methods: {
    loadCategories() {
      this.isError = false;
      this.loading = true;
      this.categories = [];
      axios
        .get(Vue.prototype.$hostname + "/api/categories")
        .then(response => {
          this.categories = response.data;
        })
        .catch(() => (this.isError = true))
        .finally(() => (this.loading = false));
    }
  }
});
</script>