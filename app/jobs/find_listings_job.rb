class FindListingsJob < ApplicationJob
  queue_as :default

  def perform(airbnb_id, host_id, id)
    url = URI("https://api.airbnb.com/v2/listings?listing_ids=#{airbnb_id}&key=d306zoyjsyarp7ifhu67rjxn52tv0t20")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    hash = JSON.parse response.body.to_s
    listing = hash['listings'][0]
    UpdateListingJob.perform_later(listing, host_id, id)
  end
end
