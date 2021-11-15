require 'rails_helper'

RSpec.describe Team do
  describe 'relationships' do
    it { should have_many(:players) }
    it { should have_many :competition_teams }
    it {should have_many(:competitions).through(:competition_teams)}
  end

  describe 'class methods' do
    it 'sorted_by_avg_player_age' do
      medium_team = Team.create!(nickname: 'Medium Team', hometown: 'Alto')
      player_3 = medium_team.players.create!(name: "MALCOLM INGEBRIGTSEN", age: 30)
      player_4 = medium_team.players.create!(name: "FRANCIS ORELL", age: 32)
      young_team = Team.create!(nickname: 'Young Team', hometown: 'Fairbanks')
      player_3 = young_team.players.create!(name: "MAYER STANICK", age: 10)
      player_4 = young_team.players.create!(name: "BORUCH LEAVELL", age: 12)
      old_team = Team.create!(nickname: 'Old Team', hometown: 'Toledo')
      player_1 = old_team.players.create!(name: "KAYLEEN UCHINO", age: 60)
      player_2 = old_team.players.create!(name: "BRADY BULIN", age: 62)

      expect(Team.sorted_by_avg_player_age.first).to eq(old_team)
      expect(Team.sorted_by_avg_player_age.second).to eq(medium_team)
      expect(Team.sorted_by_avg_player_age.third).to eq(young_team)
    end
  end

end
