class SendSmsService
  MESSAGES = {
    new_customer: "Good day and welcome to The Carbon Car Wash loyalty program.",
    free_wash: "Congratulations! You have earned enough points to qualify for a free car wash."
  }
  PROVIDER_URL="https://www.zoomconnect.com/app/api/rest/v1/sms/send.json"

  def new(message_type)
    @message = MESSAGES[message_type]
  end

  def send(msisdn)
    @msisdn = "+#{msisdn}"
    HTTParty.post(PROVIDER_URL, body: request_body)
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
end
