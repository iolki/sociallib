class Title < ActiveRecord::Base
  belongs_to :subject
  has_and_belongs_to_many :authors
  has_many :books
  
  validates_length_of :title, :minimum => 1
  validates_associated :authors
#   validates_associated :subject
  validates_isbn :isbn13, :with => :isbn13
  
  def to_param
    isbn13
  end
  
  def isbn10
    # http://rubygems.org/gems/isbn
    ISBN.ten(isbn13)
  end
  
  def title_and_author
    "#{self.title} by #{self.authors.first.name}"
  end
  
  def self.find_or_create_by_isbn13(isbn13)
    
    isbn13.strip!
    
    # Is this a barcode scanned by an unmodified Cuecat reader?
    if isbn13.size == 50
      code = CueCat.new(isbn13[1..50])
      isbn13 = code.value.to_s
    end
    
    t2 = self.find_by_isbn13(isbn13)
    
    unless t2.nil?
      return t2
    end
    

    # Look up in Google Books API
    
    start_uri = 'http://books.google.com/books/feeds/volumes?q=' + isbn13
    doc = Nokogiri::XML(open(start_uri))
    
    t = Title.new
    
    unless doc.xpath('//dc:title')[0].nil?
      t.title = doc.xpath('//dc:title')[0].text
    end
        
    unless doc.xpath('//dc:title')[1].nil?
      t.subtitle = doc.xpath('//dc:title')[1].text
    end
    
    unless doc.xpath('//dc:description').nil?
      t.description = doc.xpath('//dc:description').text
    end

    unless doc.xpath('//atom:link[@rel="http://schemas.google.com/books/2008/thumbnail"]', 'atom' => 'http://www.w3.org/2005/Atom')[0]['href'].nil?
      t.image_url = doc.xpath('//atom:link[@rel="http://schemas.google.com/books/2008/thumbnail"]', 'atom' => 'http://www.w3.org/2005/Atom')[0]['href']
    end

    doc.xpath('//dc:creator').each do |author|
      if a = Author.find_by_name(author.text)
        t.authors << a
      else
        t.authors << Author.create(:name => author.text)
      end
    end
    

    subject = doc.xpath('//dc:subject').text

    unless subject.nil?
      if s = Subject.find_by_name(subject)
        t.subject = s
      else
        t.subject = Subject.create(:name => subject)
      end
    end

    t.isbn13 = isbn13
    
    t.save
    
    t
  end
end
