require 'test_helper'

class CourseMappingsControllerTest < ActionController::TestCase
  setup do
    @course_mapping = course_mappings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_mappings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_mapping" do
    assert_difference('CourseMapping.count') do
      post :create, course_mapping: { course_id: @course_mapping.course_id, decision: @course_mapping.decision, grade: @course_mapping.grade, user_id: @course_mapping.user_id }
    end

    assert_redirected_to course_mapping_path(assigns(:course_mapping))
  end

  test "should show course_mapping" do
    get :show, id: @course_mapping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_mapping
    assert_response :success
  end

  test "should update course_mapping" do
    patch :update, id: @course_mapping, course_mapping: { course_id: @course_mapping.course_id, decision: @course_mapping.decision, grade: @course_mapping.grade, user_id: @course_mapping.user_id }
    assert_redirected_to course_mapping_path(assigns(:course_mapping))
  end

  test "should destroy course_mapping" do
    assert_difference('CourseMapping.count', -1) do
      delete :destroy, id: @course_mapping
    end

    assert_redirected_to course_mappings_path
  end
end
