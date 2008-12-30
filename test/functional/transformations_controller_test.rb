require 'test_helper'

class TransformationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:transformations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_transformation
    assert_difference('Transformation.count') do
      post :create, :transformation => { }
    end

    assert_redirected_to transformation_path(assigns(:transformation))
  end

  def test_should_show_transformation
    get :show, :id => transformations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => transformations(:one).id
    assert_response :success
  end

  def test_should_update_transformation
    put :update, :id => transformations(:one).id, :transformation => { }
    assert_redirected_to transformation_path(assigns(:transformation))
  end

  def test_should_destroy_transformation
    assert_difference('Transformation.count', -1) do
      delete :destroy, :id => transformations(:one).id
    end

    assert_redirected_to transformations_path
  end
end
