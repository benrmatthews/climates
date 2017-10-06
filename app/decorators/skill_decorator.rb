class SkillDecorator < Draper::Decorator
  decorates :skill

  def to_s
    skill.topic.to_s
  end

end
