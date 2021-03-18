import Vue from 'vue'
import Router from 'vue-router'
import Hosts from './components/hosts.vue'
import Listings from './components/listings.vue'
import ListingShow from './components/listingShow.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: "/",
      redirect: {
        name: "Hosts"
      }
    },
    {
      path: '/hosts',
      name: "Hosts",
      component: Hosts
    },
    {
      path: "/listings",
      name: "listings",
      component: Listings
    },
    {
      path: "/listings/:id/calendar/:airbnbID",
      name: "Listing's Calendar",
      component: ListingShow
    },
  ]
})