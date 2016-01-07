require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  def setup
    @tag = tags(:orange_tags)
  end

  test "should get show" do
    get :show, id: @tag.name
    assert_response :success
  end

end
