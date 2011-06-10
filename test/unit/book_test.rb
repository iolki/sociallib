require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @book = books(:thebridge)
    @alice = users(:alice)
  end

  test "the bridge" do
    assert_equal StaticData::BOOK_STATUS['AVAILABLE'], @book.status
    assert_equal 'The Bridge', @book.title.title
    assert_equal @alice, @book.user
  end
end
