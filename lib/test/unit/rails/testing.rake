# Copyright (C) 2016  Kouhei Sutou <kou@clear-code.com>
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

require "test/unit/autorunner"

Rake.application[:test].clear_actions
task :test do
  Test::Unit::AutoRunner.run(true, "test", [File.expand_path("test")])
end

namespace :test do
  [
    "models",
    "helpers",
    "controllers",
    "mailers",
    "integration",
    "jobs",
    "system",
  ].each do |component|
    Rake.application["test:#{component}"].clear_actions
    task component do
      path = File.expand_path("test/#{component}")
      Test::Unit::AutoRunner.run(true, "test", [component])
    end
  end

  [
    {
      :name => :generators,
      :paths => [
        "lib/generators",
      ],
    },
    {
      :name => :units,
      :paths => [
        "models",
        "helpers",
        "unit",
      ],
    },
    {
      :name => :functionals,
      :paths => [
        "controllers",
        "mailers",
        "functional",
      ],
    },
  ].each do |meta_task|
    Rake.application["test:#{meta_task[:name]}"].clear_actions
    task meta_task[:name] do
      paths = []
      meta_task[:paths].each do |sub_path|
        path = File.expand_path("test/#{sub_path}")
        paths << path if File.exist?(path)
      end
      Test::Unit::AutoRunner.run(true, "test", paths)
    end
  end
end
