<template>
  <v-layout fill-height>
    <v-row align="center" justify="center">
      <validation-observer v-slot="{ invalid }" ref="observer">
        <v-form @submit.prevent="validate" @submit="submit">
          <v-card>
            <v-card-title>Регистрация</v-card-title>
            <v-card-text>
              <text-field
                v-model="user.name"
                icon="mdi-account"
                label="Имя пользователя"
                rules="required"
                required
              />
              <text-field
                v-model="user.password"
                icon="mdi-lock"
                label="Пароль"
                :rules="'required|passwordMatch:' + password2"
                type="password"
                required
              />
              <text-field
                v-model="password2"
                icon="mdi-lock"
                label="Повтор пароля"
                :rules="'required|passwordMatch:' + user.password"
                type="password"
                required
              />
            </v-card-text>
            <v-card-text class="py-0">
              <div
                v-if="errors.length > 0"
                class="error--text pb-4"
                v-html="errors.join('<br>')"
              ></div>
            </v-card-text>
            <v-card-actions>
              <v-btn type="submit" :disabled="invalid">
                Зарегестрироваться
              </v-btn>
              <v-btn @click.stop="$router.push('/login')"> Войти </v-btn>
            </v-card-actions>
          </v-card>
        </v-form>
      </validation-observer>
    </v-row>
  </v-layout>
</template>
<script lang="ts">
import Vue from "vue";
import { extend, ValidationObserver } from "vee-validate";
import { is, required } from "vee-validate/dist/rules";
import TextField from "@/components/FormFields/TextField.vue";
import { auth } from "@/store/modules/auth";
import User from "@/models/user";
import "@/utils/validation-rules";

extend("passwordMatch", {
  ...is,
  message: "Пароли не совпадают"
});

export default Vue.extend({
  data() {
    return {
      user: new User(),
      password2: "",
      errors: [] as string[]
    };
  },
  computed: {},
  methods: {
    validate() {
      (this.$refs.observer as InstanceType<
        typeof ValidationObserver
      >).validate();
    },
    submit() {
      this.errors = [];
      auth.actions
        .register(this.user)
        .then(() => this.$router.push({ name: "Login" }))
        .catch(error => {
          console.log(error);
          console.log(error.response);
          if (error.response) {
            console.log(error.response.data);
            if (error.response.status === 400) {
              if (error.response.data.username) {
                this.errors = this.errors.concat(error.response.data.username);
              }
              if (error.response.data.password) {
                this.errors = this.errors.concat(error.response.data.password);
              }
            } else {
              this.errors = [
                `Неизвестная ошибка. Код ошибки: ${error.response.status}`
              ];
            }
          } else {
            this.errors = ["Проверьте соединение с сетью!"];
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

