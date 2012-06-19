
module Webmachine
  class Application
    def inject_resource_url_provider
      orig_creator = dispatcher.resource_creator
      url_provider = Webmachine::Linking::UrlProvider.new(dispatcher.routes)

      dispatcher.resource_creator = lambda { |resource, request, response|
        orig_creator.call(resource, request, response).tap do |r|
	  r.url_provider = url_provider if r.respond_to?(:url_provider=)
	end
      }
    end
  end
end
