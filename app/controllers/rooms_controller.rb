class RoomsController < ApplicationController
  def index
    non_expired_rooms = current_user.rooms.where('rooms.expires_at > ?', Time.current)
    render json: { status: :ok, rooms: non_expired_rooms }
  end

  def create
    name = params.dig(:room, :name) || SecureRandom.hex(10)
    expires_at = params.dig(:room, :expires_at)
    latitude = params.dig(:room, :coordinates, :latitude)
    longitude = params.dig(:room, :coordinates, :longitude)
    type = params.dig(:room, :type)

    room = current_user.rooms.create!(
      name: name,
      type: type,
      expires_at: expires_at,
      latitude: latitude,
      longitude: longitude
    )

    return render json: { status: :unprocessable_entity } unless room

    ably_client = Ably::Rest.new(key: ENV['ABLY_SERVER_KEY'])
    channel = ably_client.channel('rooms')
    channel.publish("room #{room.id}", room.as_json);

    render json: { status: :ok, room: room }
  end

  def show
    room = current_user.rooms.find_by(id: params['id'])

    render json: { status: :not_found } unless room && room.expires_at > Time.current

    render json: { status: :ok, room: room }
  end
end
