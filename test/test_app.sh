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

rails new todo
cd todo

export PATH=$PWD/bin:$PATH

cat >> Gemfile <<GEMFILE
group :development, :test do
  gem "test-unit-rails", path: "/source/"
end
GEMFILE
bundle update

sed -i'' -e 's,rails/test_help,test/unit/rails/test_help,g' test/test_helper.rb
# TODO: Implement.
sed -i'' -e 's/parallelize/# parallelize/g' test/test_helper.rb

if rails --version | grep -q "^Rails 6"; then
  rails webpacker:install
fi
rails generate model item name:string
sed -i'' -e 's/# //g' test/models/item_test.rb
rails db:migrate
rails test -v | tee test.log
grep models: test.log
grep assertions test.log
