# frozen_string_literal: true

module Minecraft
  module Plugins
    module Finders
      class Version < Minecraft::Plugins::Finders::Base
        private

        def perform_search
          Network::APIClient::Spiget.instance.resource_versions(search_conditions.delete(:resource_id))
        end

        def data_class
          Minecraft::Plugins::Version
        end
      end
    end
  end
end
