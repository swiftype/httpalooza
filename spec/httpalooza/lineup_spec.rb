require "spec_helper"

describe HTTPalooza::Lineup do
  let(:lineup) { HTTPalooza::Lineup.new }

  context ".everyone" do
    it "adds all players" do
      expect(lineup.players).to be_empty
      lineup.everyone
      expect(lineup.players).to_not be_empty
      expect(lineup.players).to match_array(HTTPalooza::Players.available)
    end
  end

  context ".uninvite_*" do
    it "removes players" do
      lineup.everyone.uninvite_curl
      expect(lineup.players).to_not include(HTTPalooza::Players::CurlPlayer)
      expect(lineup.players).to include(HTTPalooza::Players::PatronPlayer)
      expect(lineup.players).to include(HTTPalooza::Players::UserBrowserPlayer)
      lineup.except_patron
      expect(lineup.players).to_not include(HTTPalooza::Players::CurlPlayer)
      expect(lineup.players).to_not include(HTTPalooza::Players::PatronPlayer)
      expect(lineup.players).to include(HTTPalooza::Players::UserBrowserPlayer)
      lineup.without_user_browser
      expect(lineup.players).to_not include(HTTPalooza::Players::CurlPlayer)
      expect(lineup.players).to_not include(HTTPalooza::Players::PatronPlayer)
      expect(lineup.players).to_not include(HTTPalooza::Players::UserBrowserPlayer)
    end
  end
end
