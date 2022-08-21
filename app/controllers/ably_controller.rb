class AblyController < ApplicationController
  def auth
    token_params = {
      ttl: 1.hour,
      client_id: params['username']
    }

    client = Ably::Rest.new(key: ENV['ABLY_SERVER_KEY'])
    render json: client.auth.create_token_request(token_params).to_json, status: :ok
  end
end
