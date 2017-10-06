require 'rails_helper'

describe SupportDecorator do
  let(:support) { Support.new }
  let(:subject) { described_class.decorate support }

  describe '#user' do
    it 'returns decorated user when user is present' do
      support.user = User.new
      expect(subject.user.class).to eq UserDecorator
    end

    it 'returns decorated unavailable user when user is not present' do
      expect(subject.user.class).to eq UserDecorator::Unavailable
    end
  end
end
