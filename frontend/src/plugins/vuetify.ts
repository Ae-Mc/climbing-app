import Vue from 'vue';
import { colors } from 'vuetify/lib';
import Vuetify from 'vuetify/lib/framework';

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    dark: false,
    themes: {
      light: {
        primary: '#385790',
        secondary: colors.blue
      },
      dark: {
        primary: '#385790',
      }
    }
  }
});
