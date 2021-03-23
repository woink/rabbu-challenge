desc 'update listings if info has changed'
task update_listings: :environment do
  puts 'Updating listings changes from airbnb'
  listings_ids = Listing.pluck(:airbnb_id, :host_id, :id)
  listings_ids.each do |el|
    FindListingsJob.perform_later(el[0], el[1], el[2])
  end
end
