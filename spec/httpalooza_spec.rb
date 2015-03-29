require 'spec_helper'

describe HTTPalooza do
  it 'has a version number' do
    expect(HTTPalooza::VERSION).not_to be nil
  end

  it 'should be hilarious' do
    hilarious = true
    expect(hilarious).to eq(true)
  end
end
