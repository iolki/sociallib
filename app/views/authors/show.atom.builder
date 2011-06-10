xml.instruct! :xml, :version => "1.0" 
xml.feed :xmlns => 'http://www.w3.org/2005/Atom' do
  xml.title "Sutton Bookshare: Books by #{@author.name}"
  xml.link :href => author_url((@author), :format => :atom), :rel => 'self'
  xml.link :href => author_url(@author), :rel => 'alternate'
  xml.updated @author.titles.reverse.first.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")
  xml.id author_url((@author), :format => :atom)

  for title in @author.titles.reverse
    xml.entry do
      xml.title title.title_and_author
      xml.content title.description, :type => 'html'
      xml.updated title.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")
      xml.link :href => title_url(title)
      xml.id title_url(title)
      xml.author do
        xml.name "Sutton Bookshare"
      end
    end
  end
end