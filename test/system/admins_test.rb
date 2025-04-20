require "application_system_test_case"

class AdminsTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_path
    assert_selector "h1", text: "Medical Record Management System"
  end
end 