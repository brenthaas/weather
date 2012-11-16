Weather::Application.routes.draw do
  resources :locations
  match "locations/:id/history" => "locations#history", :as => "location_history"
  root :to => "locations#index"
end