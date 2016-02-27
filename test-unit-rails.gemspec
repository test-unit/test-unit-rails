# -*- coding: utf-8; mode: ruby -*-
#
# Copyright (C) 2012-2016  Kouhei Sutou <kou@clear-code.com>
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

require "./lib/test/unit/rails/version"

clean_white_space = lambda do |entry|
  entry.gsub(/(\A\n+|\n+\z)/, "") + "\n"
end

version = Test::Unit::Rails::VERSION.dup

Gem::Specification.new do |spec|
  spec.name = "test-unit-rails"
  spec.version = version
  spec.authors = ["Kouhei Sutou"]
  spec.email = ["kou@clear-code.com"]
  spec.homepage = "https://github.com/test-unit/test-unit-rails"
  entries = File.read("README.textile").split(/^h2\.\s(.*)$/)
  description = clean_white_space.call(entries[entries.index("Description") + 1])
  spec.summary, spec.description, = description.split(/\n\n+/, 3)
  spec.license = "LGPLv2 or later"
  spec.files = ["COPYING", "Gemfile", "Rakefile", "README.textile"]
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("lib/**/*.rake")
  spec.files += Dir.glob("doc/text/**/*.textile")
  spec.test_files = Dir.glob("test/**/*.rb")

  spec.add_runtime_dependency("rails", ">= 4.0.2")
  spec.add_runtime_dependency("test-unit-activesupport", ">= 1.0.2")
  spec.add_runtime_dependency("test-unit-notify")
  spec.add_runtime_dependency("test-unit-capybara", ">= 1.0.5")
  spec.add_runtime_dependency("test-unit-rr", ">= 1.0.4")
  spec.add_runtime_dependency("test-unit", ">= 3.1.7")
  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("packnga")
  spec.add_development_dependency("RedCloth")
end

