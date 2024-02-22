require "test_helper"

class NewsPostsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    user = User.create(email: 'test@test.com', password: 123456, admin: true, id: 2)
    sign_in(user)
  end
  test 'create post' do
    get('/news_posts/new')
    assert_response(:success)

    post('/news_posts', params: { news_post: { title: 'can', body: 'success' } })
    assert_response(:redirect)
    follow_redirect!
    assert_response(:success)
    assert_select('h2', 'can')
  end

  test 'update post' do
    get('/news_posts/1')
    assert_response(:success)

    patch('/news_posts/1', params: { news_post: { title: 'update', body: 'updated' } })
    assert_response(:redirect)
    follow_redirect!
    assert_response(:success)
    assert_select('h2', 'update')

    get('/news_posts/1/edit')
    assert_select('sub', 'Edits left: 4')
  end

end
