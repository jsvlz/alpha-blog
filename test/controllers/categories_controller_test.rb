require "test_helper"

#class CategoriesControllerTest <ActionController::TestCase
class CategoriesControllerTest <ActionDispatch::IntegrationTest #Use this for rails 5?

  def setup
    @category = Category.create(name: "sports") #use .create so it hits db
  end
  test "should get categories index" do
    #get :index
    get categories_path
    assert_response :success #ensure response to path is success
  end

  test "should get new" do
    get new_category_path #get :new
    assert_response :success
  end

  test "should get show" do
    get category_path(@category) #get :show
    assert_response :success
  end

end
