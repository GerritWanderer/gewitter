Gewitter::Application.routes.draw do
  get "profile/index"
  match 'profile/:username' => 'profile#show'
  devise_for :users

  get "home/index"
  root :to => "home#index"
  
end
