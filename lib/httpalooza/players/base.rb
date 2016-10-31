module HTTPalooza
  module Players
    # Superclass for Player implementations
    # @abstract
    class Base
      class << self
        attr_reader :name, :dependencies

        # Create a new player and require any dependencies.
        #
        # @example
        #   introducing! :selenium, %w[ selenium-webdriver ]
        #
        # @param [Symbol] name the name of the player
        # @param [Array] dependencies a list of dependencies require in order to use this player
        def introducing!(name, dependencies = [])
          @name = name.to_sym
          @dependencies = dependencies
          Players.add(self)
        end

        def execute!(request)
          new(request).response
        end
      end

      attr_reader :request

      def initialize(request)
        @request = request
      end

      def name
        self.class.name
      end

      def response
        raise NotImplementedError
      end
    end
  end
end
