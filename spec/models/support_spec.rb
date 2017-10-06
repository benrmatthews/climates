require 'rails_helper'

describe Support do
  subject { described_class.new }

  describe '#discussed?' do
    it 'returns true when there are some comments' do
      expect(subject).to receive(:comments_count).and_return(10)
      expect(subject.discussed?).to be true
    end

    it 'returns false when there are no comments' do
      expect(subject).to receive(:comments_count).and_return(0)
      expect(subject.discussed?).to be false
    end
  end

  describe '#comments_count' do
    let!(:support) { Support.create! }
    let!(:comment) { Comment.create!(support_id: support.id) }

    it 'returns the number of commits' do
      expect(support.reload.comments_count).to eq(1)
      expect(subject.comments_count).to eq(0)
    end
  end
end
