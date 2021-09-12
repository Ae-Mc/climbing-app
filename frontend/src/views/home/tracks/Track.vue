<template>
  <v-card v-if="track == null" class="flex-grow-1">
    <v-card-title>Ошибка 404</v-card-title>
    <v-card-text>Трасса с ID {{ id }} не найдена</v-card-text>
  </v-card>
  <v-card v-else class="flex-grow-1">
    <v-card-title>Трасса «{{ track.name }}»</v-card-title>
    <v-card-subtitle>
      Загружена пользователем {{ track.uploader.username }}.
      <span> Создана {{ creationDate }} </span>
    </v-card-subtitle>
    <v-card-text>
      <h3>Автор</h3>
      {{ track.author }}
      <h3>Категория</h3>
      {{ track.category }}
      <h3>Описание</h3>
      {{ track.description }}
      <h3>Фотографии</h3>
      <v-card v-for="image in track.images" :key="image.image" tile outlined>
        <img :src="image.image" />
      </v-card>
    </v-card-text>
  </v-card>
</template>
<script lang="ts">
import FetchedTrack from "@/models/track/fetchedTrack";
import { data } from "@/store/modules/data";
import Vue from "vue";

export default Vue.extend({
  props: {
    id: Number
  },
  data() {
    return {
      track: null as null | FetchedTrack
    };
  },
  computed: {
    creationDate(): string {
      if (this.track)
        return new Date(this.track?.creationDate).toLocaleDateString();
      return "";
    }
  },
  mounted() {
    this.track = data.getters.track(this.id);
    if (!this.track) {
      data.actions
        .loadTracks()
        .then(() => (this.track = data.getters.track(this.id)));
    }
  },
  methods: {}
});
</script>
<style>
img {
  max-width: 100%;
  max-height: 100%;
  min-width: 100%;
  min-height: 100%;
  margin: 0;
  padding: 0;
}
</style>