module FixedModel
  autoload :Base, "fixed_model/base"
  autoload :Loader, "fixed_model/loader"

  cattr_accessor :file_paths
  cattr_accessor :use_environment_paths

  @@file_paths = ['config/fixed_models']
  @@use_environment_paths = true

  class RecordNotFound < StandardError; end
end
