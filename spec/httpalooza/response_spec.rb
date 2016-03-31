require 'spec_helper'

describe HTTPalooza::Response do
  it 'is equal to itself' do
    response = HTTPalooza::Response.new(200, 'response body')
    expect(response.eql?(response)).to be(true)
    expect(response == response).to be(true)
    expect(response.hash).to eq(response.hash)
  end

  it 'is equal to another identical repsonse' do
    response1 = HTTPalooza::Response.new(200, 'response body')
    response2 = HTTPalooza::Response.new(200, 'response body')
    expect(response1.eql?(response2)).to be(true)
    expect(response2.eql?(response1)).to be(true)
    expect(response1 == response2).to be(true)
    expect(response2 == response1).to be(true)
    expect(response1.hash).to eq(response2.hash)
  end

  it 'is not equal to a different response' do
    response1 = HTTPalooza::Response.new(200, 'response body')
    response2 = HTTPalooza::Response.new(301, 'response body')
    response3 = HTTPalooza::Response.new(200, 'another response body')
    response4 = HTTPalooza::Response.new(400, 'yet another response body')
    expect(response1.eql?(response2)).to be(false)
    expect(response1.eql?(response3)).to be(false)
    expect(response1.eql?(response4)).to be(false)
    expect(response1 == response2).to be(false)
    expect(response1 == response3).to be(false)
    expect(response1 == response4).to be(false)
    expect(response1.hash).to_not eq(response2.hash)
    expect(response1.hash).to_not eq(response3.hash)
    expect(response1.hash).to_not eq(response4.hash)
  end

  it 'is not equal to other object types' do
    response = HTTPalooza::Response.new(200, 'response body')
    [{}, [], "string", 1, :foo].each do |item|
      expect(response.eql?(item)).to be(false)
      expect(response == item).to be(false)
    end
  end
end
