module Lita
  module Handlers
    class OnewheelFredsSoundOfMusic < Handler
      route(/^freds\s+(.*)/i, :freds_search, command: true, help: 'freds whatevs')

      def freds_search(response)
        response.reply 'wat'
      end

      Lita.register_handler(self)
    end
  end
end
