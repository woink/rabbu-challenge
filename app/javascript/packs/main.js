import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import App from '../app.vue'
import router from './router'



Vue.use(Vuetify)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify: new Vuetify(),
    router,
    render: h => h(App),
  }).$mount()
  document.body.appendChild(app.$el)
  
  console.log(app)
})

export const baseURL = process.env.DEV_URL || 'https://stark-meadow-63240.herokuapp.com'