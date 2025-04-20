require "application_system_test_case"

class AdminsTest < ApplicationSystemTestCase
  setup do
    # Clearing all admins from the database before each test
    #Admin.delete_all
    Admin.delete_all
    puts "\n=== Setup: Admin count: #{Admin.count} ==="
  end
  
=begin
  test 'staff page redirects to sign up when no admins exist' do
    # Checking there are no admins
    assert_equal 0, Admin.count, "Expected no admins in the database"
    
    visit staff_path
    assert_current_path new_admin_registration_path
    assert_text "Please create an admin account first."
  end

  test 'staff page redirects to sign in when admins exist' do
    # Create an admin
    Admin.create!(email: 'test@example.com', password: 'Password123', password_confirmation: 'Password123')
    assert_equal 1, Admin.count, "Expected one admin in the database"
    
    visit staff_path
    assert_current_path new_admin_session_path
  end
=end

  # Create and sign in an admin
  def sign_in_as_admin
    admin = Admin.create!(
      first_name: 'Admin',
      last_name: 'User',
      email: 'admin@example.com',
      password: 'Password123',
      password_confirmation: 'Password123'
    )
    
    # Sign in as the admin
    visit new_admin_session_path
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'Password123'
    click_button 'Log in'
    
    admin
  end

  test 'Admin sign up' do
    puts "\n=== Before visit: Admin count: #{Admin.count} ==="
    
    visit root_path
    click_link 'Staff'
    assert_current_path new_admin_registration_path
    
    puts "\n=== Before form fill: Admin count: #{Admin.count} ==="
    
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test_email@gmail.com'
    fill_in 'Password', with: 'Password123'
    fill_in 'Password confirmation', with: 'Password123'
    
    puts "\n=== Before click_button: Admin count: #{Admin.count} ==="
    
    click_button 'Sign up'
    
    # Had to add a wait period as form doesn't submit immediately and it messes up assertions
    sleep(10)
    
    puts "\n=== After click_button (with wait): Admin count: #{Admin.count} ==="
    puts "Current path: #{current_path}"
    
    # Verify admin's details are correct
    created_admin = Admin.last
    if created_admin
      puts "Admin created successfully:"
      puts "Email: #{created_admin.email}"
      puts "First name: #{created_admin.first_name}"
      puts "Last name: #{created_admin.last_name}"
    end
    
    assert_equal 1, Admin.count, "Expected one admin after sign up"
    assert_equal 'test_email@gmail.com', Admin.last.email, "Admin email should match input"
  end

  test 'Admin sign up with incomplete form' do
    visit root_path
    click_link 'Staff'
    assert_current_path new_admin_registration_path

    # Submit form without filling any fields
    click_button 'Sign up'

    sleep(10)

    # Verify we're still on the sign up page
    assert_current_path new_admin_registration_path
    
    assert_equal 0, Admin.count, "No admin should be created with incomplete form"
  end

  test 'Admin sign up with invalid data' do
    visit root_path
    click_link 'Staff'
    assert_current_path new_admin_registration_path

    # Fill in form with invalid data
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'invalid-email'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '456'

    click_button 'Sign up'

    sleep(10)

    # Verify we're still on the sign up page
    assert_current_path new_admin_registration_path

    # Verify no admin was created
    assert_equal 0, Admin.count, "No admin should be created with invalid data"
  end

  test 'Add receptionist' do
    sign_in_as_admin
    
    visit staff_path
    click_link 'Add Receptionist'

    sleep(5)

    fill_in 'First name', with: 'Jane'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'jane.doe@example.com'
    fill_in 'Password', with: 'Password123'
    fill_in 'Password confirmation', with: 'Password123'
    
    click_button 'Sign up'

    sleep(10)

    assert_equal 1, Receptionist.count, "Expected one receptionist to be created"
    assert_equal 'Jane', Receptionist.last.first_name, "Receptionist first name should match input"
    assert_equal 'Doe', Receptionist.last.last_name, "Receptionist last name should match input"
    assert_equal 'jane.doe@example.com', Receptionist.last.email, "Receptionist email should match input"

    puts "Receptionist first name: #{Receptionist.last.first_name}"
    puts "Receptionist last name: #{Receptionist.last.last_name}"
    puts "Receptionist email: #{Receptionist.last.email}"
  end

  test 'Add doctor' do
    sign_in_as_admin
    
    visit staff_path
    click_link 'Add Doctor'

    sleep(5)

    fill_in 'First name', with: 'Doctor'
    fill_in 'Last name', with: 'Who'
    fill_in 'Email', with: 'doctor.who@example.com'
    fill_in 'Password', with: 'Password123'
    fill_in 'Password confirmation', with: 'Password123'

    click_button 'Sign up'

    sleep(10)

    assert_equal 1, Doctor.count, "Expected one doctor to be created"
    assert_equal 'Doctor', Doctor.last.first_name, "Doctor first name should match input"
    assert_equal 'Who', Doctor.last.last_name, "Doctor last name should match input"
    
    puts "Doctor first name: #{Doctor.last.first_name}"
    puts "Doctor last name: #{Doctor.last.last_name}"
    puts "Doctor email: #{Doctor.last.email}"
    
  end

  test 'Attempt to add staff while admin is not signed in' do
    visit staff_path
    assert_current_path new_admin_session_path

  end

  test 'Admin can view staff they added' do
    sign_in_as_admin

    visit staff_path
    click_link 'Add Receptionist'

    sleep(5)

    fill_in 'First name', with: 'Samantha'
    fill_in 'Last name', with: 'Haney'
    fill_in 'Email', with: 'samantha.haney@gmail.com'
    fill_in 'Password', with: 'Password123'
    fill_in 'Password confirmation', with: 'Password123'

    click_button 'Sign up'

    sleep(10)

    visit staff_path

    assert_text 'Samantha Haney'
    assert_text 'samantha.haney@gmail.com'

    take_screenshot
  end
  

end 