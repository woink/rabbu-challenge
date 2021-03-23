class UpdateListingJob < ApplicationJob
  queue_as :default

  def perform(new_listing, host_id, id)
    new_listing_data = {
      airbnb_id: new_listing['id'],
      name: new_listing['name'],
      bedrooms: new_listing['bedrooms'],
      beds: new_listing['beds'],
      person_capcity: new_listing['person_capacity'],
      city: new_listing['city'],
      state: new_listing['state'],
      zipcode: new_listing['zipcode'],
      host_id: host_id
    }
    Listing.update(id, new_listing_data)
  end
end
