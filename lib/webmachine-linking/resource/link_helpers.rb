module Webmachine
  module Linking
    class Resource
      module LinkHelpers
        attr_accessor :url_provider

        def url_for(resource, *vars)
          url_provider.url_for(resource, *vars)
        end

        def link_header(attr_pairs, resource, *vars)
          unless response.headers['Link']
            response.headers['Link'] = LinkHeader.new
          end

          if attr_pairs.is_a?(String)
            attr_pairs = attr_pairs.split(',').map {|rel| ['rel', rel.strip] }
          end
          link = LinkHeader::Link.new(url_for(resource, *vars), attr_pairs)

          yield link if block_given?

          response.headers['Link'] << link
        end

        def link_tag(attr_pairs, resource, *vars)
          if attr_pairs.is_a?(String)
            attr_pairs = attr_pairs.split(',').map {|rel| ['rel', rel.strip] }
          end
          LinkHeader::Link.new(url_for(resource, *vars), attr_pairs).to_html
        end

      end
    end
  end
end
