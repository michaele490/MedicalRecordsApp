class PatientsController < ApplicationController
  before_action :authenticate_doctor_or_receptionist!
  before_action :set_patient, only: %i[ show edit update destroy ]

  # Making sure only signed in doctors or receptionits can access the patients pages
  #=begin

  def authenticate_doctor_or_receptionist!
    # puts "🔍 doctor_signed_in?: #{doctor_signed_in?}"
    # puts "🔍 receptionist_signed_in?: #{receptionist_signed_in?}"

    unless doctor_signed_in? || receptionist_signed_in?
      redirect_to root_path, alert: "Please sign into doctor or receptionist account to access patients."
    end
  end
  #=end
  #

  # GET /patients or /patients.json
  def index
    @patients = Patient.all
  end

  # GET /patients/1 or /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients or /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: "Patient was successfully created." }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: "Patient was successfully updated." }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    @patient.destroy!

    respond_to do |format|
      format.html { redirect_to patients_path, status: :see_other, notice: "Patient was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:first_name, :last_name, :dob, :is_alive, :emergency_contact_first_name, :emergency_contact_last_name, :emergency_contact_phone_number, :phone_number, :diagnosis)
    end
end
