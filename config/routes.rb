Rails.application.routes.draw do

  post 'dashboard/signIn' => 'dashboard#signIn'
  post 'application/chkCredentials' => 'application#chkCredentials'
  get 'my_teams/saveRequest' => 'my_teams#saveRequest'
  
  get 'my_teams/matchedTeams' => 'my_teams#matchedTeams'
  get 'my_teams/sentRequests' => 'my_teams#sentRequests'
  get 'my_teams/recievedRequests' => 'my_teams#recievedRequests'
  get 'my_teams/acceptedRequests' => 'my_teams#acceptedRequests'
  get 'my_teams/acceptRequest' => 'my_teams#acceptRequest'
  get 'my_teams/deleteRequest' => 'my_teams#deleteRequest'
  get 'my_teams/getEditDetails' => 'my_teams#getEditDetails'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :dashboard,:my_teams
  root 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
