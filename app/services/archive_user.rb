class ArchiveUser
  attr_accessor :user

  def initialize(user)
    self.user = user
  end

  def commence!
    archive
    delete_skills
    user.save!
  end

  def archive
    user.archived_at = Time.zone.now
  end

  def delete_skills
    user.skills.destroy_all
  end
end
