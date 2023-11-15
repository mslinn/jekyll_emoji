require 'jekyll'
require 'jekyll_plugin_logger'
require 'jekyll_plugin_support'

require_relative 'jekyll_emoji_tag/version'

# Require all Ruby files in 'lib/', except this file
Dir[File.join(__dir__, '*.rb')].each do |file|
  # puts "About to require #{file}"
  require file unless file.end_with?('/jekyll_emoji_tag.rb')
  # puts "Required #{file}"
end
