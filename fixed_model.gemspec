$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fixed_model/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fixed_model"
  s.version     = FixedModel::VERSION
  s.authors     = ["mollerhoj"]
  s.email       = ["mollerhoj3@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of FixedModel."
  s.description = "TODO: Description of FixedModel."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"
end
