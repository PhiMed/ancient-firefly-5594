class Team < ApplicationRecord
  has_many :players
  has_many :competition_teams
  has_many :competitions, through: :competition_teams

  def self.sorted_by_avg_player_age
    Team.select("teams.*, avg(age) as avg_age")
        .joins(:players)
        .group(:id)
        .order("avg_age DESC")
  end

end
