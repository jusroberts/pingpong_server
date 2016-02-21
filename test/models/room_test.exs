defmodule PingpongServer.RoomTest do
  use PingpongServer.ModelCase

  alias PingpongServer.Room

  @valid_attrs %{client_token: "some content", name: "some content", team_a_score: 42, team_b_score: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end
end
