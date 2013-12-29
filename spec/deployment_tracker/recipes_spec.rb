require 'spec_helper'

describe Capistrano::DeploymentTracker, "loaded into a configuration" do

  before do
    @configuration = Capistrano::Configuration.new
    @configuration.extend(Capistrano::Spec::ConfigurationExtension)
    Capistrano::DeploymentTracker.load_into(@configuration)
  end

  subject { @configuration }

  context 'deployment_tracker:update' do
    before do
      @configuration.set :branch, 'stubbed branch'
      @configuration.set :repository, 'stubbed repo'
      @configuration.set :real_revision, 'stubbed revision'
      @configuration.set :release_path, '/tmp'
      @configuration.set :shared_path, '/tmp'
    end

    it "does deployment_tracker:update after deploy:create_symlink" do
      @configuration.should callback('deployment_tracker:update').after('deploy:create_symlink')
      @configuration.find_and_execute_task('deployment_tracker:update')
    end

    it 'creates a version file for the release with branch details' do
      pending "Regexp support in capistrano-spec"
      @configuration.set :branch, 'expected branch'
      @configuration.find_and_execute_task('deployment_tracker:update')
      @configuration.should have_run(/echo '.*expected branch.*' >  \/tmp\/DEPLOYMENT_INFO\.json/)
    end

    it 'creates a version file for the release with repository details' do
      pending "Regexp support in capistrano-spec"
      @configuration.set :repository, 'some@amazing/acme_repository'
      @configuration.find_and_execute_task('deployment_tracker:update')
      @configuration.should have_run(/echo '.*acme_repository.*' >  \/tmp\/DEPLOYMENT_INFO\.json/)
    end

    it 'creates a version file for the release with version details' do
      pending "Regexp support in capistrano-spec"
      @configuration.set :revision, 'expected sha'
      @configuration.find_and_execute_task('deployment_tracker:update')
      @configuration.should have_run(/echo '.*expected sha.*' >  \/tmp\/DEPLOYMENT_INFO\.json/)
    end

  end

end
