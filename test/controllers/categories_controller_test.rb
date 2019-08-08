require "test_helper"

#class CategoriesControllerTest <ActionController::TestCase
class CategoriesControllerTest <ActionDispatch::IntegrationTest #Use this for rails 5?

  def setup
    @category = Category.create(name: "sports") #use .create so it hits db
    #create admin user to be able to test if admin
    @user = User.create(username: "joe", email: "joe@e.com", password: "password", admin: true)
  end

  test "should get categories index" do
    #get :index
    sign_in_as(@user.email, "password")
    get categories_path
    assert_response :success #ensure response to path is success
  end

  test "should get new" do
    sign_in_as(@user.email, "password")
    get new_category_path #get :new
    assert_response :success
  end

  test "should get show" do
    get category_path(@category) #get :show
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params:{category:{name: "sports"}}
    end
    assert_redirected_to categories_path
  end

end
