<template>
  <validation-provider v-slot="{ errors }" :name="fieldName" :rules="rules">
    <v-text-field
      :label="label"
      :prepend-icon="icon"
      v-model="inputValue"
      v-on="listeners"
      :error-messages="errors"
      :hide-details="hideDetails"
      v-bind="$attrs"
      :type="type"
    ></v-text-field>
  </validation-provider>
</template>
<script lang="ts">
import BaseField from "@/components/FormFields/BaseField";
import Vue from "vue";

export default Vue.component("TextField", {
  mixins: [BaseField],
  props: {
    type: String
  }
});
</script>