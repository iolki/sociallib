xml.instruct! :xml, :version => "1.0" 
xml.feed :xmlns => 'http://www.w3.org/2005/Atom' do
  xml.title "Sutton Bookshare: #{@user.login}'s books"
  xml.link :href => url_for( :controller => :members, :action => :show, :login => @user.login, :format => :atom, :only_path => false), :rel => 'self'
  xml.link :href => url_for( :controller => :members, :action => :show, :login => @user.login, :only_path => false), :rel => 'alternate'
  xml.updated @user.titles.reverse.first.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")
  xml.id url_for( :controller => :members, :action => :show, :login => @user.login, :format => :atom, :only_path => false)

  for title in @user.titles.reverse[1..15]
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