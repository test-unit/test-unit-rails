require "test_helper"

if ActionDispatch::SystemTesting.const_defined?(:Server)
  # Workaround on GitHub Actions
  module LongReadTimeout
    def new_http_client
      client = super
      client.read_timeout = 120
      client
    end
  end
  Selenium::WebDriver::Remote::Http::Default.prepend(LongReadTimeout)

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
