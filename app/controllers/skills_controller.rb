class SkillsController < ApplicationController

  expose_decorated(:topics) { Topic.all }
  expose_decorated(:skills) { current_user.skills }
  expose_decorated(:topic) { Topic.find(params[:topic_id]) }


  def index
  end

  def create
    skill_registration = SkillRegistration.new(current_user.object, topic)
    skill_registration.commence!
    redirect_to skills_path
  end
end
