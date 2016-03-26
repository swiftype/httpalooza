module HTTPalooza
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
