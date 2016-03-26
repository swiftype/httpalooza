require 'spec_helper'

describe HTTPalooza::Players::SeleniumPlayer do

  describe '#get' do
    it 'supports 200s' do
      response = make_request(:get, 'http://httpbin.org/get?httpalooza=true')
      expect(response.code).to eq(200)
      expect(response.body).to include('"httpalooza": "true"')
    end

    it 'follows 301s' do
      response = make_request(:get, 'http://httpbin.org/status/301')
      expect(response.code).to eq(200)
     expect(response.body).to include('http://httpbin.org/get')
    end
  end

  describe '#post' do
    it 'supports 200s with hash payload' do
      response = make_request(:post, 'http://httpbin.org/post', :payload => { :httpalooza => true })
      expect(response.code).to eq(200)
      expect(response.body).to include('"httpalooza": "true"')
    end

    it 'supports 200s with json payload' do
      response = make_request(:post, 'http://httpbin.org/post', :payload => '{ "httpalooza": true }')
      expect(response.code).to eq(200)
      expect(response.body).to include('"httpalooza": "true"')
    end
  end

  describe '#put' do
    it 'supports 200s with header' do
      response = make_request(:put, 'http://httpbin.org/put', :payload => 'httpalooza=true', :headers => { 'X-Httpalooza-Is' => 'the-best' })
      expect(response.code).to eq(200)
      expect(response.body).to include('httpalooza=true')
      expect(response.body).to include('"X-Httpalooza-Is": "the-best"')
    end
  end

  describe '#delete' do
    it 'supports 200s with header' do
      response = make_request(:delete, 'http://httpbin.org/delete', :payload => 'httpalooza=true', :headers => { 'X-Httpalooza-Is' => 'the-best' })
      expect(response.code).to eq(200)
      expect(response.body).to include('httpalooza=true')
      expect(response.body).to include('"X-Httpalooza-Is": "the-best"')
    end
  end

  describe '#head' do
    it 'supports 200s and does not return a body' do
      response = make_request(:head, 'http://httpbin.org/status/200')
      expect(response.code).to eq(200)
      expect(response.body).to eq('')
    end
  end

  def make_request(method, url, options = {})
    HTTPalooza.invite.i_guess_selenium_can_come_too.public_send(method, url, options)[:selenium]
  end
end
