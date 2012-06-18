require 'spec_helper'

describe Webmachine::Dispatcher::Route do
  let(:method) { "GET" }
  let(:uri) { URI.parse("http://localhost:8080/") }
  let(:request){ Webmachine::Request.new(method, uri, Webmachine::Headers.new, "") }
  let(:resource){ Class.new(Webmachine::Resource) }

  context "building URLs" do
    context "for a route with path variables" do
      subject { described_class.new(['foo', :id, 'baz'], resource) }

      it "should craft a proper URL when given the necessary variables" do
        subject.build_url(:id => 123, :user_id => 2).should == "/foo/123/baz"
      end

      it "should raise an error when required variables are not provided" do
        lambda { subject.build_url(:user_id => 2) }.should raise_error
      end

      it "should be satisfied by specifying :id" do
        subject.path_spec_satisfied?({ :id => 123 }).should be_true
      end

      it "should not be satisfied without specifying :id" do
        subject.path_spec_satisfied?({ :post_id => 123 }).should be_false
      end
    end

    context "for a route with no path variables" do
      subject { described_class.new(['foo', 'baz'], resource) }

      it "should craft a proper URL" do
        subject.build_url.should == "/foo/baz"
      end

      it "should be satisfied by an empty hash" do
        subject.path_spec_satisfied?({}).should be_true
      end
    end
  end
end
