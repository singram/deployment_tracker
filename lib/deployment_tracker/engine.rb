module DeploymentTracker
  class Engine < ::Rails::Engine
    isolate_namespace DeploymentTracker
    config.generators do |g|
      g.test_framework :rspec, view_specs: false
      g.assets false
      g.helper false
    end
  end
end
