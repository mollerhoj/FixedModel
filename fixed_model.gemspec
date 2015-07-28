$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fixed_model/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fixed_model"
  s.version     = FixedModel::VERSION
  s.authors     = ["Jens Dahl Møllerhøj"]
  s.email       = ["mollerhoj3@gmail.com"]
  s.homepage    = "https://github.com/mollerhoj/"
  s.summary     = "Fixed Models act like ActiveRecord models, but they are immutable and read from data files."
  s.description = "Fixed Models act like ActiveRecord models, but they are immutable and read from data files."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
end
