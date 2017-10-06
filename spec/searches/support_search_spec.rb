require 'rails_helper'

describe SupportSearch do
  before :all do
    prepare_supports
  end

  def prepare_supports
    @support ||= Support.create!(user_id: 1,
                                 topic_id: 11,
                                 receiver_id: 111,
                                 body: 'foo bar baz')
    @done_support ||= Support.create!(user_id: 2,
                                      topic_id: 22,
                                      receiver_id: 222,
                                      body: 'bingo mingo mongo',
                                      done: true)
  end

  describe '#results' do
    describe 'filters supports by' do
      let!(:support) { @support }
      let!(:done_support) { @done_support }

      it 'user_id' do
        search_attrs = { user_id: support.user_id }
        expect(SupportSearch.new(search_attrs).results).to eq [support]
      end

      it 'receiver_id' do
        search_attrs = { receiver_id: support.receiver_id }
        expect(SupportSearch.new(search_attrs).results).to eq [support]
      end

      it 'receiver_id' do
        search_attrs = { topic_id: support.topic_id }
        expect(SupportSearch.new(search_attrs).results).to eq [support]
      end

      it 'body' do
        search_attrs = { body: 'bar' }
        expect(SupportSearch.new(search_attrs).results).to eq [support]
      end

      describe "state representing" do
        it 'done supports' do
          search_attrs = { state: 'done' }
          expect(SupportSearch.new(search_attrs).results).to eq [done_support]
        end

        it 'pending supports' do
          search_attrs = { state: 'notdone' }
          expect(SupportSearch.new(search_attrs).results).to eq [support]
        end

        it 'all supports' do
          search_attrs = { state: 'all' }
          expect(SupportSearch.new(search_attrs).results).to match_array(
            [support, done_support]
          )
        end
      end
    end
  end

  describe '#paginated_results' do
    let(:search) { SupportSearch.new }

    describe 'when only page number is passed' do
      it 'it shows at least 2 records' do
        expect(search.paginated_results(1).to_a.count).to be >= 1
      end
    end

    describe 'when page number and per page number are passed' do
      it 'it shows as many records as defined per page' do
        expect(search.paginated_results(1, 1).to_a.count).to eq 1
        expect(search.paginated_results(2, 1).to_a.count).to eq 1
      end
    end
  end
end
