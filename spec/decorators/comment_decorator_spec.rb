require 'spec_helper'

describe CommentDecorator do
  let(:comment) { double(:comment) }
  let(:decorated_comment) { CommentDecorator.decorate comment }
  let(:user) { double(:user, gravatar: true) }

  describe '#user_gravatar' do
    it 'calls "gravatar" method on user' do
      allow(decorated_comment).to receive(:user).and_return(user)
      expect(user).to receive(:gravatar).with(100)
      decorated_comment.user_gravatar(100)
    end
  end
end
