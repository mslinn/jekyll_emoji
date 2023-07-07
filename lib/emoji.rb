require 'jekyll_plugin_support'
require_relative 'jekyll_emoji/version.rb'

# This Jekyll tag plugin is a minimal example.
#
# See https://www.mslinn.com/jekyll/10200-jekyll-plugin-background.html
# See https://www.mslinn.com/jekyll/10400-jekyll-plugin-template-collection.html
#
# @example Heading for this example
#   {% emoji param1='value1' %}
#
# The Jekyll log level defaults to :info, which means all the Jekyll.logger statements below will not generate output.
# You can control the log level when you start Jekyll.
# To set the log level to :debug, write an entry into _config.yml, like this:
# plugin_loggers:
#   Emoji: debug
module JekyllEmoji
  # This class implements the Jekyll emoji functionality
  class Emoji < JekyllSupport::JekyllTag
    PLUGIN_NAME = 'emoji'.freeze
    VERSION = JekyllEmoji::VERSION

    # Put your plugin logic here.
    # The following variables are predefined:
    #   @argument_string, @config, @envs, @helper, @layout, @logger, @mode, @page, @paginator, @site, @tag_name and @theme
    #
    # @param tag_name [String] is the name of the tag, which we already know.
    # @param argument_string [String] the arguments from the web page.
    # @param tokens [Liquid::ParseContext] tokenized command line
    # @return [void]
    def render_impl
      @name = @helper.parameter_specified? 'name' # Obtain the value of parameter name
      @align = @helper.parameter_specified? 'align' # Obtain the value of parameter align
      @size = @helper.parameter_specified? 'size' # Obtain the value of parameter size
      @emoji_and_name = @helper.parameter_specified? 'emoji_and_name' # Obtain the value of parameter emoji_and_name
      @list = @helper.parameter_specified? 'list' # Obtain the value of parameter list
      <<~END_OUTPUT
        <pre class="example">
          @name='#{@name}'
          @align='#{@align}'
          @size='#{@size}'
          @emoji_and_name='#{@emoji_and_name}'
          @list='#{@list}'
          Remaining markup: '#{@helper.remaining_markup}'.
        </pre>
      END_OUTPUT
    end

    JekyllPluginHelper.register(self, PLUGIN_NAME)
  end
end
