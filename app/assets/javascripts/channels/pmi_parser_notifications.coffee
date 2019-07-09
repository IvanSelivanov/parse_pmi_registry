App.pmi_parser_notifications = App.cable.subscriptions.create "PmiParserNotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
#    console.log('success')
    document.location.reload()
