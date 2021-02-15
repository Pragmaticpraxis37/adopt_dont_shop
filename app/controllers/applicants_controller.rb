class ApplicantsController < ApplicationController

  def show
    @applicant = Application.find(params[:applicant_id])
    @pets = Pet.search_pet_name(params[:query]) unless params[:query].nil?
    if !params[:pet_id].nil?
      @pet = Pet.find(params[:pet_id])
      @add_pet = PetApplication.create!(application: @applicant, pet: @pet)
    end
  end

  def new
  end

  def create
    applicant = Application.new({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      application_status: params[:application_status],
      })

    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
      flash[:notice] = "Application not created, please fill out all fields"
      render :new
    end
  end
end
