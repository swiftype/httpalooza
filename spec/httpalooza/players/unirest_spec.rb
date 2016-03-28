require 'spec_helper'

describe HTTPalooza::Players::UnirestPlayer do

 it 'can make a get request' do
   response = HTTPalooza.invite.that_unirest_guy.get("http://google.com")[:unirest]
   expect(response.nil?).to be(false)
   expect(response.awesome?).to be(true)
 end
end
