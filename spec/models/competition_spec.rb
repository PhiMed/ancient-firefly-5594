require 'rails_helper'

RSpec.describe Competition do
  describe 'relationships' do
    it { should have_many :competition_teams }
    it {should have_many(:teams).through(:competition_teams)}
  end

  it 'average_player_age' do

    competition = Competition.create!(name: 'World Cup', location: 'La Paz', sport: 'cricket')
    team_1 = Team.create!(nickname: 'Rabbits', hometown: 'Toledo')
    player_1 = team_1.players.create!(name: "KAYLEEN UCHINO", age: 20)
    player_2 = team_1.players.create!(name: "BRADY BULIN", age: 30)
    team_2 = Team.create!(nickname: 'Weasels', hometown: 'Alto')
    player_3 = team_2.players.create!(name: "MALCOLM INGEBRIGTSEN", age: 40)
    player_4 = team_2.players.create!(name: "FRANCIS ORELL", age: 50)
    CompetitionTeam.create(team_id: team_1.id, competition_id: competition.id)
    CompetitionTeam.create(team_id: team_2.id, competition_id: competition.id)

    other_competition = Competition.create!(name: 'Field Day', location: 'Reno', sport: 'polo')
    other_team = Team.create!(nickname: 'Astros', hometown: 'Houston')
    other_player = other_team.players.create!(name: "Methuselah", age: 1000)
    CompetitionTeam.create(team_id: other_team.id, competition_id: other_competition.id)

    expect(competition.average_player_age).to eq(35)
    expect(other_competition.average_player_age).to eq(1000)
  end

end
