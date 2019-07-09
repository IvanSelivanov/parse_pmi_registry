class UpdatePmiDataJob < ApplicationJob
  def perform
    Services::PageGetter.new.call
    ActionCable.server.broadcast 'pmi_parser_notifications_channel', message: 'done'
  end
end