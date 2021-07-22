<template>
  <v-layout fill-height>
    <v-row align="center" justify="center">
      <v-card>
        <v-card-title>Вход</v-card-title>
        <v-card-text>
          <validation-observer v-slot="{ invalid }" ref="observer">
            <v-form @submit.prevent="validate">
              <text-field
                v-model="user.name"
                field-name="Имя пользователя"
                rules="required"
                icon="mdi-account"
                label="Имя пользователя"
                name="username"
                :hide-details="false"
                required
              ></text-field>
              <text-field
                v-model="user.password"
                field-name="Пароль"
                rules="required"
                icon="mdi-lock"
                label="Пароль"
                type="password"
                :hide-details="false"
                required
              ></text-field>
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
import User from "@/models/user";
import TextField from "@/components/FormFields/TextField.vue";
import { ValidationObserver } from "vee-validate";
import { auth } from "@/store/modules/auth";
import "@/utils/validation-rules";

export default Vue.extend({
  data: () => ({
    user: new User(),
    errorText: null
  }),
  methods: {
    validate() {
      this.$refs.observer.validate();
    },
    submit() {
      auth.actions
        .login(this.user)
        .then(() => {
          this.$router.push("/");
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
    ValidationObserver,
    TextField
  }
});
</script>
