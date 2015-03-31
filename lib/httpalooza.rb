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
require 'httpalooza/players/curb'
require 'httpalooza/players/typhoeus'
require 'httpalooza/players/patron'
require 'httpalooza/players/http_client'
require 'httpalooza/players/curl'
require 'httpalooza/players/user_browser'
require 'httpalooza/players/net_http'
require 'httpalooza/players/rest_client'

module HTTPalooza
  class Error < StandardError; end
  class NotImplementedError < Error; end

  def self.invite
    Lineup.new
  end
end
