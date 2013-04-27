require 'test_helper'

class SharersControllerTest < ActionController::TestCase
  setup do
    @sharer = sharers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sharers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sharer" do
    assert_difference('Sharer.count') do
      post :create, sharer: { credentials: @sharer.credentials, major: @sharer.major, user_id: @sharer.user_id }
    end

    assert_redirected_to sharer_path(assigns(:sharer))
  end

  test "should show sharer" do
    get :show, id: @sharer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sharer
    assert_response :success
  end

  test "should update sharer" do
    put :update, id: @sharer, sharer: { credentials: @sharer.credentials, major: @sharer.major, user_id: @sharer.user_id }
    assert_redirected_to sharer_path(assigns(:sharer))
  end

  test "should destroy sharer" do
    assert_difference('Sharer.count', -1) do
      delete :destroy, id: @sharer
    end

    assert_redirected_to sharers_path
  end
end
