class HomeController < ApplicationController

  expose(:recent_supports){
    SupportDecorator.decorate_collection Support.limit(20).done.includes(:user, :receiver, :topic)
  }
  expose(:waiting_for_help){
    SupportDecorator.decorate_collection Support.limit(20).not_done.includes(:user, :receiver, :topic)
  }

end
