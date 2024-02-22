require "test_helper"

class UserMailerTest < ActionMailer::TestCase

  setup do
    @users_number = (1..5)
  end

  test 'sending_daily_digest' do
    @users_number.map{ |i| User.create(email: "#{i}@mail.com",
                                password: '123456',
                                send_news: User::SEND_NEWS_VALUES[:daily]) }

    users_count = User.where(send_news: User::SEND_NEWS_VALUES[:daily]).count

    User.daily_sending

    assert_equal(users_count, ActionMailer::Base.deliveries.length)
  end

  test 'sending_weekly_digest' do
    @users_number.map{ |i| User.create(email: "#{i}@mail.com",
                                password: '123456',
                                send_news: User::SEND_NEWS_VALUES[:weekly]) }

    users_count = User.where(send_news: User::SEND_NEWS_VALUES[:weekly]).count

    User.weekly_sending

    assert_equal(users_count, ActionMailer::Base.deliveries.length)
  end
end
