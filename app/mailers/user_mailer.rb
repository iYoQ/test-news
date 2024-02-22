class UserMailer < ApplicationMailer
  default from: 'admin@admin.com'

  def send_email(user, subject, content)
    @content = content

    mail(
      to: user,
      subject: subject,
    )
  end
end
