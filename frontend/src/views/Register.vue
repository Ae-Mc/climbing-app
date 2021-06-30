<template>
  <v-layout fill-height>
    <v-row align="center" justify="center">
      <v-card>
        <v-card-title>Регистрация</v-card-title>
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
                  required
                ></v-text-field>
              </validation-provider>
              <validation-provider
                v-slot="{ errors }"
                name="Пароль"
                :rules="'required|passwordMatch:' + password2"
              >
                <v-text-field
                  v-model="password"
                  prepend-icon="mdi-lock"
                  label="Пароль"
                  :error-messages="errors"
                  type="password"
                  required
                />
              </validation-provider>
              <validation-provider
                v-slot="{ errors }"
                name="Повтор пароля"
                :rules="'required|passwordMatch:' + password"
              >
                <v-text-field
                  v-model="password2"
                  prepend-icon="mdi-lock"
                  label="Повтор пароля"
                  type="password"
                  :error-messages="errors"
                  required
                />
              </validation-provider>
              <v-btn
                @click.stop="submit"
                type="submit"
                class="mr-4 mt-4"
                :disabled="invalid"
              >
                Зарегестрироваться
              </v-btn>
              <v-btn @click.stop="$router.push('/login')" class="mt-4">
                Войти
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
import { is, required } from "vee-validate/dist/rules";

extend("required", { ...required, message: "{_field_} не может быть пустым" });
extend("passwordMatch", {
  ...is,
  message: "Пароли не совпадают"
});

export default Vue.extend({
  data: () => ({
    username: "",
    email: "",
    password: "",
    password2: ""
  }),
  computed: {},
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

