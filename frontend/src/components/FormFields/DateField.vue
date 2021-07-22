
<template>
  <v-menu
    :transition="transition"
    :close-on-content-click="false"
    :open-on-click="true"
    min-width="0"
    offset-y
  >
    <template v-slot:activator="{ on }">
      <validation-provider v-slot="{ errors }" :name="fieldName" :rules="rules">
        <v-text-field
          :label="label"
          :prepend-icon="icon"
          v-model="inputValue"
          v-on="{ ...listeners, ...on }"
          :error-messages="errors"
          :hide-details="hideDetails"
          v-bind="$attrs"
          readonly
        ></v-text-field>
      </validation-provider>
    </template>
    <v-date-picker v-model="inputValue" :min="min" :max="max"></v-date-picker>
  </v-menu>
</template>
<script lang="ts">
import BaseField from "@/components/FormFields/BaseField";
import Vue from "vue";

export default Vue.component("DateField", {
  mixins: [BaseField],
  props: {
    min: Date,
    max: Date,
    transition: {
      type: String,
      default: "slide-y"
    }
  }
});
</script>

