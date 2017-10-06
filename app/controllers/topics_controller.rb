class TopicsController < ApplicationController

  expose(:support) { Support.new support_params }
  expose_decorated(:topics) { Topic.all }
  expose_decorated(:topic) { Topic.find(params[:id]) }
  expose_decorated(:random_supporter, decorator: UserDecorator) {
    topic.users.without(current_user.object).sample
  }

  before_filter :check_supporters_availability, only: :show

  def index
  end

  private

  def check_supporters_availability
    if random_supporter.nil?
      redirect_to topics_path, alert: t('topic.no_supporters')
    end
  end

  def support_params
    params.fetch(:support, {}).permit(:body)
  end
end
