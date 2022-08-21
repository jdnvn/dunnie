class RoomsController < ApplicationController
  def index
    non_expired_rooms = current_user.rooms.where('rooms.expires_at > ?', Time.current)
    render json: { status: :ok, rooms: non_expired_rooms }
  end

  def create
    name = params['room']['name'] || SecureRandom.hex(10)
    expires_at = params['room']['expires_at']

    room = current_user.rooms.create!(name: name, expires_at: expires_at)
    ably_client = Ably::Rest.new(key: ENV['ABLY_SERVER_KEY'])
    channel = ably_client.channel('rooms')
    channel.publish('new room', room.as_json);

    if room
      render json: { status: :ok, room: room }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  def show
    room = current_user.rooms.find_by(id: params['id'])

    render json: { status: :not_found } unless room && room.expires_at > Time.current

    render json: { status: :ok, room: room }
  end
end
