require 'spec_helper'

describe DeploymentTracker::Deployments do

  before(:each) do
    DeploymentTracker::Deployments.reset
  end

  describe '#all' do

    context 'no deployment history available' do

      before(:each) do
        File.stub(:exist?).with(DeploymentTracker::Deployments::DEPLOYMENT_HISTORY_FILE).and_return(false)
      end

      it 'provides appropriate defaults' do
        DeploymentTracker::Deployments.all.should == [ ]
      end

    end

    context 'deployment history available' do
      let(:expected_file) { "{\"some1\":\"expected info\"}\n{\"some2\":\"expected info\"}"}
      let(:expected_info) { [ { 'some1' => 'expected info' }, { 'some2' => 'expected info' } ] }

      before(:each) do
        File.stub(:exist?).with(DeploymentTracker::Deployments::DEPLOYMENT_HISTORY_FILE).and_return(true)
      end

      it 'provides current deployment history' do
        File.should_receive(:read).with(DeploymentTracker::Deployments::DEPLOYMENT_HISTORY_FILE).and_return(expected_file)
        DeploymentTracker::Deployments.all.should == expected_info
      end

    end
  end

  describe '#current' do

    context 'no deployment information available' do

      before(:each) do
        File.stub(:exist?).with(DeploymentTracker::Deployments::DEPLOYMENT_FILE).and_return(false)
      end

      it 'provides appropriate defaults' do
        DeploymentTracker::Deployments.current.should == { 'sha' => 'unknown' }
      end

    end

    context 'deployment information available' do
      let(:expected_info) { { 'some' => 'expected info' } }

      before(:each) do
        File.stub(:exist?).with(DeploymentTracker::Deployments::DEPLOYMENT_FILE).and_return(true)
      end

      it 'provides current deployment information' do
        File.should_receive(:read).with(DeploymentTracker::Deployments::DEPLOYMENT_FILE).and_return(expected_info.to_json)
        DeploymentTracker::Deployments.current.should == expected_info
      end

    end

  end

end
