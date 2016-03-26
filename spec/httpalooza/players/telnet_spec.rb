require 'spec_helper'

describe HTTPalooza::Players::TelnetPlayer do

  describe '#get' do
    it 'supports 200s' do
      response = make_request(:get, 'http://httpbin.org/get?httpalooza=true')
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['args']).to eq('httpalooza' => 'true')
    end

    it 'supports 204s' do
     response = make_request(:get, 'http://httpbin.org/status/204')
     expect(response.code).to eq(204)
     expect(response.body).to eq('')
    end

    it 'supports 301s' do
      response = make_request(:get, 'http://httpbin.org/status/301')
      expect(response.code).to eq(301)
      expect(response.body).to eq('')
    end

    it 'does not allow https' do
      expect do
        make_request(:get, 'https://httpbin.org/status/200')
      end.to raise_error('Unsupported scheme: https')
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
    it 'supports 200s with a body and header' do
      response = make_request(:post, 'http://httpbin.org/post', :payload => '{"httpalooza": true}', :headers => { 'Content-Type' => 'application/json' })
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['data']).to eq('{"httpalooza": true}')
      expect(JSON.load(response.body)['headers']).to include('Content-Type' => 'application/json')
    end
  end

  def make_request(method, url, options = {})
    HTTPalooza.invite.telnet!.public_send(method, url, options)[:telnet]
  end
end
