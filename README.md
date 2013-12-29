# DeploymentTracker

The gem simplifies the task of tracking who deployed what and when across multiple environments.  Predominantely aimed at assisting teams with mutliple environments who have to share server resources.

Provides a simple no-fuss capistrano recipe to register successful deployment information on application servers and a simple rails engine to provide a XML or JSON api to access current deployment information and deployment history

## Installation

Add this line to your application's Gemfile:

    gem 'deployment_tracker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deployment_tracker

## Usage

#### Essential

Add this line to your *config/deploy.rb* file

    $ require 'deployment_tracker/recipes'

#### Optional

Add this line to your *config/routes.rb* file to mount the deployment tracker api

      mount DeploymentTracker::Engine => '/deployment_tracker'

Where '/deployment_tracker' is the mount point of your choice and becomes the root of the deployment tracker API access points.

## Access API

### /current(.xml|.json)

Provides the following information in either xml or json format (default json) for the current deployment

* branch - Branch deployed
* repository - Repository name to which 'branch' belongs
* revision - Revision of branch deployed
* deployed_by - User name of person deploying the code (depends on whoami)
* deployed_at - Time of deployment

e.g. `http://localhost/deployment_tracker/current.xml`

### /all(.xml|.json)
Provides the following information in either xml or json format (default json) for alls deployments in chronologically descending order

* branch - Branch deployed
* repository - Repository name to which 'branch' belongs
* revision - Revision of branch deployed
* deployed_by - User name of person deploying the code (depends on whoami)
* deployed_at - Time of deployment

e.g. `http://localhost/deployment_tracker/all`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
