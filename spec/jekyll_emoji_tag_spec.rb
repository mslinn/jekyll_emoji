require_relative '../lib/jekyll_emoji_tag'

RSpec.describe JekyllEmojiTag::JekyllEmojiTag do
  let(:logger) do
    PluginMetaLogger.instance.new_logger(self, PluginMetaLogger.instance.config)
  end

  let(:parse_context) { TestParseContext.new }

  it 'has a test' do
    expect(true).to be_true
  end
end
