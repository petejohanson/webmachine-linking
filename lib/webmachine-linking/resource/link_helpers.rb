
module Webmachine
  module Linking
    class Resource
      module LinkHelpers
        attr_accessor :url_provider

        def url_for(resource, *vars)
	  url_provider.url_for(resource, *vars)
	end

	def add_link_header(rel, resource, *vars)
	  links = response.headers['Link']
	  unless links
	    links = response.headers['Link'] = []
	  end

	  lh = LinkHeader.new(rel, url_for(resource, *vars))

	  yield lh if block_given?

	  links << lh.to_s
	end
      end
    end
  end
end
