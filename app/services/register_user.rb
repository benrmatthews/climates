#registers users from gapps login
class RegisterUser

  attr_accessor :klass, :data, :user

  def initialize(user_hash, user_klass = User)
    self.klass = user_klass
    self.data = user_hash
  end

  def commence! # http://www.youtube.com/watch?v=HWSPaO2SN8E
    self.user = build_new_user
    user.save!
  end

  def build_new_user
    klass.new(data)
  end

end
