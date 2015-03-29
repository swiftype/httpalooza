module HTTPalooza
  module Players
    class PatronPlayer < Base
      introducing! :patron, %w[ patron ]

      def response
        session = Patron::Session.new
        session.base_url = request.url
        response = session.get('')
        Response.new(response.status, response.body)
      end
    end
  end
end
