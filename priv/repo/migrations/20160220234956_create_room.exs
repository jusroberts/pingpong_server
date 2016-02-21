defmodule PingpongServer.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :client_token, :string
      add :team_a_score, :integer
      add :team_b_score, :integer
      add :name, :string

      timestamps
    end

  end
end
