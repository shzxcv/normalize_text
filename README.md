# NormalizeText

This Gem normalizes the text.

The normalization is based on the normalization rules of mecab-neologd, and some of my own additions.

https://github.com/neologd/mecab-ipadic-neologd/wiki/Regexp.ja

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'normalize_text'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install normalize_text

## Usage

```
require 'normalize_text'

'検索 エンジン 自作 入門 を 買い ました!!!'.normalize
=> "検索エンジン自作入門を買いました!!!"

'　　　ＰＲＭＬ　　副　読　本　　　'.normalize
=> "PRML副読本"

'南アルプスの　天然水　Ｓｐａｒｋｉｎｇ　Ｌｅｍｏｎ　レモン一絞り'.normalize
=> "南アルプスの天然水Sparking Lemonレモン一絞り"
```

For other normalization rules, please refer to the spec file

https://github.com/sho-jp/normalize_text/blob/main/spec/normalize_text_spec.rb

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/normalize_text. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/normalize_text/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NormalizeText project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/normalize_text/blob/master/CODE_OF_CONDUCT.md).
