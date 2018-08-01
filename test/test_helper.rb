# Copyright (C) 2016  Kouhei Sutou <yokoyama@clear-code.com>
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

ENV["RAILS_ENV"] = "test"

require "rails/all"

# For Rack::Builder#to_app
module TestUnitRails
  class Application < ::Rails::Application
    ::Rails.logger = config.logger = ActiveSupport::Logger.new($stdout)
  end
end

require "test/unit/rails/test_help"
require "selenium-webdriver"

Rails.application.secrets[:secret_key_base] = 'xxx'
Rails.application.routes.draw do
  resources :items
end

class ItemsController < ActionController::Base
  def index
    render plain: "Hello"
  end
end

require "fileutils"

db_dir = "tmp"
FileUtils.rm_rf(db_dir)
FileUtils.mkdir_p(db_dir)
ActiveRecord::Base.establish_connection("adapter" => "sqlite3",
                                        "database" => "#{db_dir}/test.sqlite3")
