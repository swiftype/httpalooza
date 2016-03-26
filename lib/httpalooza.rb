require 'active_support/all'
require 'addressable/uri'
require 'rack/utils'
require 'awesome_print'

require 'httpalooza/version'
require 'httpalooza/api'
require 'httpalooza/players'
require 'httpalooza/response'
require 'httpalooza/request'
require 'httpalooza/lineup'

require 'httpalooza/players/base'
Dir[File.join(File.dirname(__FILE__), 'httpalooza', 'players', '*.rb')].each do |player|
  require player
end

module HTTPalooza
  class Error < StandardError; end
  class NotImplementedError < Error; end

  def self.invite
    Lineup.new
  end
end
