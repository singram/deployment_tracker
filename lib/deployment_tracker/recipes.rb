module Capistrano
  module DeploymentTracker
    def self.load_into(configuration)
      configuration.load do

        namespace :deployment_tracker do

          after 'deploy:create_symlink', 'deployment_tracker:update'
          desc 'Update file specifying details of code deployed.'
          task :update, roles: :app do
            # Write versioning information to release path for use by
            # config.ru rack specification
            set :deployment_details, {
              branch:      branch,
              repository:  repository.split('/')[-1],
              revision:    real_revision,
              deployed_by: `whoami`.chomp,
              deployed_at: Time.now.to_s
            }
            run "echo '#{deployment_details.to_json}' >  #{release_path}/DEPLOYMENT_INFO.json"
            run "echo '#{deployment_details.to_json}' >> #{shared_path}/log/DEPLOYMENT_HISTORY.json"
          end

        end
      end
    end
  end
end

require 'capistrano'
if Capistrano::Configuration.instance
  Capistrano::DeploymentTracker.load_into(Capistrano::Configuration.instance)
end
