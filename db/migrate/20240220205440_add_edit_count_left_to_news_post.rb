class AddEditCountLeftToNewsPost < ActiveRecord::Migration[7.1]
  def change
    add_column :news_posts, :edit_count_left, :integer, default: 5
  end
end
