# -*- coding: utf-8; mode: ruby -*-
#
# Copyright (C) 2012  Kouhei Sutou <kou@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License version 2.1 as published by the Free Software Foundation.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

require 'pathname'

require './lib/test/unit/rails/version.rb'

require 'rubygems'
require 'rubygems/package_task'
require 'yard'
require 'jeweler'
require 'packnga'

def cleanup_white_space(entry)
  entry.gsub(/(\A\n+|\n+\z)/, '') + "\n"
end

ENV["VERSION"] ||= Test::Unit::Rails::VERSION
version = ENV["VERSION"].dup
spec = nil
Jeweler::Tasks.new do |_spec|
  spec = _spec
  spec.name = "test-unit-rails"
  spec.version = version
  spec.rubyforge_project = "test-unit"
  spec.homepage = "http://test-unit.rubyforge.org/"
  spec.authors = ["Kouhei Sutou"]
  spec.email = ["kou@clear-code.com"]
  entries = File.read("README.textile").split(/^h2\.\s(.*)$/)
  description = cleanup_white_space(entries[entries.index("Description") + 1])
  spec.summary, spec.description, = description.split(/\n\n+/, 3)
  spec.license = "LGPLv2"
  spec.files = FileList["{lib,benchmark,misc}/**/*.rb",
                        "bin/*",
                        "README",
                        "COPYING",
                        "Rakefile",
                        "Gemfile"]
  spec.test_files = FileList["test/**/*.rb"]
end

Rake::Task["release"].prerequisites.clear
Jeweler::RubygemsDotOrgTasks.new do
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_tar_gz = true
end

document_task = Packnga::DocumentTask.new(spec) do |t|
  t.yard do |yard_task|
    yard_task.options += ["--markup", "textile"]
  end
end

Packnga::ReleaseTask.new(spec) do |task|
end

desc "Tag the current revision."
task :tag do
  sh("git tag -a #{version} -m 'release #{version}!!!'")
end
