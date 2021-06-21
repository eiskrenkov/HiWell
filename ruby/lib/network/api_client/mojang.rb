# frozen_string_literal: true

module Network
  module APIClient
    class Mojang < Network::APIClient::Base
      def version_manifest
        handle_errrors({}) do
          get(Configuration.minecraft.vanilla.version_manifest_url)
        end
      end
    end
  end
end
