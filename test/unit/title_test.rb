require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  def setup
    @title = titles(:thebridge)
  end

  test "the bridge" do
    assert_equal "The Bridge", @title.title
    assert_equal "History", @title.subject.name
  end
end
