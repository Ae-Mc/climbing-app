<template>
  <v-card class="flex-grow-1" shaped id="addTrackCard" :loading="sending">
    <template slot="progress">
      <v-progress-linear indeterminate></v-progress-linear>
    </template>
    <validation-observer v-slot="{ invalid }" ref="observer">
      <v-form class="flex-grow-1" @submit.prevent="submit">
        <v-card-title>Добавление трассы</v-card-title>
        <v-card-text>
          <text-field
            field-name="Название"
            label="Название"
            icon="mdi-format-title"
            rules="required"
            v-model="name"
            required
          />
          <autocomplete-field
            field-name="Категория"
            label="Категория"
            icon="mdi-terrain"
            rules="requiredWomanSex"
            v-model="category"
            :items="categories"
            required
          />
          <text-field
            field-name="Автор"
            label="Автор"
            icon="mdi-account"
            rules="required"
            v-model="author"
            required
          />
          <textarea-field
            field-name="Описание"
            label="Описание"
            icon="mdi-text"
            rules="required"
            v-model="description"
            required
          />
          <date-field
            field-name="Дата создания"
            rules="requiredWomanSex"
            label="Дата создания трассы"
            v-model="creationDate"
            icon="mdi-calendar"
          />
          <validation-provider
            v-slot="{ errors }"
            name="Фотографии"
            rules="requiredMany|size50MB"
          >
            <v-file-input
              accept="image/*"
              label="Фотографии трассы"
              multiple
              chips
              show-size
              counter
              v-model="images"
              prepend-icon="mdi-camera-plus"
              @change="updateImages()"
              :error-messages="errors"
              hide-details="auto"
            />
          </validation-provider>
          <div class="mt-2">
            <v-progress-linear
              indeterminate
              rounded
              v-if="
                imagesSources.some((x) => x.length > 0) &&
                imagesSources.some((x) => x.length == 0)
              "
            />
          </div>
          <div
            v-if="
              imagesError == null && imagesSources.every((x) => x.length > 0)
            "
          >
            <div v-for="src in imagesSources" :key="src" class="mb-1">
              <img :src="src" />
            </div>
          </div>
          <span v-else class="error--text mt-4">{{ imagesError }}</span>
        </v-card-text>
        <v-card-actions>
          <v-btn type="submit" :disabled="invalid || sending">
            <template v-if="sending">
              <v-progress-circular indeterminate color="primary" />
            </template>
            <template v-else>Добавить</template>
          </v-btn>
          <v-btn @click="clear">Очистить</v-btn>
        </v-card-actions>
        <v-card-actions
          v-if="errors.length > 0"
          class="error--text pt-0"
          v-html="errors.join('<br />')"
        />
      </v-form>
    </validation-observer>
  </v-card>
</template>
<script lang="ts">
import Vue from "vue";
import { ValidationProvider, ValidationObserver } from "vee-validate";
import { addTrack } from "@/store/modules/addTrack";
import { data } from "@/store/modules/data";
import { auth } from "@/store/modules/auth";
import TextField from "@/components/FormFields/TextField.vue";
import AutocompleteField from "@/components/FormFields/AutocompleteField.vue";
import TextareaField from "@/components/FormFields/TextareaField.vue";
import DateField from "@/components/FormFields/DateField.vue";
import "@/utils/validation-rules";

export default Vue.extend({
  data() {
    return {
      datePickerActive: false,
      images: [] as File[],
      imagesSources: [] as string[],
      imagesError: null as null | string,
      errors: [] as string[],
      sending: false as boolean
    };
  },

  mounted() {
    data.actions.loadCategories();
    if (!addTrack.state.track.author && auth.state.user) {
      addTrack.mutations.setAuthor(auth.state.user?.name);
    }
  },

  computed: {
    categories: () => data.state.categories,
    name: {
      get: () => addTrack.state.track.name,
      set: addTrack.mutations.setName
    },
    category: {
      get: () => addTrack.state.track.category,
      set: addTrack.mutations.setCategory
    },
    author: {
      get: () => addTrack.state.track.author,
      set: addTrack.mutations.setAuthor
    },
    description: {
      get: () => addTrack.state.track.description,
      set: addTrack.mutations.setDescription
    },
    creationDate: {
      get: () => addTrack.state.track.creationDate || "",
      set: addTrack.mutations.setCreationDate
    }
  },

  methods: {
    refreshImagesPreview() {
      if (this.imagesSources.some(x => x.length == 0)) {
        setTimeout(() => this.refreshImagesPreview(), 100);
      } else {
        let temp = this.imagesSources;
        this.imagesSources = [];
        this.imagesSources = temp;
      }
    },
    updateImages() {
      this.imagesError = null;
      this.imagesSources = [];
      for (let i = 0; i < this.images.length; i++) {
        this.imagesSources.push("");
      }
      let readers = [] as FileReader[];

      for (let i = 0; i < this.images.length; i++) {
        readers.push(new FileReader());
        readers[readers.length - 1].onload = e => {
          if (typeof e.target?.result === "string") {
            this.imagesSources[i] = e.target.result;
          } else {
            this.imagesError =
              "Не удалось загрузить одно или несколько изображений";
          }
        };
        readers[readers.length - 1].readAsDataURL(this.images[i]);
      }
      this.refreshImagesPreview();
    },
    clear() {
      addTrack.mutations.clear();
      this.images = [];
      this.updateImages();
    },
    sendTrack() {
      this.errors = [];
      this.sending = true;
      addTrack.mutations.setImages(this.images);
      addTrack.actions
        .sendTrack()
        .then(() => {
          addTrack.mutations.clear();
          this.$router.push("/tracks");
        })
        .catch(error => {
          if (error.response) {
            this.errors.push(
              "Произошла ошибка при добавлении трассы. Код ошибки: " +
                error.response.status.toString()
            );
            console.log(error.response);
          } else {
            this.errors.push(
              "Произошла ошибка при добавлении трассы. Проверьте подключение к интернету"
            );
            console.log(error.request);
          }
          console.log(error.message);
        })
        .finally(() => (this.sending = false));
    },
    submit() {
      this.sendTrack();
    }
  },

  components: {
    ValidationProvider,
    ValidationObserver,
    TextField,
    AutocompleteField,
    TextareaField,
    DateField
  }
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