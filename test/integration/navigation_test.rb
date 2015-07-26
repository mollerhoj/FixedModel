class CountriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countries)
  end

  test "should get show" do
    # denmark = Country.find_by_name('Denmark') # get :show, id: denmark.id
    # raise denmark.inspect
    # assert_response :success
    # assert_not_nil assigns(:country)
  end
end
