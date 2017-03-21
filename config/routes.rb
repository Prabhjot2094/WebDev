Rails.application.routes.draw do

  post 'dashboard/signIn' => 'dashboard#signIn'
  post 'application/chkCredentials' => 'application#chkCredentials'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :dashboard,:my_teams
  root 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
