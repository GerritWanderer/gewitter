Gewitter::Application.routes.draw do
  devise_for :users
  resources :messages
  match 'profiles' => 'profile#index', :as => 'profiles'
  match 'profile(/:username)' => 'profile#show', :as => 'profile'
  match 'profile/subscribe(/:username)' => 'profile#subscribe', :as => 'subscribe_profile'
  match 'profile/unsubscribe(/:username)' => 'profile#unsubscribe', :as => 'unsubscribe_profile'
  
  root :to => "profile#index"
end
