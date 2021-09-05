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
import { data } from "@/store/modules/data";
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
    data.actions.loadTracks();
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
        const trackId = value[0];
        this.$router.push({
          name: "Track",
          params: { id: trackId.toString() }
        });
      }
    }
  }
});
</script>
