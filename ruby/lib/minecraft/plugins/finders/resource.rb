# frozen_string_literal: true

module Minecraft
  module Plugins
    module Finders
      class Resource < Minecraft::Plugins::Finders::Base
        private

        def perform_search
          Network::APIClient::Spiget.instance.search(**search_conditions.slice(:name))
        end

        def data_class
          Minecraft::Plugins::Resource
        end
      end
    end
  end
end
