# frozen_string_literal: true

require 'yaml'
require 'json'
require 'erb'

module Configuration
  class << self
    def method_missing(method_name, *arguments, &block)
      if configuration_method?(method_name)
        define_singleton_method(method_name) do |*args, &blk|
          tree.public_send(method_name, *args, &blk)
        end

        tree.public_send(method_name, *arguments, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      configuration_method?(method_name) || super
    end

    private

    def configuration_method?(method_name)
      tree.respond_to?(method_name)
    end

    def tree
      @tree ||= JSON.parse(json_configuration, object_class: OpenStruct)
    end

    def json_configuration
      YAML.safe_load(ERB.new(read_config_file).result).to_json
    end

    def read_config_file
      File.new(config_file_path).read
    end

    def config_file_path
      File.expand_path(File.join(__dir__, '../configuration.yml'))
    end
  end
end
