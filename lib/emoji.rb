require 'jekyll_plugin_support'
require_relative 'jekyll_emoji_tag/version'

# This Jekyll tag plugin creates an emoji of the desired size and alignment.
#
# @example Float Smiley emoji right, sized 3em
#     {% tag_template name='smile' align='right' size='5em' %}
#   The above results in the following HTML:
#     <span style="float: right; font-size: 5em;">&#x1F601;</span>
#
# @example Defaults
#     {% tag_template name='smile' %}
#   The above results in the following HTML:
#     <span style="font-size: 3em;">&#x1F601;</span>
#
# The Jekyll log level defaults to :info, which means all the Jekyll.logger statements below will not generate output.
# You can control the log level when you start Jekyll.
# To set the log level to :debug, write an entery into _config.yml, like this:
# plugin_loggers:
#   MyTag: debug
module JekyllEmojiTag
  # This class implements the Jekyll emoji functionality
  class Emoji < ::JekyllSupport::JekyllTag
    PLUGIN_NAME = 'emoji'.freeze
    VERSION = JekyllEmojiTag::VERSION

    class << self
      attr_accessor :emojis
    end

    # Supported emojis (GitHub symbol, hex code) - see https://gist.github.com/rxaviers/7360908 and
    # https://www.quackit.com/character_sets/emoji/emoji_v3.0/unicode_emoji_v3.0_characters_all.cfm
    Emoji.emojis = {
      'angry'      => '&#x1F620;',
      'boom'       => '&#x1F4A5;', # used when requested emoji is not recognized
      'clap'       => '&#x1F44F;',
      'confounded' => '&#x1F616;',
      'eggplant'   => '&#x1F346;',
      'grimace'    => '&#x1F62C;',
      'grin'       => '&#128512;',
      'halo'       => '&#x1F607;',
      'horns'      => '&#128520;',
      'kiss'       => '&#x1F619;',
      'loudly_cry' => '&#x1F62D;',
      'notes'      => '&#x1F3B6;',
      'open'       => '&#128515;',
      'party'      => '&#x1F389;',
      'please'     => '&#x1F64F;',
      'poop'       => '&#x1F4A9;',
      'rolling'    => '&#x1F644;',
      'sad'        => '&#128546;',
      'sax'        => '&#x1F3B7;',
      'scream'     => '&#x1F631;',
      'smiley'     => '&#x1F601;', # default emoji
      'smirk'      => '&#x1F60F;',
      'sunglasses' => '&#x1F60E;',
      'think'      => '&#x1F914;',
      'two_hearts' => '&#x1F495;',
      'wink'       => '&#x1F609;',
      'worried'    => '&#x1f61f;',
      'unamused'   => '&#x1F612;',
      'vulcan'     => '&#x1F596;',
      'zipper'     => '&#x1F910;',
    }.sort_by { |k, _v| [k] }.to_h

    # @param tag_name [String] is the name of the tag, which we already know.
    # @param argument_string [String] the arguments from the web page.
    # @param tokens [Liquid::ParseContext] tokenized command line
    # @return [void]
    def render_impl
      @emoji_align    = @helper.parameter_specified?('align') || 'inline' # Allowable values are: inline, right or left

      emoji_size     = @helper.parameter_specified?('size')
      @emoji_size    = "font-size: #{emoji_size}; " if emoji_size

      @emoji_name     = @helper.parameter_specified?('name') || 'smiley' # Ignored if `list` is specified
      @emoji_and_name = @helper.parameter_specified? 'emoji_and_name'
      @klass          = @helper.parameter_specified? 'class'
      @list           = @helper.parameter_specified? 'list'
      @style          = @helper.parameter_specified? 'style'
      @tag            = @helper.parameter_specified?('div') ? 'div' : 'span'

      @emoji_hex_code = Emoji.emojis[@emoji_name] if @emoji_name || Emoji.emojis['boom']

      # variables defined in pages are stored as hash values in liquid_context
      # _assigned_page_variable = @liquid_context['assigned_page_variable']

      @layout_hash = @page['layout']

      @logger.debug do
        <<~HEREDOC
          liquid_context.scopes=#{@liquid_context.scopes}
          mode="#{@mode}"
          page attributes:
            #{@page.sort
                   .except(*REJECTED_ATTRIBUTES)
                   .map { |k, v| "#{k}=#{v}" }
                   .join("\n  ")}
        HEREDOC
      end

      # Return the value of this Jekyll tag
      if @list
        list
      else
        assemble_emoji(@emoji_name, @emoji_hex_code)
      end
    end

    private

    def assemble_emoji(emoji_name, emoji_hex_code)
      align = case @emoji_align
              when 'inline'
                ''
              when 'right'
                ' float: right; margin-left: 5px;'
              when 'left'
                ' float: left; margin-right: 5px;'
              else
                @logger.error { "Invalid emoji alignment #{@emoji_align}" }
                ''
              end

      name = " <code>#{emoji_name}</code>" if @emoji_and_name
      klass = @klass ? " class='emoji #{@klass}'" : " class='emoji'"
      style = "#{@emoji_size}#{align};#{@style}".strip.gsub ';;', ';'

      "<#{@tag}#{klass} style='#{style}'>#{emoji_hex_code}</#{@tag}>#{name}"
    end

    def list
      items = Emoji.emojis.map do |ename, hex_code|
        "  <li>#{assemble_emoji(ename, hex_code)}</li>"
      end
      <<~END_RESULT
        <ul class='emoji_list'>
          #{items.join("\n  ")}
        </ul>
      END_RESULT
    end

    ::JekyllSupport::JekyllPluginHelper.register(self, PLUGIN_NAME)
  end
end
