# frozen_string_literal: true

module Minecraft
  module Plugins
    module Finders
      class Base
        attr_reader :search_conditions

        def initialize(search_conditions)
          @search_conditions = search_conditions
        end

        def call
          data = find_exact_match
          return unless data

          data_class.new(data)
        end

        private

        def find_exact_match
          perform_search.find do |search_result|
            values = search_result.values_at(*search_conditions.keys).map do |value|
              value.is_a?(String) ? value.downcase : value
            end

            values == search_conditions.values.map(&:to_s)
          end
        end

        def perform_search
          raise NotImplementedError
        end

        def data_class
          raise NotImplementedError
        end
      end
    end
  end
end
