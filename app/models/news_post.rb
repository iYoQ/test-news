class NewsPost < ApplicationRecord
  before_update :update_edit_count

  validates :title, presence: true
  validates :body, presence: true

  private

  def update_edit_count
    self.edit_count_left -= 1
  end
end
