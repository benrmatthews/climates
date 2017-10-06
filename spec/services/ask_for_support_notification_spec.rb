require 'rails_helper'

describe AskForSupportNotification do
  describe '#message' do
    let(:support) { Support.create }
    subject { described_class.new(support) }

    it 'has proper support url' do
      expect(subject.message).to match("/supports/#{support.id}")
    end
  end
end
