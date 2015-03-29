module HTTPalooza
  module API
    def get(url, options = {}, &block)
      run! Request.new(url, :get, options.slice(:headers, :params, :payload), &block)
    end

    def post(url, options = {}, &block)
      run! Request.new(url, :post, options.slice(:headers, :params, :payload), &block)
    end

    def put(url, options = {}, &block)
      run! Request.new(url, :put, options.slice(:headers, :params, :payload), &block)
    end

    def delete(url, options = {}, &block)
      run! Request.new(url, :delete, options.slice(:headers, :params, :payload), &block)
    end

    def head(url, options = {}, &block)
      run! Request.new(url, :head, options.slice(:headers, :params, :payload), &block)
    end
  end
end
