require 'rails_helper'

RSpec.describe 'the competition show page' do

  it 'lists the competition attributes' do

    competition = Competition.create!(name: 'World Cup', location: 'La Paz', sport: 'Cricket')
    other_competition = Competition.create!(name: 'Field Day', location: 'Reno', sport: 'polo')
    team_1 = Team.create!(nickname: 'Rabbits', hometown: 'Toledo')
    player_1 = team_1.players.create!(name: "KAYLEEN UCHINO", age: 21)
    player_2 = team_1.players.create!(name: "BRADY BULIN", age: 29)
    team_2 = Team.create!(nickname: 'Weasels', hometown: 'Alto')
    player_3 = team_2.players.create!(name: "MALCOLM INGEBRIGTSEN", age: 24)
    player_4 = team_2.players.create!(name: "FRANCIS ORELL", age: 32)
    CompetitionTeam.create(team_id: team_1.id, competition_id: competition.id)
    CompetitionTeam.create(team_id: team_2.id, competition_id: competition.id)

    visit "/competitions/#{competition.id}"

    expect(page).to have_content(competition.name)
    expect(page).to have_content(competition.location)
    expect(page).to have_content(competition.sport)
    expect(page).not_to have_content(other_competition.name)
  end

  it 'lists the competitions team attributes' do

    competition = Competition.create!(name: 'World Cup', location: 'La Paz', sport: 'Cricket')
    team_1 = Team.create!(nickname: 'Rabbits', hometown: 'Toledo')
    player_1 = team_1.players.create!(name: "KAYLEEN UCHINO", age: 21)
    player_2 = team_1.players.create!(name: "BRADY BULIN", age: 29)
    team_2 = Team.create!(nickname: 'Weasels', hometown: 'Alto')
    player_3 = team_2.players.create!(name: "MALCOLM INGEBRIGTSEN", age: 24)
    player_4 = team_2.players.create!(name: "FRANCIS ORELL", age: 32)
    CompetitionTeam.create(team_id: team_1.id, competition_id: competition.id)
    CompetitionTeam.create(team_id: team_2.id, competition_id: competition.id)

    other_competition = Competition.create!(name: 'Field Day', location: 'Reno', sport: 'polo')
    other_team = Team.create!(nickname: 'Astros', hometown: 'Houston')
    CompetitionTeam.create(team_id: other_team.id, competition_id: other_competition.id)

    visit "/competitions/#{competition.id}"

    expect(page).to have_content("Team: #{team_1.nickname}")
    expect(page).to have_content("Hometown: #{team_1.hometown}")
    expect(page).to have_content("Team: #{team_2.nickname}")
    expect(page).to have_content("Hometown: #{team_2.hometown}")

    expect(page).not_to have_content(other_competition.name)
    expect(page).not_to have_content(other_team.nickname)
  end

  it 'lists the average age of all players in this competition' do

    competition = Competition.create!(name: 'World Cup', location: 'La Paz', sport: 'Cricket')
    team_1 = Team.create!(nickname: 'Rabbits', hometown: 'Toledo')
    player_1 = team_1.players.create!(name: "KAYLEEN UCHINO", age: 20)
    player_2 = team_1.players.create!(name: "BRADY BULIN", age: 30)
    team_2 = Team.create!(nickname: 'Weasels', hometown: 'Alto')
    player_3 = team_2.players.create!(name: "MALCOLM INGEBRIGTSEN", age: 40)
    player_4 = team_2.players.create!(name: "FRANCIS ORELL", age: 50)
    CompetitionTeam.create(team_id: team_1.id, competition_id: competition.id)
    CompetitionTeam.create(team_id: team_2.id, competition_id: competition.id)

    other_competion = Competition.create!(name: 'Field Day', location: 'Reno', sport: 'polo')
    other_team = Team.create!(nickname: 'Astros', hometown: 'Houston')
    other_player = other_team.players.create!(name: "Methuselah", age: 1000)
    CompetitionTeam.create(team_id: other_team.id, competition_id: other_competion.id)

    visit "/competitions/#{competition.id}"

    expect(page).to have_content("Average Player Age: 35")
  end

  it 'can register an existing team' do
    competition = Competition.create!(name: 'World Cup', location: 'La Paz', sport: 'Cricket')
    team_1 = Team.create!(nickname: 'Rabbits', hometown: 'Toledo')
    team_2 = Team.create!(nickname: 'Weasels', hometown: 'Alto')
    team_3 = Team.create!(nickname: 'Squids', hometown: 'St. Petersburg')
    CompetitionTeam.create(team_id: team_1.id, competition_id: competition.id)
    CompetitionTeam.create(team_id: team_2.id, competition_id: competition.id)

    visit "/competitions/#{competition.id}"

    expect(page).to have_content(team_1.nickname)
    expect(page).to have_content(team_2.nickname)
    expect(page).not_to have_content(team_3.nickname)

    fill_in('Nickname', with: 'Squids')
    click_button('Register')

    expect(current_path).to eq("/competitions/#{competition.id}")
    expect(page).to have_content(team_1.nickname)
    expect(page).to have_content(team_2.nickname)
    expect(page).to have_content(team_3.nickname)

  end
end
