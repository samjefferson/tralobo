require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
  	@user = users(:test)
  	@log = logs(:thirty)
  	@comment = @log.comments.build(content: "Sick Log man!", user_id: @user.id)
  end

  test "valid comment" do
  	assert @comment.valid?
  end

  test "comment too long" do
  	@comment.content = 'a' * 251
  	assert_not @comment.valid?
  end

  test "blank comment should fail" do
  	@comment.content = " "
  	assert_not @comment.valid?
  end

end
