# Only load this file if it's running from the server, not from a rake task.
unless defined?($rails_rake_task) && $rails_rake_task

  class DeploymentTracker::DeploymentController < ActionController::Base
    unloadable(self) #needed to prevent errors with authenticated system in dev env.

    respond_to :json, :xml
    layout nil

    rescue_from StandardError, with: :deployment_tracker_error

    def index
      respond_with(DeploymentTracker::Deployments.all, location: nil)
    end

    def show
      respond_with(DeploymentTracker::Deployments.current, location: nil)
    end

    private

    def deployment_tracker_error
      respond_with({'error' => 'Unable to parse deployment history'}, status: 500, location: nil)
    end

  end

end
