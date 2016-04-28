module HTTPalooza
  module Players
    class W3MPlayer < Base
      introducing! :w3m

      def response
        output = nil

        if request.head?
          output = `w3m -dump_head '#{request.url}'`
        elsif request.get?
           output = `w3m -dump '#{request.url}'`
        elsif request.post?
          if request.params.empty?
            raise "This client cannot POST without parameters."
          end

          form_data = URI.encode_www_form(request.params.each_pair.to_a)
          output = `printf '#{form_data}' | w3m -dump -post - '#{request.url}'`
        else
          raise "Unsupported HTTP method for this client!"
        end

        if $? == 0
          code = 200 # probably, right?

          # Lynx prints headers when you issue -head
          if request.head?
            output = ''
          end

          Response.new(code, output)
        else
          code = case output
                 when /Not Found/
                   404
                 when /Internal Server Error/
                   500
                 else
                   400 # sure, why not
                 end

          Response.new(code, output)
        end
      end
    end
  end
end
