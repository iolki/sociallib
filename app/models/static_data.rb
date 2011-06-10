class StaticData
  # http://stackoverflow.com/questions/361247/constant-values-in-rails
  # Just an ENUM-substitute for Book.status
  
  BOOK_STATUS = {
    'AVAILABLE' =>  0,
    'ONLOAN' =>     1,
    'DELETED' =>    2,
    'LOST' =>       3
  }
end