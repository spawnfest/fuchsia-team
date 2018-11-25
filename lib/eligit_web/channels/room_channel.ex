defmodule EligitWeb.RoomChannel do
  use Phoenix.Channel

  intercept ["cake"]

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_out("cake", msg, socket) do
    push(socket, "cake", msg)
    {:noreply, socket}
  end
end
