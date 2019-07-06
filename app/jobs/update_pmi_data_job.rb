class UpdatePmiDataJob < ApplicationJob
  def perform
    Services::PageGetter.new.call
  end
end