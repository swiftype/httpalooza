module HTTPalooza
  module Players
    class << self
      attr_reader :available

      # @!attribute [r] available
      #   @return [Set] the available Players

      def add(klass)
        @available ||= Set.new

        begin
          klass.dependencies.each do |depedency|
            require depedency
          end
          available.add(klass)
        rescue LoadError
        end
      end
    end
  end
end
