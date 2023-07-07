`jekyll_emoji`
[![Gem Version](https://badge.fury.io/rb/jekyll_emoji.svg)](https://badge.fury.io/rb/jekyll_emoji)
===========

Inserts the specified emoji into the document.
You can specify the size and alignment of the emoji.
If you specify an emoji name that does not exist, the `undefined` emoji is shown.


## Installation

Add this line to your Jekyll website's `Gemfile`, within the `jekyll_plugins` group:

```ruby
group :jekyll_plugins do
  gem 'jekyll_emoji'
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

 - `align` - `left`, `right` or `inline`
 - `emoji_and_name` - causes the name of the emoji to be output along with the image
 - `list` - output all emojis
 - `name` - name of emoji

`list` and `name` are mutually exclusive; only specify one of them.


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

Bug reports and pull requests are welcome on #<struct Creategem::Repository::Host domain="github.com", camel_case="GitHub", id=:github> at https://github.com/mslinn/jekyll_emoji.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
