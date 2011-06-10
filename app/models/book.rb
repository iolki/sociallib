class Book < ActiveRecord::Base
  belongs_to :title
  belongs_to :user

  has_many :watchings, :dependent => :destroy
  has_many :watchers, :through => :watchings, :source => :user
  
  has_many :loans
  
  validates_associated :title

  def status_text
    statuses = [
      'available',
      'on loan',
      'deleted',
      'lost'
    ]
    
    statuses[status]
  end

  def available?
    status == StaticData::BOOK_STATUS['AVAILABLE']
  end

  def on_loan?
    status == StaticData::BOOK_STATUS['ONLOAN']
  end

  def deleted?
    status == StaticData::BOOK_STATUS['DELETED']
  end
  
  def lost?
    status == StaticData::BOOK_STATUS['LOST']
  end
  
end
