class AddUserToNewsPost < ActiveRecord::Migration[7.1]
  def change
    add_reference :news_posts, :user, null: false, foreign_key: true
  end
end
