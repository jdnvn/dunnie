class LocalRoomsController < ApplicationController
  def index
    latitude = params.dig(:latitude)&.to_f
    longitude = params.dig(:longitude)&.to_f
    radius = params.dig(:radius)&.to_f

    active_rooms_in_range = LocalRoom.active.near([latitude, longitude], radius) || []
    render json: { status: :ok, rooms: active_rooms_in_range }
  end
end
