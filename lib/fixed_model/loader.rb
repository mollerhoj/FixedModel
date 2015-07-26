module FixedModel
  class Loader
    def initialize(model_name)
      @model_name = model_name
    end

    def load
      YAML.load(File.read(file_path))
    end

    def file_path
      plural_model_name = ActiveModel::Naming.plural(@model_name)
      File.join(Rails.root, 'config', 'fixed_models', "#{plural_model_name}.yml")
    end
  end
end

