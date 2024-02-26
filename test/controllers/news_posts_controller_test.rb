require "test_helper"

class NewsPostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    user = User.create(email: 'test@test.com', password: 123456, admin: true, id: 2)
    sign_in(user)
    @news_post = news_posts(:test_post)
  end


  test "update news_post" do
    patch(news_post_url(@news_post), params: { news_post: { title: 'updated' } })
    @news_post.reload

    assert_equal('updated', @news_post.title)
    assert_equal('Обновленно', flash[:notice])
    assert_redirected_to(news_post_url(@news_post))
  end
end
