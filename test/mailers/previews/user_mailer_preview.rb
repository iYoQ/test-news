# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_email
    user = User.first
    subject = 'Test mail'
    content = NewsPost.all
    UserMailer.send_email(user.email, subject, content)
  end
end
