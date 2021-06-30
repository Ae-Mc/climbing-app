import Vue from 'vue'
import VueRouter, { RouteConfig } from 'vue-router'
import MainApp from '../views/home/App.vue'
import Login from '../views/Login.vue'
import Register from "../views/Register.vue";

Vue.use(VueRouter)

const routes: Array<RouteConfig> = [
  {
    path: '/',
    name: '',
    component: MainApp,
    children: [
      {
        path: '',
        name: 'Home',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '../views/home/Home.vue')
      },
      {
        path: 'about',
        name: 'About',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '../views/home/About.vue')
      },
      {
        path: 'categories',
        name: 'Categories',
        component: () => import('../views/home/Categories.vue')
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach(async (to, from, next) => {
  const isAuthorized = true // TODO
  if (to.meta?.requiresAuth === true && !isAuthorized) {
    return '/login'
  }
  next()
})

export default router
