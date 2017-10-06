require 'rails_helper'

describe TopicsController do
  let(:topic) { Topic.new }
  let(:user) { double(:user, object: double) }

  describe 'GET show' do
    context "when there's no users assigned for that topic" do
      before do
        expect(controller).to receive(:current_user)
          .and_return(user).at_least(:once)
        expect(controller).to receive(:topic).and_return(topic).at_least(:once)
      end

      it 'redirects to topics#index' do
        get :show, id: 123
        expect(response).to redirect_to action: :index
      end
    end
  end
end
