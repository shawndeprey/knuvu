class UserMailer < ActionMailer::Base
  default from: "KnuVu Admin <admin@knuvu.com>"

  def password_reset(user)
    @user = user
    mail(:to => @user.email, :subject => "KnuVu Password Reset Instructions")
  end
end