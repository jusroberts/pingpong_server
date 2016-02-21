defmodule PingpongServer.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("rooms:" <> _room_id, _params, socket) do
    {:ok, socket}
  end

end
