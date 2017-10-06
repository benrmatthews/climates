require 'rails_helper'

describe User do
  subject { described_class.new }
  let(:user) { User.create(email: 'user@example.com') }

  describe '#name' do
    context 'when first and last name are present' do
      it 'returns first and last name' do
        subject.first_name = 'first'
        subject.last_name = 'last'
        expect(subject.name).to eq('first last')
      end
    end

    context 'when first name is valid and last is not' do
      it 'returns first name' do
        subject.first_name = 'first'
        expect(subject.name).to eq 'first'
      end
    end

    context 'when last name is valid and first is not' do
      it 'returns last name' do
        subject.last_name = 'last'
        expect(subject.name).to eq 'last'
      end
    end

    context 'when first and last name are not valid' do
      it 'returns nothing' do
        expect(subject.name).to eq ''
      end
    end
  end

  describe '#to_s' do
    context 'when name is a string' do
      it 'returns name' do
        name = 'foo bar'
        expect(subject).to receive(:name).and_return(name)
        expect(subject.to_s).to eq name
      end
    end

    context 'when name is empty' do
      it 'returns empty string' do
        expect(subject).to receive(:name).and_return('')
        expect(subject.to_s).to eq('')
      end
    end
  end

  describe '#helps_with?' do
    let(:topic) { Topic.create(title: 'foo', description: 'bar') }

    it 'return true if user is familiar with the topic' do
      Skill.create(user_id: user.id, topic_id: topic.id)
      expect(user.helps_with?(topic)).to be true
    end

    it "return false if user isn't familiar with the topic" do
      expect(subject.helps_with?(topic)).to be false
    end
  end

  describe '#pending_supports_count' do
    context 'returns zero' do
      it 'when user has no supports' do
        expect(subject.pending_supports_count).to eq(0)
      end

      it 'when user has only done supports' do
        Support.create!(user_id: user.id,
                        receiver_id: user.id,
                        done: true)
        expect(user.pending_supports_count).to eq 0
      end
    end

    it 'returns a number of supports when user has some unfinished supports' do
      Support.create!(user_id: user.id,
                      receiver_id: user.id)
      expect(user.pending_supports_count).to eq 1
    end
  end

  describe '#has_pending_supports?' do
    it 'returns true when there are pending supports' do
      Support.create!(user_id: user.id,
                      receiver_id: user.id)
      expect(user.has_pending_supports?).to be true
    end

    it 'returns false there is are no pending supports' do
      expect(subject.has_pending_supports?).to be false
    end
  end
end
