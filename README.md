# test-unit-rails

[Web site](http://test-unit.github.io/#test-unit-rails)

## Description

test-unit-rails is a Rails adapter for test-unit gem. You can use full test-unit gem features, [RR](https://rubygems.org/gems/rr) integration and [Capybara](https://rubygems.org/gems/capybara) integration with test-unit-rails.

Rails supports Minitest but doesn't support test-unit.

## Install

Add the following codes to your Gemfile:

```ruby
group :development, :test do
  gem 'test-unit-rails'
end
```

Update bundled gems:

```sh
% bundle update
```

Replace `"require 'rails/test_help'"` in your test/test_helper.rb with the following codes:

```ruby
# require 'rails/test_help'
require 'test/unit/rails/test_help'
```

Now you can use full test-unit gem features, RR integration and Capybara integration.

## License

LGPLv2.1 or later.

(Kouhei Sutou has a right to change the license including contributed patches.)

## Authors

* Kouhei Sutou
* Haruka Yoshihara
