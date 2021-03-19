<template>
	<div id="app">
		<v-app>
			<p>{{ message }}</p>
			<h5>{{title}}</h5>
			<router-view></router-view>
		</v-app>
	</div>
</template>

<script>
import hosts from './packs/components/hosts.vue';
import listings from './packs/components/listings.vue';
import listingShow from './packs/components/listingShow.vue'

export default {
	data: function() {
		console.log($this.$props)
		return {
			message: 'Airbnb Scrapper',
			title: ''
		};
	},
	components: {
		hosts,
		listings,
		listingShow
	},
	methods: {
		updateTitle(title) {
			this.title = title
		}
	}
};
</script>

<style scoped>
p {
	font-size: 2em;
	text-align: center;
}
</style>
