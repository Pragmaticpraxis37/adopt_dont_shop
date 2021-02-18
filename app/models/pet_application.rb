class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.all_pets_statuses(applicant)
    statuses = PetApplication.where(application_id: applicant.id).distinct(:status).pluck(:status)
    if statuses.include?(nil)
      app_status = "Pending"
    elsif statuses.include?("Rejected")
      app_status = "Rejected"
    else
      app_status = "Accepted"
    end

    applicant.update(application_status: app_status)
  end
end
