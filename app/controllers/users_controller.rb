class UsersController < ApplicationController
  expose_decorated(:users) { User.sorted }
  expose_decorated(:this_week_best_users, decorator: UserDecorator) do
    User.this_week_best_users
  end
  expose_decorated(:user) { User.find params[:id] }
  expose_decorated(:supports) { user.supports.done }
  expose_decorated(:skills) { user.skills.includes(:topic) }
end
