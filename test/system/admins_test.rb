require "application_system_test_case"

class AdminsTest < ApplicationSystemTestCase
  # This test must run with no admins in the database
  test 'staff page is admin only redirect to sign up' do
    visit staff_path
    assert_current_path new_admin_registration_path
    assert_selector "[role='alert']", text: "Please create an admin account first."
  end

  # Setup for all other tests that need an admin
  setup do
    # References fixtures yml files
    @admin = admins(:one)
  end

  # Redirects to sign up when there are no admins in the database
=begin
  test 'staff page is admin only, non-admin is redirected to sign up' do
    visit staff_path
    assert_current_path new_admin_registration_path
    assert_selector "[role='alert']", text: "Please create an admin account first."
  end
=end

=begin
  test "admin can sign in" do
    visit new_admin_session_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: 'password'  # We'll set this in the fixture
    click_on "Log in"
    
    assert_text "Signed in successfully"
    assert_current_path root_path
  end

  test "admin cannot sign in with invalid credentials" do
    visit new_admin_session_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: 'wrong_password'
    click_on "Log in"
    
    assert_text "Invalid Email or password"
    assert_current_path new_admin_session_path
  end

  test "admin can sign out" do
    # First sign in
    visit new_admin_session_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: 'password'
    click_on "Log in"
    
    # Then sign out
    click_on "Sign out"
    assert_text "Signed out successfully"
    assert_current_path root_path
  end
=end
end 