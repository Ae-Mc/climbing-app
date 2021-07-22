import FetchedTrack from '@/models/track/fetchedTrack'; '@/models/track/fetchedTrack';
import axios from 'axios'
import { createModule } from 'vuexok';

export const data = createModule('data', {
  namespaced: true,

  state: {
    categories: null as null | string[],
    tracks: null as null | FetchedTrack[]
  },

  actions: {
    async loadCategories() {
      const response = await axios.get('api/categories');
      data.mutations.setCategories(response.data.map((e: { id: number, name: string }) => e.name));
    },
    async loadTracks() {
      const response = await axios.get('api/tracks');
      data.mutations.setTracks(response.data);
    }
  },

  getters: {
    tracksYearQuarters(state): string[] {
      if (state.tracks) {
        return Array.from(new Set(state.tracks.map((track) => FetchedTrack.quarterDate(track))));
      } else {
        return [];
      }
    },
    tracksPerQuarters(state): Map<string, FetchedTrack[]> {
      if (state.tracks) {
        const result: Map<string, FetchedTrack[]> = new Map();
        state.tracks.forEach(track => {
          const date = FetchedTrack.quarterDate(track);
          if (!result.has(date)) {
            result.set(date, []);
          }
          result.get(date)?.push(track);
        });
        return result;
      } else {
        return new Map();
      }
    },
    track(state, id: number): FetchedTrack | null {
      return state.tracks?.find((track) => track.id === id) || null;
    }
  },

  mutations: {
    setCategories(state, categories: string[]): void {
      state.categories = categories;
    },
    setTracks(state, tracks: FetchedTrack[]): void {
      state.tracks = tracks;
    }
  }
})