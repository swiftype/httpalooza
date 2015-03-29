module HTTPalooza
  module Players
    class UserBrowserPlayer < Base
      introducing! :user_browser

      def response
        STDOUT.puts "Please open your web browser and go to the following URL: #{request.url}"

        prompt = "Do you think the page loaded properly? (y/n/maybe): "
        STDOUT.print(prompt)
        while answer = STDIN.gets.chomp
          case answer
          when /y/i
            code = 200
            break
          when /n/i
            code = 404
            break
          else
            STDOUT.print(prompt)
          end
        end

        STDOUT.puts "View the source of the page, then copy and paste the whole source here (^D when finished)."
        body = STDIN.read
        STDOUT.puts "\n\n"

        Response.new(code, body)
      end
    end
  end
end
