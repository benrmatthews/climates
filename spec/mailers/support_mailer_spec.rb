require 'rails_helper'

describe SupportMailer do
  describe '#new_comment' do
    let(:support) { Support.new id: 3, body: 'I really need help in something' }
    let(:commenter) { User.new first_name: 'roberto', last_name: 'amore' }
    let(:comment) { Comment.new user: commenter, body: "that's easy!" }
    let(:mail_receiver) { User.new email: 'foo@bar.io' }

    subject { SupportMailer.new_comment support, comment, mail_receiver }

    it 'contains comment text in the body' do
      expect(subject.body).to match /#{comment.body}/
    end

    it 'is delivered to user' do
      expect(subject.to).to include mail_receiver.email
    end

    it 'contains commenter name in the subject' do
      expect(subject.subject).to match /#{comment.user.name} added new comment/
    end
  end
end
