# frozen_string_literal: true

module Network
  module APIClient
    class Spiget < Network::APIClient::Base
      VERSIONS_LIST_SIZE = 20
      VERSIONS_SORT_DIRECTION = '-id'

      def search(name:)
        handle_errrors([]) do
          get("search/resources/#{name}", field: :name)
        end
      end

      def resource_versions(resource_id)
        handle_errrors([]) do
          get("resources/#{resource_id}/versions", size: VERSIONS_SORT_DIRECTION,
                                                   sort: VERSIONS_SORT_DIRECTION,
                                                   fields: 'name,uuid')
        end
      end

      def download_resource(resource_id, version_id)
        get("resources/#{resource_id}/versions/#{version_id}/download")
      end

      private

      def host
        Configuration.minecraft.spigot.spiget.api_host
      end

      def setup_connection(connection)
        connection.response :follow_redirects
      end
    end
  end
end
