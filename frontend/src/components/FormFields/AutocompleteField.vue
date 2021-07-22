<template>
  <validation-provider v-slot="{ errors }" :name="fieldName" :rules="rules">
    <v-autocomplete
      :items="items"
      :label="label"
      :prepend-icon="icon"
      v-model="inputValue"
      v-on="listeners"
      :error-messages="errors"
      :hide-details="hideDetails"
      v-bind="$attrs"
    ></v-autocomplete>
  </validation-provider>
</template>
<script lang="ts">
import BaseField from "@/components/FormFields/BaseField";
import Vue from "vue";

export default Vue.component("AutocompleteField", {
  mixins: [BaseField],
  props: {
    items: Array
  }
});
</script>