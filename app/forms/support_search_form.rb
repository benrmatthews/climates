class SupportSearchForm < Reform::Form
  include Reform::Form::ActiveModel
  property :topic_id
  property :body
  property :receiver_id
  property :user_id

  attr_accessor :search_params

  def initialize(model, search_params)
    super model
    assign_params search_params
  end

  def assign_params(_search_params)
    self.search_params = _search_params || {}
    self.topic_id      = search_params[:topic_id]
    self.body          = search_params[:body]
    self.receiver_id   = search_params[:receiver_id]
    self.user_id       = search_params[:user_id]
  end

  def users
    User.decorate
  end

  def topics
    Topic.decorate
  end

  def states
    [
      ['All', :all],
      ['Done', :done],
      ['Not done', :notdone]
    ]
  end

  def state
    search_params.present? ? search_params[:state] : 'all'
  end
end
