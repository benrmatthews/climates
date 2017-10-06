require 'rails_helper'

describe SupportStatus do
  let(:support) { Support.new }
  subject { described_class.new support }

  describe '#to_s' do
    context 'with comments' do
      before do
        expect(support).to receive(:discussed?).and_return(true)
      end

      context "returns 'new'" do
        it 'when support is from today' do
          expect(support).to receive(:created_at).and_return(10.hours.ago)
          expect(subject.to_s).to eq 'new'
        end
      end

      context "returns 'ok'" do
        it 'when support is from today' do
          expect(support).to receive(:created_at).and_return(25.hours.ago)
          expect(subject.to_s).to eq 'ok'
        end
      end

      context "returns 'worrying'" do
        it 'when support is older than 2 days' do
          expect(support).to receive(:created_at).and_return(48.hours.ago)
          expect(subject.to_s).to eq 'worrying'
        end
      end

      context "returns 'critical'" do
        it 'when support is older than 4 days' do
          expect(support).to receive(:created_at).and_return(5.days.ago)
          expect(subject.to_s).to eq 'critical'
        end
      end
    end

    context 'without comments' do
      before do
        expect(support).to receive(:discussed?).and_return(false)
      end

      context "returns 'new'" do
        it 'when support is newer than 12h' do
          expect(support).to receive(:created_at).and_return(11.hours.ago)
          expect(subject.to_s).to eq 'new'
        end
      end

      context "returns 'ok'" do
        it 'when support is older than 12h' do
          expect(support).to receive(:created_at).and_return(13.hours.ago)
          expect(subject.to_s).to eq 'ok'
        end
      end

      context "returns 'worrying'" do
        it 'when support is older than 2 days' do
          expect(support).to receive(:created_at).and_return(2.days.ago)
          expect(subject.to_s).to eq 'worrying'
        end
      end

      context "returns 'critical'" do
        it 'when support is older than 4 days' do
          expect(support).to receive(:created_at).and_return(4.days.ago)
          expect(subject.to_s).to eq 'critical'
        end
      end
    end
  end
end
