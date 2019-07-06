class PmiDataController < ApplicationController
  def update
    UpdatePmiDataJob.perform_later
    redirect_to root_path, notice: 'Data is updating. Please refresh page in 15 minutes.'
  end
end
