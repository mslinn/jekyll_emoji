# `jekyll_emoji_tag` [![Gem Version](https://badge.fury.io/rb/jekyll_emoji_tag.svg)](https://badge.fury.io/rb/jekyll_emoji_tag)

Inserts the specified emoji into the document.
You can specify the size and alignment of the emoji.
If you specify an emoji name that does not exist, the `undefined` emoji is shown.


## Installation

Add this line to your Jekyll website's `Gemfile`, within the `jekyll_plugins` group:

```ruby
group :jekyll_plugins do
  gem 'jekyll_emoji_tag'
end
```

And then execute:

```bash
$ bundle
```


## Syntax

```text
{% emoji OPTIONS %}
```

`OPTIONS` are:

- `align` - `left`, `right` or `inline` (default is inline)
- `class` - CSS style to add to the generated emoji
- `div`   - Wrap the emoji in a <div> instead of a <span>
- `emoji_and_name` - causes the name of the emoji to be output along with the image (default is false)
- `list` - output all emojis (default is false)
- `name` - name of emoji (defaults to smiley)
- `size` - height of emoji (defaults to 3em)
- `style` - Additional CSS styles for the generated emoji

`list` and `name` are mutually exclusive; only specify one of them.

If neither `list` nor `name` is specified, the `smiley` emoji is output.

The names of all supported emojis are:

```text
angry
boom
grin
horns
kiss
open
poop
sad
scream
smiley
smirk
two_hearts
```

## Example Usage

```text
{% emoji name='boom' %}
{% emoji align='right' name='grin' %}
{% emoji name='sad' size='12pt' %}
{% emoji align='right' name='horns' size='12pt' %}
{% emoji emoji_and_name name='poop' %}
{% emoji align='right' emoji_and_name name='scream' %}
{% emoji list %}
{% emoji list size='1em' %}
```

See the [demo](demo/index.html) for more examples.


## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `bundle exec rake test` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags,
and push the `.gem` file to https://rubygems.org.


## Contributing

Bug reports and pull requests are welcome at https://github.com/mslinn/jekyll_emoji_tag.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
