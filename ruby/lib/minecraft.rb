# frozen_string_literal: true

require 'open_config'

require_relative 'core_ext/object'

require_relative 'network'
require_relative 'open_delegator'

require_relative 'minecraft/cli'
require_relative 'minecraft/version'
require_relative 'minecraft/plugins'
require_relative 'minecraft/backuper'

module Minecraft
  module_function

  def configuration
    @configuration ||= OpenConfig::YAML.new('configuration.yml').minecraft
  end

  def deploy_configuration
    @deploy_configuration ||= OpenConfig::YAML.new('../deploy.yml')
  end
end
