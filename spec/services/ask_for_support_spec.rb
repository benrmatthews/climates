require 'rails_helper'

describe AskForSupport do

  subject { described_class.new(User.new, Topic.new, {}) }
  let(:user) { User.new }

  describe '#commence!' do
    before do
      allow(subject).to receive(:supporter).and_return(user)
      allow(subject).to receive(:deliver_email).and_return(true)
      allow(subject).to receive(:send_notification).and_return(true)
    end

    it "saves new_support" do
      expect(subject.new_support).to receive(:save!)
      subject.commence!
    end

    it "sends email out" do
      allow(subject.new_support).to receive(:save!)
      expect(subject).to receive(:deliver_email)
      subject.commence!
    end

    it "sends notification" do
      allow(subject.new_support).to receive(:save!)
      expect(subject).to receive(:send_notification)
      subject.commence!
    end
  end
end
