class Loan < ActiveRecord::Base
  belongs_to  :book

  belongs_to  :lender,
              :class_name => "User",
              :foreign_key => :lender_id
              
  belongs_to  :borrower,
              :class_name => "User",
              :foreign_key => :borrower_id

  validates_presence_of :lender, :borrower, :book

  validate :borrower_cant_be_lender
  validate :lender_must_own_book
  
  after_create :set_book_status_to_on_loan
              
  def give_back
    if on_loan?
      update_attribute :returned, Time.now
      book.update_attribute :status, StaticData::BOOK_STATUS['AVAILABLE']
    else
      return false # Can't give back the same loan twice
    end
  end             
              
  def on_loan?
    returned.nil?
  end
  
  protected
  
  def set_book_status_to_on_loan
    book.update_attribute :status, StaticData::BOOK_STATUS['ONLOAN']
  end
  
  def borrower_cant_be_lender
    errors.add(:borrower, "you can't lend a book to yourself") if borrower == lender
  end
  
  def lender_must_own_book
    errors.add(:lender, "you must own the book you want to lend") unless book.user == lender
  end
  
end
