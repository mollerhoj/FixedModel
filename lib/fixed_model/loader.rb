module FixedModel
  class Loader
    def initialize(model_name)
      @model_name = model_name
    end

    def load
      data = {}
      files.each do |file|
        merge_data(data, YAML.load(File.read(file)))
      end
      data.values
    end

    def merge_data(row, new_row)
      new_row.each do |key, value|
        if row[key].is_a?(Hash) && value.is_a?(Hash)
          merge_data(row[key], value)
        elsif row[key].is_a?(Array) && value.is_a?(Array)
          row[key].concat(value)
        else
          row[key] = value
        end
      end
    end

    def files
      plural_model_name = ActiveModel::Naming.plural(@model_name)
      files = []
      FixedModel.file_paths.each do |file_path|
        files << File.join(Rails.root, file_path, "#{plural_model_name}.yml")
        if FixedModel.use_environment_paths
          file = File.join(Rails.root, file_path, 'test',"#{plural_model_name}.yml")
          files << file if File.exists?(file)
        end
      end
      files
    end
  end
end

