
module Webmachine
  class Dispatcher
    class Route
      # Determines whether the given variables provides all the required
      # variables to create a URL for the route.
      # @param [Hash] vars the candidate variables for the route
      def path_spec_satisfied?(vars)
        path_spec.select { |p| Symbol === p }.reject { |s| !vars[s].to_s.empty? }.empty?
      end
      
      # Create a complete URL for this route, doing any necessary variable
      # substitution.
      # @param [Hash] vars values for the path variables
      # @return [String] the valid URL for the route
      def build_url(vars = {})
        "/" + path_spec.map do |p|
          case p
          when String
            if p == Webmachine::Dispatcher::Route::MATCH_ALL && vars.is_a?(String)
              vars
            else
              p
            end
          when Symbol
            vars.fetch(p)
          end
        end.join("/")
      end
    end
  end
end
