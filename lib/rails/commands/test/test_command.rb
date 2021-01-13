# Copyright (C) 2017  Kouhei Sutou <kou@clear-code.com>
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

require "rails/command"
require "test/unit/autorunner"

module Rails
  module Command
    class TestCommand < Base
      no_commands do
        def help
          perform
        end
      end

      def perform(*)
        Module.new do
          at_exit do
            if $!.nil? and Test::Unit::AutoRunner.need_auto_run?
              $LOAD_PATH << Rails::Command.root.join("test").to_s
              
              ARGV.unshift("--exclude=\\Atest_helper\\.rb\\z")
              ARGV.unshift("--default-test-path=test")
              exit(Test::Unit::AutoRunner.run(true))
            end
          end
        end
      end
    end
  end
end
