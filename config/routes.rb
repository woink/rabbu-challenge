Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :hosts do 
    resources :listings
  end
  resources :listings
  get '/hosts/fetch_host', to: 'hosts#fetch_host', as: 'hosts_fetch_host'
  get '/listings/:id/fetch_calendars/:airbnb_id', to: 'listings#fetch_calendars', as: 'listing_fetch_calendars'
  # get 'app', to: 'hosts#index'
  # get 'app', to: 'listings#index'
  # match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]
end
