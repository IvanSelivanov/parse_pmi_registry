class PmiParserNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'pmi_parser_notifications_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
