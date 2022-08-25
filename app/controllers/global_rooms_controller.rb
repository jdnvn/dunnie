class GlobalRoomsController < ApplicationController
  def index
    render json: { status: :ok, rooms: GlobalRoom.active }
  end
end
