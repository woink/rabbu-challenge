<template>
	<v-data-table
		:headers="headers"
		:items="listings"
		sort-by="name"
		class="elevation-1"
    @click:row="handleListingsClick"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-btn color="primary" dark class="mb-2" v-on="on" @click="handleAllHostsClick">All Hosts</v-btn>
				<v-divider class="mx-4" inset vertical></v-divider>
				<v-spacer></v-spacer>
					<h1 class="text-center">Listings</h1>
				<v-spacer></v-spacer>
			</v-toolbar>
		</template>
	</v-data-table>
</template>

<script>
import axios from 'axios';

export default {
  name: 'AllListings',
	data: () => ({
		dialog: false,
		headers: [
			{
				text: 'Name',
				align: 'left',
				value: 'name',
			},
			{ text: 'Bedrooms', value: 'bedrooms' },
			{ text: 'Beds', value: 'beds' },
			{ text: 'Capacity', value: 'person_capcity' },
			{ text: 'City', value: 'city'},
			{ text: 'State', value: 'state'},
			{ text: 'Zipcode', value: 'zipcode'},
			{	text: 'Airbnb ID', value: 'airbnb_id'}
		],
		listings: [],
		editedIndex: -1,
		newHostID: {
      id: '', 
      name: '',
			bedrooms: '',
			baths: '',
			person_capacity: '',
			city: '',
			state: '',
			zipcode: '',
		},
		defaultItem: {
      id: '', 
      name: '',
			bedrooms: '',
			baths: '',
			person_capacity: '',
			city: '',
			state: '',
			zipcode: '',
		},
	}),
	created() {
		this.initialize();
	},
	methods: {
    handleListingsClick(item) {
      this.$router.push(`/listings/${item.id}/calendar/${item.airbnb_id}`)
			console.log(item)
      },

		handleAllHostsClick() {
			this.$router.push('/hosts')
			},

		async initialize() {
			try {
				const response = await axios.get('http://localhost:3000/listings');
				console.log(response.data);
				this.listings = response.data;
			} catch (error) {
				console.error(error);
			}
		},
		},

		async addNewHost(airbnbID) {
			try {
				const response = await axios.get(
					`https://api.airbnb.com/v2/listings?key=d306zoyjsyarp7ifhu67rjxn52tv0t20&user_id=${airbnbID.hostID}`,
					{
						headers: { 'Access-Control-Allow-Origin': '*' },
					}
				);
				console.log('airbnbID: ', response.data);
			} catch (error) {
				console.error('oh now', error);
			}
		},
};
</script>
