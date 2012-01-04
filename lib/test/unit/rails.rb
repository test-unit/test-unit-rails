# -*- coding: utf-8 -*-
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

require "test/unit/rails/version"

require "test/unit"
require "test/unit/notify"
require "test/unit/rr"
require "test/unit/capybara"

require "active_support/testing/setup_and_teardown"
module ActiveSupport::Testing::SetupAndTeardown
  module ClassMethods
    remove_method :setup
    remove_method :teardown
  end

  if const_defined?(:ForClassicTestUnit)
    module ForClassicTestUnit
      remove_method :run
    end
  end
end

unless ActiveSupport::Testing::SetupAndTeardown.const_defined?(:ForClassicTestUnit)
  module MiniTest
    Assertion = Test::Unit::Assertions
  end
end

require "rails/test_help"

require "capybara/rails"
class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
