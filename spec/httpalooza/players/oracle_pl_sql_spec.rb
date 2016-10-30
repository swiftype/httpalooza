require 'spec_helper'

describe HTTPalooza::Players::OraclePLSQLPlayer do
  before(:all) do
    @skip_all_tests = begin
      require 'oci8'
      OCI8.new('system', 'oracle', 'localhost')
      false
    rescue => e
      true
    end
  end

  before(:each) do
    if @skip_all_tests
      skip("Oracle Database is probably not configured correctly or not running at all; skipping tests")
    end
  end

  describe '#get' do
    it 'supports 200s' do
      response = make_request(:get, 'http://httpbin.org/get?httpalooza=true')
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['args']).to eq('httpalooza' => 'true')
    end

    it 'supports 200s with hash payload' do
      response = make_request(:get, 'http://httpbin.org/get', :payload => { :httpalooza => true })
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['args']).to eq('httpalooza' => 'true')
    end

    it 'supports application/json header' do
      response = make_request(:get, 'http://httpbin.org/get', :payload => { :httpalooza => true }, :headers => { 'Content-Type' => 'application/json'})
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['args']).to eq('httpalooza' => 'true')
    end

    it 'does not support other headers' do
      expect { make_request(:get, 'http://httpbin.org/get', :payload => { :httpalooza => true }, :headers => { 'httpalooza' => 'is-awesome'}) }.to raise_error(/doesn't currently support headers other than application\/json/)
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
      expect(JSON.load(response.body)['json']).to eq({'httpalooza' => true})
    end

    it 'supports 200s with json payload' do
      response = make_request(:post, 'http://httpbin.org/post', :payload => '{ "httpalooza": true }')
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['json']).to eq({'httpalooza' => true})
    end
  end

  describe '#put' do
    it 'supports 200s with hash payload' do
      response = make_request(:put, 'http://httpbin.org/put', :payload => { :httpalooza => true })
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['json']).to eq({'httpalooza' => true})
    end
  end

  describe '#delete' do
    it 'supports 200s with hash payload' do
      response = make_request(:delete, 'http://httpbin.org/delete', :payload => { :id => 96 })
      expect(response.code).to eq(200)
      expect(JSON.load(response.body)['json']).to eq({'id' => 96})
    end
  end

  def make_request(method, url, options = {})
    HTTPalooza.invite.i_guess_oracle_pl_sql_can_come_too.public_send(method, url, options)[:oracle_pl_sql]
  end
end
