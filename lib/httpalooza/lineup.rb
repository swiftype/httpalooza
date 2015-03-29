module HTTPalooza
  class Lineup
    include API

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

    def method_missing(name, *args, &blk)
      matched_players = Players.available.select do |player|
        name.to_s.include?(player.name.to_s)
      end

      return super(name, *args, &blk) if matched_players.empty?

      players.merge(matched_players)
      self
    end
  end
end
