defmodule PingpongServer.RoomController do
  require IEx

  use PingpongServer.Web, :controller

  alias PingpongServer.Room

  plug :scrub_params, "room" when action in [:create, :update]

  def increment(conn, %{"id" => id, "team" => team}) do
    room = Repo.get!(Room, id)

    key = "team_#{team}_score"
    team_score = Map.fetch!(room, :"#{key}") + 1
    params = cond do
      PingpongServer.GameLogicLib.game_over?(room.team_a_score, room.team_b_score) ->
        %{team_a_score: 0, team_b_score: 0}
      true ->
        %{key => team_score}
    end
    changeset = Room.changeset(room, params)

    case Repo.update(changeset) do
      {:ok, room} ->
        team_a_show_score = PingpongServer.GameLogicLib.show_score(room.team_a_score, room.team_b_score)
        team_b_show_score = PingpongServer.GameLogicLib.show_score(room.team_b_score, room.team_a_score)
        PingpongServer.Endpoint.broadcast("rooms:#{id}", "team_a_score", %{body: team_a_show_score})
        PingpongServer.Endpoint.broadcast("rooms:#{id}", "team_b_score", %{body: team_b_show_score})
        text conn, "OK"
      {:error, changeset} ->
        text conn, "FAIL #{changeset}"
    end
  end

  def index(conn, _params) do
    rooms = Repo.all(Room)
    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"room" => room_params}) do
    room_params = Map.put(room_params, "team_a_score", 0)
    room_params = Map.put(room_params, "team_b_score", 0)
    changeset = Room.changeset(%Room{}, room_params)

    case Repo.insert(changeset) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: room_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)
    team_a_show_score = PingpongServer.GameLogicLib.show_score(room.team_a_score, room.team_b_score)
    team_b_show_score = PingpongServer.GameLogicLib.show_score(room.team_b_score, room.team_a_score)
    render(conn, "show.html", %{:room => room, :"team_a_show_score" => team_a_show_score, :"team_b_show_score" => team_b_show_score})
  end

  def edit(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)
    changeset = Room.changeset(room)
    render(conn, "edit.html", room: room, changeset: changeset)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Repo.get!(Room, id)
    changeset = Room.changeset(room, room_params)

    case Repo.update(changeset) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: room_path(conn, :show, room))
      {:error, changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(room)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: room_path(conn, :index))
  end
end
