defmodule PingpongServer.Room do
  use PingpongServer.Web, :model

  schema "rooms" do
    field :client_token, :string
    field :team_a_score, :integer
    field :team_b_score, :integer
    field :name, :string

    timestamps
  end

  @required_fields ~w(client_token name)
  @optional_fields ~w(team_a_score team_b_score)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
