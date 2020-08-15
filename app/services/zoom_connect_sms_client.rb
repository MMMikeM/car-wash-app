# Zoomconnect API Client
# This client is built to interact with zoom connect and send smses

class ZoomConnectSmsClient
  PROVIDER_URL=ENV['ZOOM_CLIENT_URL']

  def send(msisdn, message)
    @msisdn = "+#{msisdn}"
    @message = message
    HTTParty.post(PROVIDER_URL, body: request_body.to_json, basic_auth: auth, headers: { 'Content-Type' => 'application/json' })
  end

  private

  def request_body
    {
      "message" => @message,
      "recipientNumber" => @msisdn,
      "dateToSend" => (DateTime.now + 1.minute).strftime("%Y%m%d%H%M"),
      "campaign" => "Carbon Car Wash",
      "dataField" => "1234"
    }
  end

  def auth
    {username: ENV['ZOOM_CLIENT_USERNAME'], password: ENV['ZOOM_CLIENT_PASSWORD']}
  end
end