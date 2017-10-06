require 'rails_helper'

describe Notifier do
  describe '#commence!' do
    let(:support) { Support.create }
    let(:notification) { AskForSupportNotification.new(support) }
    subject { described_class.new(notification) }

    it "calls notify_slack method if it's in enabled_notifications" do
      allow(subject).to receive(:enabled_notifications).and_return(['slack'])
      expect(subject).to receive(:notify_slack)
      subject.commence!
    end
  end
end
