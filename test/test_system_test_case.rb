require "test_helper"

if ActionDispatch::SystemTesting.const_defined?(:Server)
  if ENV["TRAVIS"]
    require "chromedriver/helper"
    Chromedriver.set_version "2.35"
  end

  class TestSystemTestCase < ActionDispatch::SystemTestCase
    have_browser = ActionDispatch::SystemTesting.const_defined?(:Browser)
    if have_browser
      driver = :selenium
      driven_by driver, using: :headless_chrome, screen_size: [1920, 1080]
    else
      driver = :selenium_chrome_headless
      driven_by driver, screen_size: [1920, 1080]
    end

    test "render text" do
      assert_equal(driver, Capybara.current_driver)
      visit("/items")
      assert_text("Hello")
    end
  end
end
