require 'test_helper'

class TagTest < ActiveSupport::TestCase
  def setup
    @tag = Tag.new(name: "helloworld")
  end

  test "should be valid" do
    assert @tag.valid?
  end

  test "name should be unique" do
    duplicate_tag = @tag.dup
    duplicate_tag.name = @tag.name.upcase
    @tag.save
    assert_not duplicate_tag.valid?
  end

  test "name should not be too long" do
    @tag.name = "a" * 51
    assert_not @tag.valid?
  end

  test "name should be saved as lower-case" do
    mixed_case_tag = "HeLlOWorLd"
    @tag.name = mixed_case_tag
    @tag.save
    assert_equal mixed_case_tag.downcase, @tag.reload.name
  end
end
