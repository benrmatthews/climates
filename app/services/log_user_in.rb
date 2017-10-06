# exsting user logged in with data
# non-existing user created (dispatched to service)
class LogUserIn

  attr_accessor :session, :data, :user, :email

  def initialize session, user_hash
    self.session = session
    self.data = user_hash
    self.email = data[:email]
  end

  def commence!
    create_user unless user.present?
    session[:user_id] = user.id
  end

  def create_user
    registration.commence!
    self.user = registration.user
  end

  def user
    @user ||= email && User.find_by(email: email)
  end

  private

  def registration
    RegisterUser.new(data)
  end

end
