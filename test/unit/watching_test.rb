require 'test_helper'

class WatchingTest < ActiveSupport::TestCase
  def setup
    @thebridge = books(:thebridge) # belongs to alice
    @outliers = books(:outliers) # belongs to bob
    @alice = users(:alice)
  end

  test "can't watch your own book" do
    @watching = Watching.new
    @watching.user = @alice
    @watching.book = @thebridge
    assert !@watching.save
  end

  test "can't watch a book twice" do
    @watching1 = Watching.new
    @watching1.user = @alice
    @watching1.book = @outliers
    assert @watching1.save

    @watching2 = Watching.new
    @watching2.user = @alice
    @watching2.book = @outliers
    assert !@watching2.save
  end
  
  test "must specify a book to watch" do
    @watching = Watching.new
    @watching.user = @alice
    @watching.book = nil
    assert !@watching.save
  end
  
  test "can only watch available or onloan books" do
    flunk
  end
  
end
