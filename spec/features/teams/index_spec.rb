require 'rails_helper'

RSpec.describe 'the teams index page' do

  it 'lists the names and hometowns of all teams' do
    team_1 = Team.create!(nickname: 'Rabbits', hometown: 'Toledo', sport: 'soccer')
    player_1 = team_1.players.create!(name: "KAYLEEN UCHINO", age: 21)
    player_2 = team_1.players.create!(name: "BRADY BULIN", age: 29)
    team_2 = Team.create!(nickname: 'Weasels', hometown: 'Alto', sport: 'basketball')
    player_3 = team_2.players.create!(name: "MALCOLM INGEBRIGTSEN", age: 24)
    player_4 = team_2.players.create!(name: "FRANCIS ORELL", age: 32)

    visit '/teams'

    expect(page).to have_content("Team: #{team_1.nickname}")
    expect(page).to have_content("Hometown: #{team_1.hometown}")
    expect(page).to have_content("Team: #{team_2.nickname}")
    expect(page).to have_content("Hometown: #{team_2.hometown}")
  end

  it 'lists the players names and ages under each team' do

    visit '/teams'

    within("#team-#{team_1.id}") do
      expect(page).to have_content("KAYLEEN UCHINO")
      expect(page).to have_content("BRADY BULIN")
      expect(page).not_to have_content("MALCOLM INGEBRIGTSEN")
      expect(page).not_to have_content("FRANCIS ORELL")
    end

    within("team-#{team_2.id}") do
      expect(page).not_to have_content("KAYLEEN UCHINO")
      expect(page).not_to have_content("BRADY BULIN")
      expect(page).to have_content("MALCOLM INGEBRIGTSEN")
      expect(page).to have_content("FRANCIS ORELL")
    end
  end
end
