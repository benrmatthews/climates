module Features
  module GoogleAuth
    def authenticate_user(user = nil)
      user ||= User.new(email: 'test@email.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user.decorate)
    end
  end
end
