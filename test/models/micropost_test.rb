require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

  test "tags should be extracted from content and saved correctly" do
    cats_micropost = microposts(:cat_video)
    assert_difference "cats_micropost.tags.count", 1 do
      cats_micropost.save
      cats_micropost.reload
    end
    assert_equal "catsrock", cats_micropost.tags.first.name
  end

  test "tags should be unique even if they appear multiple times
                                              in the same micropost" do
    zone_micropost = microposts(:zone)
    assert_difference "zone_micropost.tags.count", 1 do
      zone_micropost.save
      zone_micropost.reload
    end
  end

  test "microposts with the same tag should be linked to it" do
    micropost = Micropost.create(content: "This is a #tag", user: users(:michael))
    other_micropost = Micropost.new(content: "I love this #TaG", user: users(:michael))
    yet_other_micropost = Micropost.new(content: "I would like to use a #tag", user: users(:michael))
    assert_no_difference "Tag.count" do
      other_micropost.save
      yet_other_micropost.save
    end
    assert_equal micropost.reload.tags.first, other_micropost.reload.tags.first
    assert_equal micropost.reload.tags.first, yet_other_micropost.reload.tags.first
  end
end
