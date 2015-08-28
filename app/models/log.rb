class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  default_scope -> { order('created_at DESC')}

  validates :user_id, presence: true
  validates :location_id, presence: true

  validates :title, presence: true, length: { maximum: 25}
  validates :content, presence: true, length: { maximum: 1000 }

end
