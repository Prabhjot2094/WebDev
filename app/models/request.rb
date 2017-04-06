class Request < ApplicationRecord
validates :request_to, uniqueness: { scope: :request_from,
    message: "should happen once per year" }

def self.send_message(mobileNumber, message)
	require 'twilio-ruby'

	accountSid = 'AC930b1b72f263207aa6aa89aab1fd05a3'
	authToken = '7792bd90391879f7703ae6e2484cdf38'

	begin
		@client = Twilio::REST::Client.new accountSid, authToken
		message = @client.account.messages.create(:body => message,
			:to => "+91"+mobileNumber.to_s,    # Replace with your phone number
			:from => "2053922256")  # Replace with your Twilio number
	rescue Twilio::REST::RequestError => e
		puts e.message
	end
end

end
