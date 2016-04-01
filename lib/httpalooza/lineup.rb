module HTTPalooza
  # A Lineup assembles a set of Players to perform HTTP requests.
  #
  # @example Perform a request with curb
  #   lineup = HTTPalooza::Lineup.new.with_curb
  #   response = lineup.get('http://httpbin.org/')
  #   response[:curb] #=> Get the response from Curb
  #
  # @example Performing multiple requests
  #   lineup = HTTPalooza::Lineup.new.with_curb.and_unirest
  #   lineup.get('http://httpbin.org/')
  #   response[:curb] #=> Get the response from Curb
  #   response[:unirest] #=> Get the response from Unirest
  class Lineup
    include API

    UNINVITE_REGEX = /^(uninvite|but|not|except|without|save|besides?|minus|barring|excluding|omitting|exempting|other_than|apart_from|aside_from)_(.+)/i

    attr_reader :players

    def initialize
      @players = Set.new
    end

    def run!(request)
      players.inject({}) do |responses, player|
        responses[player.name] = player.execute!(request)
        responses
      end
    end

    # Return a Lineup with all available Players
    def everyone
      players.merge(Players.available)
      self
    end

    def method_missing(name, *args, &blk)
      if uninvite = UNINVITE_REGEX.match(name)
        name = uninvite.captures.second
      end

      matched_players = Players.available.select do |player|
        name.to_s.include?(player.name.to_s)
      end

      return super(name, *args, &blk) if matched_players.empty?

      if uninvite
        players.subtract(matched_players)
      else
        players.merge(matched_players)
      end

      self
    end
  end
end
