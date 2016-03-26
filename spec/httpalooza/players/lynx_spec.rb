require 'spec_helper'

describe HTTPalooza::Players::LynxPlayer do

  before :each do
    `which lynx`

    unless $? == 0
      skip("`lynx` is not installed; skipping tests")
    end
  end

  describe '#get' do
    it 'supports 200s' do
      response = make_request(:get, 'http://httpbin.org/get?httpalooza=true')
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['args']).to eq('httpalooza' => 'true')
    end
  end

  describe '#head' do
    it 'supports 200s and does not return a body' do
      response = make_request(:head, 'http://httpbin.org/status/200')
      expect(response.code).to eq(200)
      expect(response.body).to eq('')
    end
  end

  describe '#post' do
    it 'supports 200s with form parameters' do
      response = make_request(:post, 'http://httpbin.org/post', :params => {'httpalooza' => 'true'})
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['form']).to eq({"httpalooza" => 'true'})
    end
  end

  def make_request(method, url, options = {})
    HTTPalooza.invite.lynx!.public_send(method, url, options)[:lynx]
  end
end
