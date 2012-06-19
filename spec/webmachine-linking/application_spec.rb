
require 'spec_helper'

describe Webmachine::Application do
  let(:resource) {
    Class.new(Webmachine::Resource) do
      include Webmachine::Linking::Resource::LinkHelpers

      def to_html; "<html><body></body></html>"; end
    end
  }

  describe "#inject_url_provider" do
    before do
      subject.inject_resource_url_provider
    end

    it "sets the url_provider when creating a resource" do
      route = Webmachine::Dispatcher::Route.new([''], resource)
      subject.dispatcher.resource_creator.call(route, nil, nil).url_provider.should be_instance_of(Webmachine::Linking::UrlProvider)
    end
  end
end
