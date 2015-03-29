module HTTPalooza
  module Players
    class Base
      class << self
        attr_reader :name, :dependencies

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
