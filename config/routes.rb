Gewitter::Application.routes.draw do
  match 'profiles' => 'profile#index'
  match 'profile/:username' => 'profile#show'
  devise_for :users

  get "home/index"
  root :to => "home#index"
end
