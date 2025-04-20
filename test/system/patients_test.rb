require "application_system_test_case"

class PatientsTest < ApplicationSystemTestCase
  setup do
    # Clear all users before each test
    Admin.delete_all
    Doctor.delete_all
    Receptionist.delete_all
    Patient.delete_all
  end

  # Helper method to create and sign in as receptionist
  def sign_in_as_receptionist
    # Create a receptionist
    receptionist = Receptionist.create!(
      first_name: 'Sarah',
      last_name: 'Smith',
      email: 'sarah.smith@example.com',
      password: 'Password123',
      password_confirmation: 'Password123'
    )
    
    # Sign in as the receptionist
    visit new_receptionist_session_path
    fill_in 'Email', with: 'sarah.smith@example.com'
    fill_in 'Password', with: 'Password123'
    click_button 'Log in'
    
    receptionist
  end

  # Helper method to create and sign in as doctor
  def sign_in_as_doctor
    # Create a doctor
    doctor = Doctor.create!(
      first_name: 'John',
      last_name: 'Watson',
      email: 'john.watson@example.com',
      password: 'Password123',
      password_confirmation: 'Password123'
    )
    
    # Sign out as receptionist
    click_button 'Log Out' if page.has_button?('Log Out')
    
    sleep(10)
    
    # Make sure we're on a page where we can access the login
    visit root_path
    
    if page.has_button?('Log In')
      click_button 'Log In'
      puts "Clicked Log In"
    else
      visit new_doctor_session_path  # Fallback to direct path if link isn't found
    end
    
    # Sign in as doctor
    fill_in 'Email', with: 'john.watson@example.com'
    fill_in 'Password', with: 'Password123'
    
    doctor
  end

  test 'Add patient and details' do
    # Sign in as receptionist first
    receptionist = sign_in_as_receptionist
    
    # Start patient ad process
    visit root_path
    click_link 'Patients'
    assert_current_path patients_path
    
    assert_selector 'a', text: 'Add New patient'
    click_link 'Add New patient'
    
    # Patient details
    fill_in 'First name', with: 'James'
    fill_in 'Last name', with: 'Bond'
    fill_in 'Phone number', with: '0871234567'
    
    # Emergency contact details
    fill_in 'Emergency contact first name', with: 'Iron'
    fill_in 'Emergency contact last name', with: 'Woman'
    fill_in 'Emergency contact phone number', with: '0877654321'
    
    # Set alive status to true
    check 'Is patient alive'
    
    click_button 'Create Patient'
    
    # Ensure receptionist cannot see patient medical input fields
    assert_no_field 'Diagnosis'
    assert_no_field 'Treatment'
    assert_no_field 'Next appointment date'
    
    # Verify patient was created
    assert_equal 1, Patient.count
    
    # Sign out as receptionist
    click_button 'Log Out' if page.has_button?('Log Out')

    sleep(10)
    
    # Sign in as doctor to update medical information
    doctor = sign_in_as_doctor
    
    # Series of clicks to get to the patient's medical information
    click_link 'Patients'
    click_link 'James Bond'
    sleep(10)
    take_screenshot
    click_button 'Edit this patient'
    
    # Update medical information
    fill_in 'Diagnosis', with: 'Lung Cancer'
    fill_in 'Treatment', with: 'Chemotherapy'
    fill_in 'Next appointment date', with: (Date.today + 2.weeks).strftime('%Y-%m-%d')

    # Ensure doctor cannot edit patient's general information
    assert_no_field 'First name'
    assert_no_field 'Last name'
    assert_no_field 'Phone number'
    
    click_button 'Update Patient'
    
    assert_text 'Lung Cancer'
    assert_text 'Chemotherapy'
    
    take_screenshot('patient_medical_info_updated')
  end
end
