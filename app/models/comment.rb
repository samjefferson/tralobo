class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :log

  default_scope -> { order('created_at DESC')}
  validates :user_id, presence: true
  validates :log_id, presence: true

  validates :content, presence: true, length: { maximum: 250 }

  before_save { self.content = "<pre>#{self.content}</pre>".html_safe }

end

