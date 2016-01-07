require 'test_helper'

class TagsShowTest < ActionDispatch::IntegrationTest
  def setup
    @tag = tags(:orange_tags)
  end

  test "no microposts should be found if the tag does not exist" do
    get tag_path("helloWorld")
    assert_template 'tags/show'
    assert_select 'title', full_title("#helloworld")
  end

  test "all microposts should contain the searched tag" do
    get tag_path(@tag.name.upcase)
    assert_template 'tags/show'
    assert_select 'title', full_title("##{@tag.name}")
    assert_not assigns(:tag).microposts.empty?
    assigns(:tag).microposts.each do |micropost|
      assert_match /##{@tag.name}/i, micropost.content
    end
  end
end
