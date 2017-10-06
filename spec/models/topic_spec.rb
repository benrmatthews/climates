require 'rails_helper'

describe Topic do
  subject { described_class.new }

  describe '#to_s' do
    context 'when title is present' do
      it 'returns title' do
        title = 'foo'
        subject.title = title
        expect(subject.to_s).to eq(title)
      end
    end

    context 'when title is not present' do
      it 'returns nil' do
        expect(subject.to_s).to be nil
      end
    end
  end

  describe '#users_count' do
    context 'when there are users' do
      it 'returns a number greater than 0' do
        skills_count = 2
        subject.skills_count = skills_count
        expect(subject.users_count).to eq(skills_count)
      end
    end

    context 'when there are no users' do
      it 'returns 0' do
        skills_count = 0
        subject.skills_count = skills_count
        expect(subject.users_count).to eq(skills_count)
      end
    end
  end
end
