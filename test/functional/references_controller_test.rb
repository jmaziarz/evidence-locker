require 'test_helper'

class ReferencesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:references)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_reference
    assert_difference('Reference.count') do
      post :create, :reference => { }
    end

    assert_redirected_to reference_path(assigns(:reference))
  end

  def test_should_show_reference
    get :show, :id => references(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => references(:one).id
    assert_response :success
  end

  def test_should_update_reference
    put :update, :id => references(:one).id, :reference => { }
    assert_redirected_to reference_path(assigns(:reference))
  end

  def test_should_destroy_reference
    assert_difference('Reference.count', -1) do
      delete :destroy, :id => references(:one).id
    end

    assert_redirected_to references_path
  end
end
