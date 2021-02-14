class ApplicantsController < ApplicationController

  def show
    @applicant = Application.find(params[:applicant_id])
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

    applicant.save
    redirect_to "/applicants/#{applicant.id}"
  end
end
