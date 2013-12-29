require 'spec_helper'

describe DeploymentTracker::DeploymentController do

  routes { DeploymentTracker::Engine.routes }

  describe "GET index" do

    def do_get(options={})
      get :index, {:format => 'json'}.merge(options)
    end

    describe "route" do

      it "supports GET" do
        { :get => "/all" }.should route_to( :controller => 'deployment_tracker/deployment', :action => 'index', :format => :json )
      end

      [:put, :post, :delete].each do |http_method|
        it "does not support #{http_method.to_s.upcase}" do
          { http_method => "/all" }.should_not be_routable
        end
      end

    end

    context "when the deployment history information is available" do

      let(:version1) { { 'version' => 1 } }
      let(:version2) { { 'version' => 2 } }
      let(:expected_content)  { [version1, version2] }

      before(:each) do
        DeploymentTracker::Deployments.stub(:all).and_return(expected_content)
      end

      it "should not respond to HTML" do
        do_get(:format => :html)
        response.status.should == 406
      end

      it "should render content with JSON" do
        do_get(:format => :json)
        response.body.should eq expected_content.to_json.to_s
      end

      it "should render content with XML" do
        do_get(:format => :xml)
        response.body.should eq expected_content.to_xml.to_s
      end

    end

    context "when the deployment history information is corrupt" do
      let(:expected_content)  { { 'error' => 'Unable to parse deployment history' } }

      before(:each) do
        DeploymentTracker::Deployments.stub(:all).and_raise(StandardError)
      end

      it "should not respond to HTML" do
        do_get(:format => :html)
        response.status.should == 406
      end

      it "should render content with JSON" do
        do_get(:format => :json)
        response.status.should == 500
        response.body.should eq expected_content.to_json.to_s
      end

      it "should render content with XML" do
        do_get(:format => :xml)
        response.status.should == 500
        response.body.should eq expected_content.to_xml.to_s
      end

    end

  end

  describe "GET show" do

    def do_get(options={})
      get :show, {:format => 'json'}.merge(options)
    end

    describe 'route' do

      it "supports GET" do
        { :get => "/current" }.should route_to( :controller => 'deployment_tracker/deployment', :action => 'show', :format => :json )
      end

      [:put, :post, :delete].each do |http_method|
        it "does not support #{http_method.to_s.upcase}" do
          { http_method => "/current" }.should_not be_routable
        end
      end

    end

    context "when the deployment history information is available" do
      let(:expected_content) { { 'version' => 1 } }

      before(:each) do
        DeploymentTracker::Deployments.stub(:current).and_return(expected_content)
      end

      it "should not respond to HTML" do
        do_get(:format => :html)
        response.status.should == 406
      end

      it "should render content with JSON" do
        do_get(:format => :json)
        response.body.should eq expected_content.to_json.to_s
      end

      it "should render content with XML" do
        do_get(:format => :xml)
        response.body.should eq expected_content.to_xml.to_s
      end
    end

    context "when the deployment history information is corrupt" do
      let(:expected_content)  { { 'error' => 'Unable to parse deployment history' } }

      before(:each) do
        DeploymentTracker::Deployments.stub(:current).and_raise(StandardError)
      end

      it "should not respond to HTML" do
        do_get(:format => :html)
        response.status.should == 406
      end

      it "should render content with JSON" do
        do_get(:format => :json)
        response.status.should == 500
        response.body.should eq expected_content.to_json.to_s
      end

      it "should render content with XML" do
        do_get(:format => :xml)
        response.status.should == 500
        response.body.should eq expected_content.to_xml.to_s
      end
    end

  end

end
