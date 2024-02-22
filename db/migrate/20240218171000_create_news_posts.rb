class CreateNewsPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :news_posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
