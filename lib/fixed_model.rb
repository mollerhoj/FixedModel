module FixedModel
  autoload :Base, "fixed_model/base"
  autoload :Loader, "fixed_model/loader"

  cattr_accessor :file_paths
  cattr_accessor :use_environment_paths

  @@file_paths = ['config/fixed_models']
  @@use_environment_paths = true

  class RecordNotFound < StandardError; end

  # class Railtie < Rails::Railtie
  #   config.fixed_model = ActiveSupport::OrderedHash.new

  #   config.file_paths = ['config/fixed_models']

  #   initializer "fixed_model.initialize" do |app|
  #     app.config.fixed_model
  #   end
  # end
end
