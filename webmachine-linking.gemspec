$:.push File.expand_path("../lib", __FILE__)
require 'webmachine-linking/version'

Gem::Specification.new do |gem|
  gem.name = "webmachine-linking"
  gem.version = Webmachine::Linking::VERSION
  gem.summary = %Q{webmachine-linking extends webmachine-ruby to provide a richer linking API,}
  gem.description = <<-DESC.gsub(/\s+/, ' ')
    webmachine-linking extends webmachine-ruby to provide a richer linking API
  DESC
  gem.homepage = "http://github.com/petejohanson/webmachine-linking"
  gem.authors = ["Pete Johanson"]
  gem.email = ["peter@peterjohanson.com"]

  #gem.add_runtime_dependency(%q<webmachine>, [">= 0.5.0"])
  gem.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
  gem.add_development_dependency(%q<rake>)
  gem.add_dependency(%q<link_header>)

  ignores = File.read(".gitignore").split(/\r?\n/).reject{ |f| f =~ /^(#.+|\s*)$/ }.map {|f| Dir[f] }.flatten
  gem.files = (Dir['**/*','.gitignore'] - ignores).reject {|f| !File.file?(f) }
  gem.test_files = (Dir['spec/**/*','features/**/*','.gitignore'] - ignores).reject {|f| !File.file?(f) }
  gem.require_paths = ['lib']
end

