<template>
  <v-card class="flex-grow-1" shaped id="addTrackCard">
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
          <textarea-field
            field-name="Описание"
            label="Описание"
            icon="mdi-text"
            rules="required"
            v-model="description"
            required
          >
          </textarea-field>
          <date-field
            field-name="Дата создания"
            rules="requiredWomanSex"
            label="Дата создания трассы"
            v-model="creationDate"
            icon="mdi-calendar"
          ></date-field>
          <validation-provider
            v-slot="{ errors }"
            name="Фотографии"
            rules="requiredMany"
          >
            <v-file-input
              accept="image/*"
              label="Фотографии трассы"
              multiple
              chips
              v-model="images"
              prepend-icon="mdi-camera-plus"
              @change="updateImages()"
              :error-messages="errors"
              hide-details="auto"
            ></v-file-input>
          </validation-provider>

          <div v-if="imagesError == null">
            <v-card
              tile
              v-for="src in imagesSources"
              :key="src"
              class="mb-4"
              outlined
            >
              <v-img :src="src" />
            </v-card>
          </div>
          <span v-else class="error--text mt-4">{{ imagesError }}</span>
        </v-card-text>
        <v-card-actions>
          <v-btn type="submit" @click.stop="submit" :disabled="invalid">
            Добавить
          </v-btn>
          <v-btn @click="clear">Очистить</v-btn>
        </v-card-actions>
      </v-form>
    </validation-observer>
  </v-card>
</template>
<script lang="ts">
import Vue from "vue";
import { ValidationProvider, ValidationObserver } from "vee-validate";
import { addTrack } from "@/store/modules/addTrack";
import { data } from "@/store/modules/data";
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
      imagesError: null as null | string
    };
  },

  mounted() {
    data.actions.loadCategories();
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
    updateImages() {
      this.imagesError = null;
      this.imagesSources = [];
      let readers = [] as FileReader[];

      for (let i = 0; i < this.images.length; i++) {
        readers.push(new FileReader());
        readers[readers.length - 1].onload = e => {
          if (typeof e.target?.result === "string") {
            this.imagesSources.push(e.target.result);
          } else {
            this.imagesError =
              "Не удалось загрузить одно или несколько изображений";
          }
        };
        readers[readers.length - 1].readAsDataURL(this.images[i]);
      }
    },
    clear() {
      addTrack.mutations.clear();
      this.images = [];
      this.updateImages();
    },
    sendTrack() {
      addTrack.actions
        .sendTrack(this.images)
        .then(() => {
          addTrack.mutations.clear();
          this.$router.push("/tracks");
        })
        .catch(error => {
          console.log(error.response);
          console.log(error.request);
          console.log(error.message);
        });
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
    Autocomplete