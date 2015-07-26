module FixedModel
  class BaseTest < ActiveSupport::TestCase
    test "truth" do
      assert_kind_of Class, Base
    end
  end
end
