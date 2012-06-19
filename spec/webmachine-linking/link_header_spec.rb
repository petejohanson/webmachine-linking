
require 'spec_helper'

describe Webmachine::Linking::LinkHeader do
  let(:href) { '/dogs' }
  let(:rel) { 'up' }
  subject { described_class.new(rel, href) }

  its(:to_s) { should eq '</dogs>; rel=up' }
end
