class ListingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'uri'
  require 'net/http'

  def index 
    @listings = Listing.all
    render json: @listings
  end

  def create
    @listings = Listing.upsert_all(listing_params)
    render json: @listings
  end

  def show
    @listing = Listing.find(params[:id])
    render json: @listing
  end

  def show_calendar
    render json: fetch_calendars
  end

 

  def fetch_calendars
    url = URI("https://www.airbnb.com/api/v3/PdpAvailabilityCalendar?operationName=PdpAvailabilityCalendar&locale=en&currency=USD&variables={\"request\":{\"count\":3,\"listingId\":\"#{params[:airbnb_id]}\",\"month\":3,\"year\":2021}}&extensions={\"persistedQuery\":{\"version\":1,\"sha256Hash\":\"dc360510dba53b5e2a32c7172d10cf31347d3c92263f40b38df331f0b363ec41\"}}&_cb=nn3r3413fkljy&key=d306zoyjsyarp7ifhu67rjxn52tv0t20")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    hash = JSON.parse response.body.to_s
    render json: hash['data']['merlin']['pdpAvailabilityCalendar']['calendarMonths']
  end

  private

  def fetch_listings
    url = URI("https://api.airbnb.com/v2/listings?key=d306zoyjsyarp7ifhu67rjxn52tv0t20&user_id=#{params[:id]}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    hash = JSON.parse response.body.to_s
    hash['listings']
  end

  def listing_params
    params.require(:_json).map do |param|
      param.permit(:host_id, :airbnb_id, :name, :bedrooms, :beds, :person_capcity, :city, :state, :zipcode).to_h
    end
  end
end
