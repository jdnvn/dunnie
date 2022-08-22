class RoomsController < ApplicationController
  def index
    non_expired_rooms = Room.where('rooms.expires_at > ?', Time.current)
    render json: { status: :ok, rooms: non_expired_rooms }
  end

  def create
    name = params.dig(:room, :name) || SecureRandom.hex(10)
    expires_at = params.dig(:room, :expires_at) || Time.current + 1.day
    latitude = params.dig(:room, :coordinates, :latitude)
    longitude = params.dig(:room, :coordinates, :longitude)
    type = params.dig(:room, :type)

    room = Room.create!(
      name: name,
      type: type,
      expires_at: expires_at,
      latitude: latitude,
      longitude: longitude
    )

    if current_user
      current_user.rooms << room
      current_user.save!
    end

    return render json: { status: :unprocessable_entity } unless room

    ably_client = Ably::Rest.new(key: ENV['ABLY_SERVER_KEY'])
    channel = ably_client.channel('rooms')
    channel.publish("room #{room.id}", room.as_json);

    render json: { status: :ok, room: room }
  end

  def show
    room = Room.find_by(id: params['id'])

    return render json: { status: :not_found } unless room && room.expires_at > Time.current

    render json: { status: :ok, room: room }
  end
end
