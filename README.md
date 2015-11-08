# HtmlInlineCss

This gem was created to inline css in html mails but can be used anywhere you want to inline css.
Be aware that the gem not yet is ready for production. Feel free to fork and build upon it yourself.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'html_inline_css'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install html_inline_css

## Usage

```ruby
html = "<html><head><style>div {border: 1px solid #e5e5e5;}</style></head><body><div> Foo bar </div></body></html>"
html_with_inline_css = InlineCssString::CSS.inline_css(html)

html_with_inline_css	=> "<div style='border:1px solid #e5e5e5;'> Foo Bar </div>"
```

```ruby
Be aware that the "InlineCssString::CSS.inline_css(string)" will remove all <html>,<head>,<style> and <body> tags.
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/niiicolai/html_inline_css. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

