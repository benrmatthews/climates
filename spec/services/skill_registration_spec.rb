require 'rails_helper'

describe SkillRegistration do

  let(:user){ User.new }
  let(:topic){ Topic.new }

  subject{ described_class.new user, topic }

  describe "#commence!" do

    it "creates skill if user was not helping before" do
      expect(user).to receive(:helps_with?).and_return(false)
      expect(subject).to receive(:create_skill)
      subject.commence!
    end

    it "destroys skill if user was helping before" do
      expect(user).to receive(:helps_with?).and_return(true)
      expect(subject).to receive(:destroy_skill)
      subject.commence!
    end

  end

end
