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
    responses = HTTPalooza.invite.everyone.except_user_browser_lawl_w3m_and_lynx_because_it_only_returns_text_and_according_to_luke_that_is_by_design_and_keep_selenium_out_too_he_is_too_real_for_this_spec.get("http://httpbin.org/")
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
