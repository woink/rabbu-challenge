<template>
	<div id="app">
		<v-app>
			<p>{{ message }}</p>
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
		return {
			message: 'Airbnb Scrapper',
		};
	},
	components: {
		hosts: hosts,
		listings: listings,
		listingShow: listingShow
	},
};
</script>

<style scoped>
p {
	font-size: 2em;
	text-align: center;
}
</style>
