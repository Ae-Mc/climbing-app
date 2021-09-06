<template>
  <v-layout fill-height>
    <v-row align="center" justify="center">
      <validation-observer v-slot="{ invalid }" ref="observer">
        <v-form @submit.prevent="validate" @submit="submit">
          <v-card>
            <v-card-title>Вход</v-card-title>
            <v-card-text>
              <text-field
                v-model="user.name"
                rules="required"
                icon="mdi-account"
                label="Имя пользователя"
                name="username"
                required
              ></text-field>
              <text-field
                v-model="user.password"
                rules="required"
                icon="mdi-lock"
                label="Пароль"
                type="password"
                required
              ></text-field>
              <div v-if="errorText != null" class="error--text">
                {{ errorText }}
              </div>
            </v-card-text>
            <v-card-actions>
              <v-btn type="submit" :disabled="invalid"> Войти </v-btn>
              <v-btn @click.stop="$router.push('/register')">
                Зарегестрироваться
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-form>
      </validation-observer>
    </v-row>
  </v-layout>
</template>
<script lang="ts">
import Vue from "vue";
import User from "@/models/user";
import TextField from "@/components/FormFields/TextField.vue";
import { ValidationObserver } from "vee-validate";
import { auth } from "@/store/modules/auth";
import "@/utils/validation-rules";

export default Vue.extend({
  data: () => ({
    user: new User(),
    errorText: null as null | string
  }),

  methods: {
    validate() {
      (this.$refs.observer as InstanceType<
        typeof ValidationObserver
      >).validate();
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
