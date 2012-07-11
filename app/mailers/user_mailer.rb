class UserMailer < ActionMailer::Base
  default from: "snapa.lifetime@gmail.com"

  def invite(email)
    @email = email
    mail(:to => email, :subject => "Invite")
  end

  def reset(recipient)
    @edit_password_reset_url = edit_password_reset_url(recipient.persistence_token)
    mail(:to => recipient.email, :subject => "Password Reset Instructions")
  end

  def verify(recipient)
    @user_verification_url = verification_url(recipient.persistence_token)
    mail(:to => recipient.email, :subject => "verification Instructions")
  end
end
