require 'spec_helper'

describe Webmachine::Linking::LinkHeader::Link do
  let(:href) { '/dogs' }
  let(:attr_pairs) { [['rel', 'up']] }
  subject { described_class.new(href, attr_pairs) }

  its(:to_s) { should eq '</dogs>; rel=up' }
end
