class HostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  require "uri"
  require "net/http"

  def index
    @hosts = Host.all
    render json: @hosts
  end

  def create
    @host = Host.create(host_params)
    render json: @host
  end

  def show
    render json: fetch_host
  end

  private

  def fetch_host
    url = URI("https://api.airbnb.com/v2/listings?key=d306zoyjsyarp7ifhu67rjxn52tv0t20&user_id=#{params[:id]}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    hash = JSON.parse response.body.to_s
    hash['listings']
  end

  def host_params
    params.require(:host).permit(:host_id, :first_name, :resp_rate, :resp_time, :accept_rate, :reviewee_count, :belongs_to)
  end
end
