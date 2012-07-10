class UserMailer < ActionMailer::Base
  default from: "snapa.lifetime@gmail.com"

  def invite(email)
    @email = email
    mail(:to => email, :subject => "Invite")
    
  end
end
