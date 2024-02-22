require "test_helper"

class NewsPostTest < ActiveSupport::TestCase
  test 'update_edits_count' do
    NewsPost.new(title: 'test', body: 'test', user_id: 1).save

    post1 = NewsPost.last
    post2 = NewsPost.last

    post1.update(title: 'new1')

    post2.with_lock do
      post2.update(title: 'new2')
    end

    assert_equal(3, NewsPost.last.edit_count_left)
  end
end
