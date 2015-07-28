require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "active_model/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)
require "fixed_model"

module Dummy
  class Application < Rails::Application; end
end

