Rails.application.routes.draw do

  post 'dashboard/signIn' => 'dashboard#signIn'
  post 'application/chkCredentials' => 'application#chkCredentials'
  
  devise_for :users
  resources :dashboard
  root 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
