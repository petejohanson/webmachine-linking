
module Webmachine
  module Linking
    class UrlProvider
      # Get the URL to the given resource, with optional variables to be used
      # for bindings in the path spec.
      # @param [Webmachine::Resource] resource the resource to link to
      # @param [Hash] vars the values for the required path variables
      # @raise [RuntimeError] Raised if the resource is not routable.
      # @return [String] the URL
      def url_for(resource, vars = {})
        candidates = @routes.select { |r| r.resource == resource }
  
        raise ArgumentError, "#{resource} is not a routable resource" if candidates.empty?
  
        route = candidates.find { |r| r.path_spec_satisfied? vars }
  
        raise ArgumentError, "No routes for #{resource} satisfied by given path variables" unless route
  
        route.build_url(vars)
      end

      # Create a new [UrlProvider] for the given set of routes.
      # @param [Array] routes The set of routes from which we build URLs.
      def initialize(routes)
        @routes = routes
      end
    end
  end
end
