<template>
	<div>
    <h1>Hello</h1>
		<v-sheet tile height="54" class="d-flex">
			<v-btn
				icon
				color="black"
				class="ma-2"
				@click.prevent="$refs.calendar.prev()"
			>
				Prev
			</v-btn>

			<v-spacer></v-spacer>
			<v-btn icon class="ma-2" @click.prevent="$refs.calendar.next()">
				Next
			</v-btn>
		</v-sheet>
		<v-sheet height="600">
			<v-calendar
				ref="calendar"
				v-model="value"
				:events="events"
				:event-overlap-threshold="30"
				@change="getEvents"
			></v-calendar>
		</v-sheet>
	</div>
</template>

<script>
import axios from 'axios';

export default {
	name: 'ListingShow',
	data: () => ({
		type: 'month',
		value: '',
		events: [],
		pageCount: 0,
		names: ['Booked'],
	}),
	methods: {
		async getEvents() {
			const events = [];
			try {
				const response = await axios.get(
					`http://localhost:3000/listings/${this.$route.params.id}/fetch_calendars/${this.$route.params.airbnbID}`
				);
				const months  = response.data;
				for (const month of months) {
					const daysArr = month.days;
					for (let i = 0; i < daysArr.length; i++) {
						if (daysArr[i].available === false)
							events.push({
								name: 'Booked',
								start: daysArr[i].calendarDate,
								allDay: true,
							});
					}
				}
			} catch (error) {
				console.error(error);
			}
			this.events = events;
		},
	},
};
</script>
