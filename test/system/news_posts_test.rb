require "application_system_test_case"

class NewsPostsTest < ApplicationSystemTestCase
  setup do
    @news_post = news_posts(:one)
  end

  test "visiting the index" do
    visit news_posts_url
    assert_selector "h1", text: "News posts"
  end

  test "should create news post" do
    visit news_posts_url
    click_on "New news post"

    click_on "Create News post"

    assert_text "News post was successfully created"
    click_on "Back"
  end

  test "should update News post" do
    visit news_post_url(@news_post)
    click_on "Edit this news post", match: :first

    click_on "Update News post"

    assert_text "News post was successfully updated"
    click_on "Back"
  end

  test "should destroy News post" do
    visit news_post_url(@news_post)
    click_on "Destroy this news post", match: :first

    assert_text "News post was successfully destroyed"
  end
end
