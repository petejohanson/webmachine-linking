
require 'webmachine'
require 'webmachine-linking'

$foos = {
  1 => "OH YEAH!",
  2 => "Not in my house!",
  3 => "Is that you, John Wayne?",
}

class BaseResource < Webmachine::Resource
  attr_accessor :url_provider

  def url_for(resource, *vars)
    url_provider.url_for(resource, *vars)
  end
end

class FooCollectionResource < BaseResource
  def to_html
    foo_links = $foos.map { |k,v| "<a href='#{url_for FooResource, :foo_id => k.to_s}'>#{v}</a>" }.join("<br/>")
    
    <<-EOF
      <html>
        <body>
          Collection:<br/>
            #{foo_links}
        </body>
      </html>
    EOF
  end
end

class FooResource < BaseResource
  def resource_exists?
    $foos.has_key? request.path_info[:foo_id].to_i
  end

  def to_html
    response.headers['Link'] = "<#{url_for FooCollectionResource}>; rel=up"
    <<-EOF
      <html>
        <body>
	<div><a href="#{url_for FooCollectionResource}">Up</a></div>
	<div>Item: #{$foos[request.path_info[:foo_id].to_i]}!</div>
	</body>
      </html>
    EOF
  end
end

app = Webmachine::Application.new do |app|
  url_provider = Webmachine::Linking::UrlProvider.new(app.dispatcher.routes)

  app.dispatcher.resource_creator = lambda do |route, request, response|
    route.resource.new(request, response).tap { |r| r.url_provider = url_provider }
  end

  app.configure do |cfg|
    cfg.port = 8888
    cfg.adapter = :WEBrick
  end

  app.routes do
    add ['foos'], FooCollectionResource
    add ['foos', :foo_id], FooResource
  end
end

app.run
