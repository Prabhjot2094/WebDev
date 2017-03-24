class Request < ApplicationRecord
validates :request_to, uniqueness: { scope: :request_from,
    message: "should happen once per year" }
end
