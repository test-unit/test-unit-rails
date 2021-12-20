# Copyright (C) 2012-2017  Kouhei Sutou <kou@clear-code.com>
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

if Rails.env.production?
  abort("Abort testing: Your Rails environment is running in production mode!")
end

require "test/unit/active_support"
require "test/unit/rr"
require "test/unit/capybara"

require "test/unit/assertion-failed-error"

require "capybara/rails"
require "capybara/minitest"
module Capybara
  remove_const(:Minitest)
  module Minitest
    module Assertions
    end
  end
end

require "active_support/testing/constant_lookup"
require "action_controller"
require "action_controller/test_case"
require "action_dispatch/testing/integration"

if defined?(ActiveRecord::Migration)
  if ActiveRecord::Migration.respond_to?(:maintain_test_schema!)
    ActiveRecord::Migration.maintain_test_schema!
  else
    ActiveRecord::Migration.check_pending!
  end
end

class ActiveSupport::TestCase
  self.file_fixture_path = "#{Rails.root}/test/fixtures/files" if respond_to?(:file_fixture_path=)

  def skipped?
    current_result.omission_count > 0
  end
end

if defined?(ActiveRecord::Base)
  class ActiveSupport::TestCase
    include ActiveRecord::TestFixtures
    self.fixture_path = "#{Rails.root}/test/fixtures/"

    setup do
      setup_fixtures
    end

    teardown do
      teardown_fixtures
    end
  end

  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
end

class ActionController::TestCase
  setup do
    @routes = Rails.application.routes
  end

  if defined?(ActiveRecord::Base)
    include ActiveRecord::TestFixtures

    self.fixture_path = "#{Rails.root}/test/fixtures/"
  end
end

module TestUnitRails
  module ActionViewSubTestCase
    private

    # Monkey-patching sub_test_case not to raise when fetching its default helper module
    def sub_test_case_class(*)
      klass = super
      class << klass
        define_method :anonymous? do
          true
        end
      end
      klass
    end
  end
end

ActionView::TestCase.singleton_class.prepend TestUnitRails::ActionViewSubTestCase

class ActionDispatch::IntegrationTest
  setup do
    @routes = Rails.application.routes
  end
  include Capybara::DSL
end

begin
  require "action_dispatch/system_test_case"
rescue LoadError
else
  class ActionDispatch::SystemTestCase
    setup before: :prepend do
      self.class.driver.use
    end

    # take screenshot before reset session
    teardown after: :prepend do
      take_failed_screenshot
      Capybara.reset_sessions!
    end
  end
end
