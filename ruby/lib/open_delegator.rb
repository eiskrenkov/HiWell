# frozen_string_literal: true

require 'delegate'

class OpenDelegator < SimpleDelegator
  alias data __getobj__

  def initialize(data)
    super(OpenStruct.new(data))
  end
end
