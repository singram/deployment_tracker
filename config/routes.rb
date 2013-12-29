DeploymentTracker::Engine.routes.draw do

  root to: "deployment#index", defaults: { format: :json }

  get '/all',     to: 'deployment#index', defaults: { format: :json }
  get '/current', to: 'deployment#show',  defaults: { format: :json }

end
