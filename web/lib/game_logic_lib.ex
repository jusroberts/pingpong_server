defmodule PingpongServer.GameLogicLib do

  def show_score(current_team_score, opponent_score) do
    cond do
      current_team_score < 20 && opponent_score <= 20 ->
        current_team_score
      first_team_wins(current_team_score, opponent_score) ->
        "W"
      first_team_wins(opponent_score, current_team_score) ->
        "L"
      current_team_score == opponent_score ->
        "D"
      current_team_score == 20 && opponent_score < 20 ->
        "G"
      current_team_score > opponent_score ->
        "ADV"
      current_team_score < opponent_score ->
        "-"
      true ->
        "U"
    end
  end

  def game_over?(team_a_score, team_b_score) do
    first_team_wins(team_a_score, team_b_score) || first_team_wins(team_b_score, team_a_score)
  end

  defp first_team_wins(score1, score2) do
    score1 > 20 && (score1 - score2 >= 2)
  end



end
