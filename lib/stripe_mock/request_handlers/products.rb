module StripeMock
  module RequestHandlers
    module Products
      def Products.included(klass)
        klass.add_handler 'post /v1/products', :new_product
        klass.add_handler 'get /v1/products/(.*)', :get_product
      end

      def new_product(route, method_url, params, headers)
        product = Data.mock_product(params)
        products[ product[:id] ] = product
      end

      def get_product(route, method_url, params, headers)
        route =~ method_url
        assert_existence :product, $1, products[$1]
      end
    end
  end
end
