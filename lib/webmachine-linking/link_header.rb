

module Webmachine
  module Linking
    class LinkHeader
      attr_reader :rel, :href
      
      attr_accessor :options

      def initialize(rel, href)
        @rel, @href = rel, href
      end

      def to_s
        "<#{href}>; rel=#{rel}"
      end
    end
  end
end
