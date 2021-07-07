# frozen_string_literal: true

module Network
  module APIClient
    class Spigot < Network::APIClient::Base
      def build_tools
        handle_errrors({}) do
          get(Minecraft.configuration.spigot.build_tools_url)
        end
      end
    end
  end
end
