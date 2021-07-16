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
                  name="username"
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
                  type="password"
                  required
                ></v-text-field>
              </validation-provider>
              <div v-if="errorText != null" class="error--text">
                {{ errorText }}
              </div>
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
import axios from "axios";

extend("required", { ...required, message: "{_field_} не может быть пустым" });

export default Vue.extend({
  data: () => ({
    username: "",
    email: "",
    password: "",
    errorText: null
  }),
  methods: {
    validate() {
      this.$refs.observer.validate();
    },
    submit() {
      axios
        .post(`${Vue.prototype.$hostname}/auth/token/login/`, {
          username: this.username,
          password: this.password
        })
        .then(response => {
          this.errorText = null;
          console.log(response);
        })
        .catch(error => {
          if (error.response) {
            this.errorText = "Не удалось войти с указанными данными";
            if (Vue.prototype.$debug) {
              console.log(error.response);
            }
          } else {
            this.errorText = "Ошибка подключения к серверу аутентификации";
          }
        });
    }
  },
  components: {
    ValidationProvider,
    ValidationObserver
  }
});
</script>
