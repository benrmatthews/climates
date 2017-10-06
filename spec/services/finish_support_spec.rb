require 'rails_helper'

describe FinishSupport do

  let(:user) { User.new }
  let(:support) { Support.new }
  subject { described_class.new user, support }

  describe 'commence!' do

    let(:another_user) { User.new }

    before { allow(support).to receive(:save!) }

    describe 'reassigns user support' do
      context 'to user finishing the support' do
        it 'when user is some other user than the one requesting help' do
          support.user = another_user
          subject.commence!
          expect(support.user).to eq(subject.user)
        end
      end
      context 'to original user assigned to support' do
        it 'when finishing user is the one requesting help' do
          support.receiver = user
          support.user = another_user
          subject.commence!
          expect(support.user).to eq(another_user)
        end
      end
    end

    it 'finishes support' do
      subject.commence!
      expect(support).to be_done
    end

    it 'updates user counter' do
      expect{ subject.commence! }.to change{ user.supports_count }.by(1)
    end

  end

end
