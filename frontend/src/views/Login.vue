<template>
  <v-layout fill-height>
    <v-row align="center" justify="center">
      <v-card>
        <v-card-title>Вход</v-card-title>
        <v-card-text>
          <validation-observer v-slot="{ invalid }" ref="observer">
            <v-form @submit.prevent="validate">
              <validation-provider
                v-slot="{ errors }"
                name="Имя пользователя"
                rules="required"
              >
                <v-text-field
                  v-model="username"
                  prepend-icon="mdi-account"
                  label="Имя пользователя"
                  :error-messages="errors"
                  dense
                  required
                ></v-text-field>
              </validation-provider>
              <validation-provider
                v-slot="{ errors }"
                name="Email"
                rules="required"
              >
                <v-text-field
                  v-model="email"
                  prepend-icon="mdi-email"
                  label="Email"
                  :error-messages="errors"
                  dense
                  required
                ></v-text-field>
              </validation-provider>
              <validation-provider
                v-slot="{ errors }"
                name="Пароль"
                rules="required"
              >
                <v-text-field
                  v-model="password"
                  prepend-icon="mdi-lock"
                  label="Пароль"
                  :error-messages="errors"
                  dense
                  required
                ></v-text-field>
              </validation-provider>
              <v-btn
                @click.stop="submit"
                type="submit"
                class="mr-4 mt-4"
                :disabled="invalid"
              >
                Войти
              </v-btn>
              <v-btn @click.stop="$router.push('/register')" class="mt-4">
                Зарегестрироваться
              </v-btn>
            </v-form>
          </validation-observer>
        </v-card-text>
      </v-card>
    </v-row>
  </v-layout>
</template>
<script>
import Vue from "vue";
import { extend, ValidationProvider, ValidationObserver } from "vee-validate";
import { required } from "vee-validate/dist/rules";

extend("required", { ...required, message: "{_field_} не может быть пустым" });

export default Vue.extend({
  data: () => ({
    username: "",
    email: "",
    password: ""
  }),
  methods: {
    validate() {
      console.log(this.$refs.observer.validate());
      console.log("Validate");
    },
    submit() {
      alert("Submit");
    }
  },
  components: {
    ValidationProvider,
    ValidationObserver
  }
});
</script>
