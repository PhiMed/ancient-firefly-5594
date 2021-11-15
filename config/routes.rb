Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/teams', to: 'teams#index'

  get '/competitions/:id', to: 'competitions#show'

  post '/competitions/:id/teams', to: 'competition_teams#create'

end
