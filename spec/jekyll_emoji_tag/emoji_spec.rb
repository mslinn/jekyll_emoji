require_relative '../../lib/jekyll_emoji_tag'

RSpec.describe(JekyllEmojiTag::Emoji) do
  let(:logger) do
    PluginMetaLogger.instance.new_logger(self, PluginMetaLogger.instance.config)
  end

  let(:parse_context) { TestParseContext.new }

  it 'has a test', skip: 'just a placeholder' do
    expect(true).to be_truthy
  end
end
