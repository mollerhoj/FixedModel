module FixedModel
  autoload :Base, "fixed_model/base"
  autoload :Loader, "fixed_model/loader"

  class RecordNotFound < StandardError; end

  # class Railtie < Rails::Railtie
  #   config.fixed_model = ActiveSupport::OrderedHash.new

  #   config.file_paths = ['config/fixed_models']

  #   initializer "fixed_model.initialize" do |app|
  #     app.config.fixed_model
  #   end
  # end
end
