module FixedModel
  class Base
    include ActiveModel::Model
    include ActiveModel::AttributeMethods

    attribute_method_suffix '?'

    # Needs testing
    class << self
      delegate :find, :take, :take!, :first, :first!, :last, :last!, :exists?, :any?, :many?, to: :all
      delegate :second, :second!, :third, :third!, :fourth, :fourth!, :fifth, :fifth!, :forty_two, :forty_two!, to: :all

      delegate :select, :group, :order, :except, :reorder, :limit, :offset, :joins, :or,
               :where, :rewhere, :preload, :eager_load, :includes, :from, :lock, :readonly,
               :having, :distinct, :references, :none, :unscope, to: :all
      delegate :count, :average, :minimum, :maximum, :sum, :calculate, to: :all
      delegate :pluck, :ids, to: :all
    end

    def initialize(row={})
      @row = row
      define_attribute_readers
    end

    def persisted?
      true
    end

    def new_record?
      false
    end

    def attributes
      @row.dup.freeze
    end

    def self.inherited(subclass)
      subclass.define_find_by_attributes
      subclass.define_find_by_attributes!
      define_attribute_methods(subclass.attribute_names)
    end

    def attribute?(attr)
      send(attr.to_sym).present?
    end

    def self.attribute_names
      names = []
      data.each do |row|
        names.concat(row.keys)
      end
      names.uniq.map(&:to_s)
    end

    def self.all
      data.map { |row| new(row) }
    end

    def self.each(&block)
      all.each(&block)
    end

    def attribute_names
      @row.keys.map(&:to_s)
    end

    def read_attribute(attribute)
      @row[attribute]
    end

    def ==(other)
      other.instance_of?(self.class) && other.attributes == attributes
    end

    private

    # Seems to be called when denmark.language is not defined and called.
    # Look in rails source for explanation...
    def attribute(attribute)
      nil
    end

    def define_attribute_readers
      attribute_names.each do |attribute_name|
        define_singleton_method attribute_name do
          read_attribute(attribute_name)
        end
      end
    end

    def self.singleton_class
      class << self
        self
      end
    end

    def self.define_find_by_attribute(attribute)
      singleton_class.send :define_method, "find_by_#{attribute}" do |arg|
        row = data.find { |i| i[attribute] == arg } # or sym?
        row ? self.new(row) : nil
      end
    end

    def self.define_find_by_attribute!(attribute)
      singleton_class.send :define_method, "find_by_#{attribute}!" do |arg|
        row = data.find { |i| i[attribute] == arg } # or sym?
        if row
          self.new(row)
        else
          raise FixedModel::RecordNotFound
        end
      end
    end

    def self.define_find_by_attributes
      attribute_names.each do |attribute|
        define_find_by_attribute(attribute)
      end
    end

    def self.define_find_by_attributes!
      attribute_names.each do |attribute|
        define_find_by_attribute!(attribute)
      end
    end

    def self.data
      @data ||= FixedModel::Loader.new(self).load
    end
  end
end
