# -*- coding: utf-8; mode: ruby -*-
#
# Copyright (C) 2012  Kouhei Sutou <kou@clear-code.com>
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

require './lib/test/unit/rails/version'

require 'rubygems'
require 'rubygems/package_task'
require 'yard'
require 'bundler/gem_helper'
require 'packnga'

task :default => :test

base_dir = File.join(File.dirname(__FILE__))
html_base_dir = File.join(base_dir, "doc", "html")

class Bundler::GemHelper
  def version_tag
    "#{version}"
  end
end

helper = Bundler::GemHelper.new(base_dir)
helper.install
spec = helper.gemspec

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_tar_gz = true
end

document_task = Packnga::DocumentTask.new(spec) do |task|
  task.original_language = "en"
  task.translate_language = "ja"
end

Packnga::ReleaseTask.new(spec) do |task|
  test_unit_github_io_dir_candidates = [
    "../../www/test-unit.github.io",
  ]
  test_unit_github_io_dir = test_unit_github_io_dir_candidates.find do |dir|
    File.directory?(dir)
  end
  task.index_html_dir = test_unit_github_io_dir
end

desc "Run test"
task :test do
  ruby("test/run-test.rb")
end
