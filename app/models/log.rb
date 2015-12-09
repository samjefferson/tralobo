class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :comments, dependent: :destroy


  default_scope -> { order('created_at DESC')}

  before_save { self.content = "<pre>#{self.content}</pre>".html_safe }


  validates :user_id, presence: true
  validates :location_id, presence: true

  validates :title, presence: true, length: { maximum: 25}
  validates :content, presence: true, length: { maximum: 2000 }

  acts_as_votable

  def score
  	self.get_upvotes.size - self.get_downvotes.size
  end

  

end
