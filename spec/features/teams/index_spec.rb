require 'rails_helper'

RSpec.describe 'the teams index page' do

  it 'lists the names and hometowns of all teams' do
    team_1 = Team.create!(nickname: 'Rabbits', hometown: 'Toledo')
    player_1 = team_1.players.create!(name: "KAYLEEN UCHINO", age: 21)
    player_2 = team_1.players.create!(name: "BRADY BULIN", age: 29)
    team_2 = Team.create!(nickname: 'Weasels', hometown: 'Alto')
    player_3 = team_2.players.create!(name: "MALCOLM INGEBRIGTSEN", age: 24)
    player_4 = team_2.players.create!(name: "FRANCIS ORELL", age: 32)

    visit '/teams'

    expect(page).to have_content("Team: #{team_1.nickname}")
    expect(page).to have_content("Hometown: #{team_1.hometown}")
    expect(page).to have_content("Team: #{team_2.nickname}")
    expect(page).to have_content("Hometown: #{team_2.hometown}")
  end

  it 'lists the players names and ages under each team' do
    team_1 = Team.create!(nickname: 'Rabbits', hometown: 'Toledo')
    player_1 = team_1.players.create!(name: "KAYLEEN UCHINO", age: 21)
    player_2 = team_1.players.create!(name: "BRADY BULIN", age: 29)
    team_2 = Team.create!(nickname: 'Weasels', hometown: 'Alto')
    player_3 = team_2.players.create!(name: "MALCOLM INGEBRIGTSEN", age: 24)
    player_4 = team_2.players.create!(name: "FRANCIS ORELL", age: 32)

    visit '/teams'

    within("#team-#{team_1.id}") do
      expect(page).to have_content("KAYLEEN UCHINO")
      expect(page).to have_content("21")
      expect(page).to have_content("BRADY BULIN")
      expect(page).to have_content("29")
      expect(page).not_to have_content("MALCOLM INGEBRIGTSEN")
      expect(page).not_to have_content("24")
      expect(page).not_to have_content("FRANCIS ORELL")
      expect(page).not_to have_content("23")
    end

    within("#team-#{team_2.id}") do
      expect(page).not_to have_content("KAYLEEN UCHINO")
      expect(page).not_to have_content("21")
      expect(page).not_to have_content("BRADY BULIN")
      expect(page).not_to have_content("29")
      expect(page).to have_content("MALCOLM INGEBRIGTSEN")
      expect(page).to have_content("24")
      expect(page).to have_content("FRANCIS ORELL")
      expect(page).to have_content("32")
    end
  end

# extension

  it 'displays teams sorted by teams average player age' do
    medium_team = Team.create!(nickname: 'Medium Team', hometown: 'Alto')
    player_3 = medium_team.players.create!(name: "MALCOLM INGEBRIGTSEN", age: 30)
    player_4 = medium_team.players.create!(name: "FRANCIS ORELL", age: 32)
    young_team = Team.create!(nickname: 'Young Team', hometown: 'Fairbanks')
    player_3 = young_team.players.create!(name: "MAYER STANICK", age: 10)
    player_4 = young_team.players.create!(name: "BORUCH LEAVELL", age: 12)
    old_team = Team.create!(nickname: 'Old Team', hometown: 'Toledo')
    player_1 = old_team.players.create!(name: "KAYLEEN UCHINO", age: 60)
    player_2 = old_team.players.create!(name: "BRADY BULIN", age: 62)

    visit '/teams'

    expect(old_team.nickname).to appear_before(medium_team.nickname)
    expect(medium_team.nickname).to appear_before(young_team.nickname)
  end

end
