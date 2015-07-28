require 'test_helper'

class FixedModelTest < ActiveSupport::TestCase
  setup do
    @denmark = Country.find_by_name('Denmark')
    @england = Country.find_by_name('England')
  end

  test "#self.find" do
    assert_equal @denmark, Country.find { |c| c.name == "Denmark" }
  end

  test "#self.first, second, thrid" do
    assert_equal @england, Country.first 
    assert_equal @denmark, Country.second
    assert_equal nil, Country.third
  end

  test "#self.last" do
    assert_equal @denmark, Country.last
  end

  test "has default file_path set" do
    assert_equal ['config/fixed_models'], FixedModel.file_paths
  end

  test "default to use environment paths" do
    assert_equal true, FixedModel.use_environment_paths
  end

  test "con configure the use of environment paths" do
    begin
      FixedModel.use_environment_paths = false
      Country.instance_variable_set(:@data, nil) # forces reload
      assert_equal 1, Country.count
    ensure
      FixedModel.use_environment_paths = true
      Country.instance_variable_set(:@data, nil) # forces reload
    end
  end

  test "can configure file paths" do
    begin
      FixedModel.file_paths = ['config/custom_directory']
      Country.instance_variable_set(:@data, nil) # forces reload
      assert_equal "Spain", Country.first.name
    ensure
      FixedModel.file_paths = ['config/fixed_models']
      Country.instance_variable_set(:@data, nil) # forces reload
    end
  end

  test "can hold arrays" do
    assert_equal @england.center, [53.562925, 1.806361]
  end

  test "can hold nested attributes" do
    expected = {"name"=>"London", "status"=>:capital}
    assert_equal expected, @england.cities[:london]
  end

  test "can hold symbols" do
    assert_equal :capital, @england.cities[:london]['status']
  end

  test "fixed models has always persisted" do
    assert_equal true, @denmark.persisted?
  end

  test "fixed models are never new" do
    assert_equal false, @denmark.new_record?
  end

  test "#self.find_by_<attribute>" do
    assert_equal @denmark, Country.find_by_capital('Copenhagen')
  end

  test "#self.find_by_<attribute>!" do
    assert_raise FixedModel::RecordNotFound do
      Country.find_by_capital!('Honolulu')
    end
    assert_equal @denmark, Country.find_by_capital!('Copenhagen')
  end

  test "#<attribute>?" do
    assert_equal true, @denmark.name?
    assert_equal false, @denmark.language?
  end

  test "#attributes" do
    expected = {"name" => "Denmark", "capital" => "Copenhagen"}
    assert_equal expected, @denmark.attributes
  end

  test "#self.all" do
    assert_equal [@england, @denmark], Country.all
  end

  test "#self.count" do
    assert_equal 2, Country.count
  end

  test "#self.each" do
    names = []
    Country.each do |country|
      names << country.name
    end
    assert_equal ["Denmark", "England"].sort, names.sort
  end

  test "#attribute_names" do
    assert_equal ["name", "capital"].sort, @denmark.attribute_names.sort
  end

  test "#self.attribute_names" do
    assert_equal ["name", "center", "cities", "capital", "language"].sort, Country.attribute_names.sort
  end

  test "#read_attribute" do
    assert_equal "Denmark", @denmark.read_attribute("name")
    assert_equal nil, @denmark.read_attribute("user")
  end

  test "attribute readers" do
    assert_equal "Denmark", @denmark.name
  end
end
