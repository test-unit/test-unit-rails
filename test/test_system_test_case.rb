require "test_helper"

class TestSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080]

  test "render text" do
    assert_equal(:selenium, Capybara.current_driver)
    browser = self.class.driver.instance_variable_get(:@browser)
    assert_equal(:chrome, browser.type)
    visit("/items")
    assert_text("Hello")
  end
end
