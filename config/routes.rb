Weather::Application.routes.draw do
  resources :locations do
  	get "history", :on => :member
  end
  match "conditions" => "conditions#index", :as => "conditions"
  root :to => "locations#index"
end