require "test_helper"
require "selenium-webdriver"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400] do |options|
    options.add_argument("--headless")
    
    # Set ChromeDriver path using Windows path format
    Selenium::WebDriver::Chrome::Service.driver_path = "C:\\chromedriver.exe"
    
    # Additional Chrome options for stability
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
  end
end
