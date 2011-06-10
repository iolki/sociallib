require 'test_helper'

class LoanTest < ActiveSupport::TestCase

  def setup
    @alice = users(:alice)
    @bob = users(:bob)
    @thebridge = books(:thebridge)
  end

  test "Bob borrows The Bridge from Alice and then gives it back" do
    assert_equal StaticData::BOOK_STATUS['AVAILABLE'], @thebridge.status

    assert_equal 0, @alice.loans.count
    assert_equal 0, @alice.active_loans.count
    assert_equal 0, @alice.borrowings.count
    assert_equal 0, @alice.active_borrowings.count

    assert_equal 0, @bob.loans.count
    assert_equal 0, @bob.active_loans.count
    assert_equal 0, @bob.borrowings.count
    assert_equal 0, @bob.active_borrowings.count
    
    @loan = Loan.new
    @loan.lender = @alice
    @loan.borrower = @bob
    @loan.book = @thebridge
    assert @loan.save
    
    assert @loan.on_loan?
    assert_equal StaticData::BOOK_STATUS['ONLOAN'], @thebridge.status

    assert_equal @loan, @alice.loans.last
    assert_equal @loan, @alice.active_loans.last
    assert_equal 1, @alice.loans.count
    assert_equal 1, @alice.active_loans.count
    assert_equal 0, @alice.borrowings.count
    assert_equal 0, @alice.active_borrowings.count

    assert_equal @loan, @bob.borrowings.last
    assert_equal @loan, @bob.active_borrowings.last
    assert_equal 0, @bob.loans.count
    assert_equal 0, @bob.active_loans.count
    assert_equal 1, @bob.borrowings.count
    assert_equal 1, @bob.active_borrowings.count
    
    assert @loan.give_back
    assert !@loan.on_loan?
    assert_equal StaticData::BOOK_STATUS['AVAILABLE'], @thebridge.status

    assert_equal 1, @alice.loans.count
    assert_equal 0, @alice.active_loans.count
    assert_equal 0, @alice.borrowings.count
    assert_equal 0, @alice.active_borrowings.count

    assert_equal 0, @bob.loans.count
    assert_equal 0, @bob.active_loans.count
    assert_equal 1, @bob.borrowings.count
    assert_equal 0, @bob.active_borrowings.count
  end
  
  test "Alice lends The Bridge to herself" do
    @loan = Loan.new
    @loan.lender = @alice
    @loan.borrower = @alice
    @loan.book = @thebridge
    assert !@loan.save
  end
  
  test "Alice tries to lend The Bridge to Bob twice without it being given back first" do
    @loan1 = Loan.new
    @loan1.lender = @alice
    @loan1.borrower = @bob
    @loan1.book = @thebridge
    assert @loan1.save
  
    @loan2 = Loan.new
    @loan2.lender = @alice
    @loan2.borrower = @bob
    @loan2.book = @thebridge
    assert !@loan2.save
  end
  
  test "Alice lends The Bridge to Bob; Bob tries to return it twice" do
    assert_equal StaticData::BOOK_STATUS['AVAILABLE'], @thebridge.status

    @loan = Loan.new
    @loan.lender = @alice
    @loan.borrower = @bob
    @loan.book = @thebridge
    assert @loan.save
    
    assert @loan.on_loan?
    assert_equal StaticData::BOOK_STATUS['ONLOAN'], @thebridge.status

    
    assert @loan.give_back
    assert !@loan.on_loan?
    assert_equal StaticData::BOOK_STATUS['AVAILABLE'], @thebridge.status

    assert !@loan.give_back
    assert !@loan.on_loan?
    assert_equal StaticData::BOOK_STATUS['AVAILABLE'], @thebridge.status
  end
  
  test "Bob tries to lend The Bridge to Alice but he doesn't own that book" do
    @loan = Loan.new
    @loan.lender = @bob
    @loan.borrower = @alice
    @loan.book = @thebridge
    assert !@loan.save
  end
  
  test "Alice tries to lend The Bridge to no-one" do
    @loan = Loan.new
    @loan.lender = @alice
    @loan.borrower = nil
    @loan.book = @thebridge
    assert !@loan.save
  end
  
  test "Alice tries to lend (no book) to Bob" do
    @loan = Loan.new
    @loan.lender = @alice
    @loan.borrower = @bob
    @loan.book = nil
    assert !@loan.save
  end
  
end
