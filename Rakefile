begin; require 'psych'; rescue Object; nil end
require 'rubygems'
require './lib/as-extensions.rb'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "as-extensions"
    gemspec.summary = "Useful extensions for ActiveSupport"
    gemspec.email = "contact@moodstocks.com"
    gemspec.homepage = "http://moodstocks.com"
    gemspec.description = "This gem expends Rails' ActiveSupport"
    gemspec.authors = ["Pierre Chapuis"]
    gemspec.files = FileList['lib/**/*.rb', 'ext/*.rb']
    gemspec.add_dependency 'activesupport'
    gemspec.add_dependency 'babosa'
    gemspec.add_dependency 'i18n'
    gemspec.add_dependency 'map'
  end
rescue LoadError
  puts "Jeweler is not available, please install it first."
end
