Weather::Application.routes.draw do
  resources :locations
  match "locations/:id/history" => "locations#history", :as => "location_history"
  match "conditions" => "conditions#index", :as => "conditions"
  root :to => "locations#index"
end