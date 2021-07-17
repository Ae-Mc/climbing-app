import axios from 'axios'
import mutations from './../mutations'

export const data = {
  namespaced: true,

  state: {
    categories: null
  },

  actions: {
    async loadCategories({ commit }: { commit: any }): Promise<void> {
      const response = await axios.get('api/categories')
      commit(mutations.SET_CATEGORIES, response.data);
    }
  },

  mutations: {
    [mutations.SET_CATEGORIES](
      state: { categories: Iterable<string> | null },
      categories: Iterable<string>
    ): void {
      state.categories = categories;
    }
  }
}