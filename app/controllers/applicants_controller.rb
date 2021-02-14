class ApplicantsController < ApplicationController

  def show
    @applicant = Application.find(params[:applicant_id])
  end

  def new
  end

  def create
    require "pry"; binding.pry
    applicant = Application.new({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      application_status: params[:application_status],
      })

    require "pry"; binding.pry

    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
      flash[:notice] = "Application not created, please fill out all fields"
      render :new
    end
  end
end
