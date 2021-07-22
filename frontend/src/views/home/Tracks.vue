<template>
  <v-card class="flex-grow-1 pa-2">
    <v-treeview
      :items="tracksList"
      dense
      hoverable
      open-on-click
      transition
      activatable
      :active.sync="treeViewActive"
    ></v-treeview>
    <center>
      <v-btn @click="$router.push('/tracks/new')">Добавить трассу</v-btn>
    </center>
  </v-card>
</template>

<script lang="ts">
import Vue from "vue";
import { mapGetters } from "vuex";

export default Vue.extend({
  name: "Tracks",

  data() {
    return {
      active: null
    };
  },

  mounted() {
    this.$store.dispatch("data/loadTracks");
  },

  computed: {
    ...mapGetters("data", ["tracksPerQuarters", "tracksYearQuarters"]),
    tracksList() {
      const result = this.tracksYearQuarters.map((quarter: string) => {
        return {
          name: quarter,
          children: this.tracksPerQuarters.get(quarter)
        };
      });
      return result;
    },
    treeViewActive: {
      get(): number[] | null {
        return [];
      },
      set(value: number[]) {
        // TODO: redirect to track page
        const trackId = value[0];
        console.log(`Redirect to tracks/${trackId}`);
      }
    }
  }
});
</script>
