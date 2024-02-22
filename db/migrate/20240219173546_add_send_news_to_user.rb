class AddSendNewsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :send_news, :string, default: "weekly"
  end
end
