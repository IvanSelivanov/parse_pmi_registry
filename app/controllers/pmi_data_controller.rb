class PmiDataController < ApplicationController
  def update
    UpdatePmiDataJob.perform_later
    redirect_to root_path, notice: 'Data is updating. Page will refresh automatically when the process is complete.'
  end
end
