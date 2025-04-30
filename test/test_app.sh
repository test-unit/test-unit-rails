#!/bin/bash
#
# Copyright (C) 2021  Sutou Kouhei <kou@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

set -eux
set -o pipefail

export MAKEFLAGS=-j$(nproc)

rails new todo --skip-bundle
cd todo

export PATH=$PWD/bin:$PATH

cat >> Gemfile <<GEMFILE
group :development, :test do
  gem "test-unit-rails", path: "/source/"
end
GEMFILE
if [[ "${RAILS_VERSION}" =~ ^4 ]]; then
  cat >> Gemfile <<GEMFILE
gem 'loofah', '< 2.21.0'
GEMFILE
fi

# For Rails 5 Gemfile
sed -i'' -e "s/gem 'chromedriver-helper'/gem 'webdrivers'/" Gemfile
# Rails 4.x and 5.0 doesn't work with sqlite3 >= 1.4
if [ $(echo "${RAILS_VERSION} < 5.1" | bc) -eq 1 ]; then
  sed -i'' -e "s/gem 'sqlite3'/gem 'sqlite3', '~> 1.3.6'/" Gemfile
# Rails 6.x and 7.0 doesn't work with sqlite3 >=2
elif [ $(echo "${RAILS_VERSION} < 7.1" | bc) -eq 1 ]; then
  sed -i'' -e "s/gem 'sqlite3'/gem 'sqlite3', '~> 1.4'/" Gemfile
fi
# Installing rubygems that includes bundler 1 that is required by Rails 4
if [[ "${RAILS_VERSION}" =~ ^4 ]]; then
  gem update --system 3.0.9
# Ruby 2.7's bundled rubygems is so buggy that it ignores required_ruby_version limitation
elif ruby -v | grep -qF 'ruby 2.7.'; then
  gem update --system 3.4.22
fi
bundle update

sed -i'' -e 's,rails/test_help,test/unit/rails/test_help,g' test/test_helper.rb
# TODO: Implement.
sed -i'' -e 's/parallelize/# parallelize/g' test/test_helper.rb

if [[ "${RAILS_VERSION}" =~ ^6 ]]; then
  rails webpacker:install
fi
rails generate model item name:string
sed -i'' -e 's/# //g' test/models/item_test.rb
rake db:migrate

if [ $(echo "${RAILS_VERSION} >= 5.1" | bc) -eq 1 ]; then
  # Test with `rails test` command
  rails test -v | tee test.log
  grep models: test.log
  grep assertions test.log
else
  # Test with legacy `rake test` task
  rake test:models -v | tee test.log
  grep "1 assertions" test.log
  rake test -v | tee test.log
  grep assertions test.log
fi
