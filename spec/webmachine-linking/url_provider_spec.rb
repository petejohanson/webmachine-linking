require 'spec_helper'

describe Webmachine::Linking::UrlProvider do
  let(:url_provider) { Webmachine::Linking::UrlProvider.new(dispatcher.routes) }
  let(:dispatcher) { Webmachine.application.dispatcher }
  let(:request) { Webmachine::Request.new("GET", URI.parse("http://localhost:8080/"), Webmachine::Headers["accept" => "*/*"], "") }
  let(:response) { Webmachine::Response.new }
  let(:resource) do
    Class.new(Webmachine::Resource) do
      def to_html; "hello world!"; end
    end
  end
  let(:resource2) do
    Class.new(Webmachine::Resource) do
      def to_html; "goodbye, cruel world"; end
    end
  end
  let(:fsm){ mock }

  before { dispatcher.reset }

  it "should return proper urls for resources" do
    dispatcher.add_route ["users"], resource
    dispatcher.add_route ["users", :user_id, "photos", :photo_id], resource2

    url_provider.url_for(resource).should == "/users"
    url_provider.url_for(resource2, :user_id => 1, :photo_id => 2).should == "/users/1/photos/2"
  end

  it "should select from duplicate routes based on variables provided" do
    dispatcher.add_route ["users", :user_id], resource
    dispatcher.add_route ["admins", :admin_id], resource

    url_provider.url_for(resource, :admin_id => 1).should == "/admins/1"
  end

  it "should raise an error for URLs without the require variables" do
    dispatcher.add_route ["users", :user_id], resource
    lambda { url_provider.url_for(resource) }.should raise_error(ArgumentError)
  end

  it "should raise an error for URLs for unknown resources" do
    dispatcher.add_route ["users"], resource
    lambda { url_provider.url_for(resource2) }.should raise_error(ArgumentError)
  end
end

