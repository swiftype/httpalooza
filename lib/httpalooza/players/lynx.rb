module HTTPalooza
  module Players
    class LynxPlayer < Base
      introducing! :lynx

      def response
        output = nil

        if request.head?
          output = `lynx -head -dump '#{request.url}'`
        elsif request.get?
           output = `lynx -dump '#{request.url}'`
        elsif request.post?
          if request.params.empty?
            raise "This client cannot POST without parameters."
          end

          form_data = URI.encode_www_form(request.params.each_pair.to_a)
          output = `echo '#{form_data}' | lynx -dump -post_data '#{request.url}'`
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
