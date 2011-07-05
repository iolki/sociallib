class MemberMessage < ActionMailer::Base
  
  def member_message(sender, recipient, message)
    @message = message
    @sender = sender
    
    mail(
      :to => recipient.email,
      :from => sender.email,
      :subject => "Message from Social Library member #{@sender.login}"
    ) do |format|
      format.html
#       format.text
    end
  end
  
  def book_request(sender, recipient, book, message)
    @message = message
    @sender = sender
    @book = book
    
    mail(
      :to => recipient.email,
      :from => sender.email,
      :subject => "Book request for \"#{@book.title.title}\" from Social Library member #{@sender.login}"
    ) do |format|
      format.html
#       format.text
    end
  end
  
  def registration_confirmation(recipient)
    @recipient = recipient
    mail(
      :to => recipient.email,
      :from => "noreply@the-social-library.org",
      :subject => "Welcome to Social Library"
    ) do |format|
      format.html
#       format.text
    end
  end
  
  def password_reset_instructions(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)

    mail(
      :to => user.email,
      :from => "noreply@the-social-library.org",
      :subject => "Social Library password reset instructions"
    ) do |format|
      format.html
      format.text
    end
  end
end
