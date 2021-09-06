import Vue from 'vue'
import VueRouter, { RouteConfig } from 'vue-router'
import { auth } from '@/store/modules/auth'
import MainApp from '@/views/home/App.vue'
import Login from '@/views/Login.vue'
import Register from "@/views/Register.vue";

Vue.use(VueRouter)

const routes: Array<RouteConfig> = [
  {
    path: '/',
    name: '',
    component: MainApp,
    children: [
      {
        path: '',
        redirect: {
          path: '/tracks'
        }
      },
      {
        path: 'tracks',
        name: 'Tracks',
        // route level code-splitting
        // this generates a separate chunk (tracks.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "tracks" */ '@/views/home/tracks/index.vue')
      },
      {
        path: 'tracks/new',
        name: 'AddTrack',
        component: () => import('@/views/home/tracks/AddTrack.vue'),
        meta: {
          requiresAuth: true
        }
      },
      {
        path: 'tracks/:id',
        name: 'Track',
        component: () => import('@/views/home/tracks/Track.vue'),
        props: (route) => ({
          id: parseInt(route.params.id)
        })
      },
      {
        path: 'about',
        name: 'About',
        component: () => import('@/views/home/About.vue')
      },
      {
        path: 'categories',
        name: 'Categories',
        component: () => import('@/views/home/Categories.vue')
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
    meta: {
      requiresNotAuthenticated: true
    }
  },
  {
    path: '/register',
    name: 'Register',
    component: Register,
    meta: {
      requiresNotAuthenticated: true
    }
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach(async (to, from, next) => {
  if (to.meta?.requiresAuth === true && !auth.state.status.loggedIn) {
    return next('/login');
  } else if (to.meta?.requiresNotAuthenticated === true && auth.state.status.loggedIn) {
    return false;
  }
  next();
})

export default router
