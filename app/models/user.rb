class User < ApplicationRecord
  has_many :news_posts

  SEND_NEWS_VALUES = {weekly: 'weekly', daily: 'daily', none: 'none'}.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :rememberable, :validatable

  before_validation :check_send_news

  def self.weekly_sending
    users = User.where(send_news: SEND_NEWS_VALUES[:weekly])
    content = NewsPost.where('created_at >= ?', 7.day.ago)
    subject = 'Weekly digest'
    self.sending(users, subject, content)
  end

  def self.daily_sending
    users = User.where(send_news: SEND_NEWS_VALUES[:daily])
    content = NewsPost.where('created_at >= ?', 1.day.ago)
    subject = 'Daily digest'
    self.sending(users, subject, content)
  end


  private

  def check_send_news
    if !SEND_NEWS_VALUES.has_value?(self.send_news)
      Rails.logger.warn('User#' + self.email + ' send wrong params: send_news: ' + self.send_news)

      self.send_news = SEND_NEWS_VALUES[:weekly]
    end
  end

  def self.sending(users, subject, content)
    users.each do |user|
      UserMailer.send_email(user.email, subject, content).deliver_now
    end
  end
end
