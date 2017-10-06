require 'rails_helper'

describe SkipSupport do
  let(:candidates) { 2.times.map { double(:user, present?: true) } }
  let(:support) { double(:support, user: double(:user)) }
  let(:skip!) { subject.commence! }

  subject { described_class.new support }

  describe '#skip!' do
    context 'with available candidates' do
      before { allow(subject).to receive(:candidates).and_return(candidates) }

      it 'assigns and save new user to support' do
        expect(support).to receive(:user=).with any_of(candidates)
        expect(support).to receive :save!
        allow(CommentOnSupport).to receive(:new).and_return(double(commence!: true))
        allow(SupportMailer).to receive(:help_me).with(support).and_return(
          double(deliver: true))
        skip!
      end

      it 'sends email out to the new assignee' do
        allow(support).to receive(:user=).with any_of(candidates)
        allow(support).to receive :save!
        allow(CommentOnSupport).to receive(:new).and_return(double(commence!: true))
        expect(SupportMailer).to receive(:help_me).with(support).and_return(
          double(deliver: true))
        skip!
      end

      it 'leaves a comment about skipped support' do
        previous_user = support.user
        candidate = candidates.sample
        expect(subject).to receive(:candidates).and_return([candidate])
        allow(support).to receive(:user=).with candidate
        allow(support).to receive :save!
        expect(SupportMailer).to receive(:help_me).with(support).and_return(
          double(deliver: true))
        expect(CommentOnSkipping).to receive(:new).with(
          previous_user,
          support,
          support.user
        ).and_return(double(commence!: true))
        skip!
      end
    end
  end

  describe '#success?' do
    it 'is true when there are some candidates available' do
      candidate = double(:candidate)
      subject.candidates = [candidate]

      allow(support).to receive(:user=).with(candidate)
      allow(support).to receive :save!
      allow(SupportMailer).to receive(:help_me).with(support).and_return(
        double(deliver: true))
      allow(CommentOnSupport).to receive(:new).and_return(
        double(commence!: true))

      skip!

      expect(subject.success?).to be true
    end

    it 'is false when there is no candidate available' do
      subject.candidates = []
      skip!

      expect(subject.success?).to be false
    end
  end

  def any_of(allowed_values)
    satisfy do |arg|
      expect(allowed_values).to include arg
    end
  end
end

