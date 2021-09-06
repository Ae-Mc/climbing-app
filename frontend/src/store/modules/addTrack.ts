import { auth } from '@/store/modules/auth'
import SendableTrack from "@/models/track/sendableTrack";
import axios from "axios";
import { createModule } from "vuexok";

export const addTrack = createModule('addTrack', {
  namespaced: true,
  state: {
    track: new SendableTrack(),
  },
  actions: {
    async sendTrack(context) {
      const track = context.state.track;
      const data = new FormData();
      if (track.name) {
        data.append('name', track.name)
      }
      if (track.description) {
        data.append('description', track.description)
      }
      if (track.category) {
        data.append('category', track.category)
      }
      if (track.creationDate) {
        data.append('creationDate', track.creationDate)
      }
      if (track.author) {
        data.append('author', track.author);
      }
      if (track.images) {
        for (let i = 0; i < track.images.length; i++) {
          data.append('images', track.images[i]);
        }
      }

      return axios.post('/api/tracks/', data);
    }
  },
  mutations: {
    setTrack(state, track: SendableTrack) {
      state.track = track
    },
    setName(state, name: string) {
      state.track.name = name;
    },
    setCategory(state, category: string) {
      state.track.category = category;
    },
    setDescription(state, description: string) {
      state.track.description = description;
    },
    setAuthor(state, author: string) {
      state.track.author = author;
    },
    setCreationDate(state, creationDate: string) {
      state.track.creationDate = creationDate;
    },
    setImages(state, images: File[]) {
      state.track.images = images
    },
    clear(state) {
      state.track = new SendableTrack()
      if (auth.state.user?.name)
        state.track.author = auth.state.user?.name;
    },
  }
})