<template>
	<v-data-table
		:headers="headers"
		:items="hosts"
		sort-by="name"
		class="elevation-1"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-btn
					color="primary"
					dark
					class="mb-2"
					v-on="on"
					@click.stop.prevent="handleListingsClick()"
					>All Listings</v-btn
				>
				<v-divider class="mx-4" inset vertical></v-divider>
				<v-spacer></v-spacer>
				<h1 class="text-center">Hosts</h1>
				<v-spacer></v-spacer>
				<v-dialog v-model="dialog" max-width="500px">
					<template v-slot:activator="{ on }">
						<v-btn color="primary" dark class="mb-2" v-on="on">Add Host</v-btn>
					</template>
					<v-card>
						<v-card-title>
							<span class="headline">Add New Airbnb Host</span>
						</v-card-title>

						<v-card-text>
							<v-container>
								<v-row>
									<v-col cols="1" sm="12" md="12">
										<v-text-field
											v-model="newHostID.hostID"
											label="Host ID"
										></v-text-field>
									</v-col>
								</v-row>
							</v-container>
						</v-card-text>

						<v-card-actions>
							<v-spacer></v-spacer>
							<v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
							<v-btn color="blue darken-1" text @click="addNewHost(newHostID)"
								>Add</v-btn
							>
						</v-card-actions>
					</v-card>
				</v-dialog>
			</v-toolbar>
		</template>
	</v-data-table>
</template>

<script>
import axios from 'axios';

export default { 
	name: 'Hosts',
	data: () => ({
		dialog: false,
		headers: [
			{
				text: 'Name',
				align: 'left',
				sortable: true,
				value: 'first_name',
			},
			{ text: 'Response Rate', value: 'resp_rate' },
			{ text: 'Response Time', value: 'resp_time' },
			{ text: 'Acceptance Rate', value: 'accept_rate' },
			{ text: 'Reviewee Count', value: 'reviewee_count', sortable: false },
		],
		hosts: [],
		editedIndex: -1,
		newHostID: {
			id: '',
			name: '',
			resp_rate: '',
			resp_time: '',
			accept_rate: '',
			reviewee_count: '',
		},
		defaultItem: {
			id: '',
			name: '',
			resp_rate: '',
			resp_time: '',
			accept_rate: '',
			reviewee_count: '',
		},
	}),
	watch: {
		dialog(val) {
			val || this.close();
		},
	},
	created() {
		this.initialize();
	},
	methods: {
		handleListingsClick() {
			this.$router.push('/listings');
		},

		async initialize() {
			try {
				const response = await axios.get('http://localhost:3000/hosts');
				console.log(response.data);
				this.hosts = response.data;
			} catch (error) {
				console.error(error);
			}
		},

		close() {
			this.dialog = false;
			setTimeout(() => {
				this.newHostID = Object.assign({}, this.defaultItem);
				this.editedIndex = -1;
			}, 300);
		},

		addNewHost(airbnbID) {
			const id = airbnbID.hostID;

			axios
				.get(`http://localhost:3000/hosts/fetch_host/${id}`)
				.then((resp) => resp.data[0]['user'])
				.then((data) =>
					axios.post('http://localhost:3000/hosts/', {
						host_id: id,
						first_name: data.first_name,
						resp_rate: data.response_rate,
						resp_time: data.response_time,
						accept_rate: data.acceptance_rate,
						reviewee_count: data.reviewee_count,
					})
				)
				.then((resp) => {
					if (resp.statusText === 'OK') {
						this.addListings(resp.data.host_id, resp.data.id);
						console.log("DATA ID", resp.data.id);
						this.close();
						this.initialize();
					} else {
						console.error('Failed to find Host');
					}
				});
		},

		async addListings(hostId, dbID) {
			console.log(hostId);
			const listingArr = [];
			const rentals = await axios.get(`http://localhost:3000/hosts/fetch_host/${hostId}`);
			console.log('dbID', dbID)
			console.log(rentals.data);
			for (const el of rentals.data) {
				listingArr.push({
					airbnb_id: el.id,
					name: el.name,
					bedrooms: el.bedrooms,
					beds: el.beds,
					person_capcity: el.person_capacity,
					city: el.city,
					state: el.state,
					zipcode: el.zipcode,
					host_id: dbID,
				});
				try {
					const response = await axios.post(`http://localhost:3000/hosts/${dbID}/listings`, listingArr)
					console.log("Listing Array: ", listingArr.length)
					console.log(response.data)
				} catch(error) {
					console.error(error)
				}

			}
		},
	},
};
</script>
