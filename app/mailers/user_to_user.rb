class UserToUser < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  default from: "don't_even_think_of_replying@ea-skillshare.herokuapp.com"
 
  def contact(message)
    @body = message.body
    @sender = User.find(message.sender_id)
    @recipient = User.find(message.recipient_id)
    @greeting = "Hi, #{@recipient.name}!"

    mail to: @recipient.email, subject: "Message from #{@recipient.name}"
  end
end
