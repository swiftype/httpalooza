require 'spec_helper'

describe HTTPalooza do
  it 'has a version number' do
    expect(HTTPalooza::VERSION).not_to be nil
  end

  it 'should be hilarious' do
    hilarious = true
    expect(hilarious).to eq(true)
  end

  it 'can make a request for everyone' do
    responses = HTTPalooza.invite.everyone.except_user_browser_lawl.get("http://httpbin.org/")
    unique_responses = {}
    non_awesome_players = {}
    responses.each do |player_name, response|
      if unique_responses.keys.include?(response)
        unique_responses[response] << player_name
      else
        unique_responses[response] = [ player_name ]
      end
      non_awesome_players[player_name] = response unless response.awesome?
    end
    expect(unique_responses.count).to eq(1), "Not all players got the same response! #{unique_responses.values}"
    expect(non_awesome_players).to eq({}), "Some players were not awesome! #{non_awesome_players}"
  end
end
