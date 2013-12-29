Rails.application.routes.draw do

  mount DeploymentTracker::Engine => "/deployment_tracker"

end
