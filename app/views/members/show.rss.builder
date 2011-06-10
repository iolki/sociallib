xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Sutton Bookshare: #{@user.login}'s books"
    xml.description ""
    xml.link url_for :controller => :members, :action => :show, :login => @user.login, :only_path => false

    for title in @user.titles.reverse[1..15]
      xml.item do
        xml.title title.title_and_author
        xml.description title.description
        xml.pubDate title.created_at.to_s(:rfc822)
        xml.link title_url(title)
        xml.guid title_url(title)
      end
    end
  end
end