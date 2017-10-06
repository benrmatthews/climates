require 'rake'

namespace :users do

  desc 'Archives user with a given email'
  task :archive, [:email] => :environment do |task, args|
    email = args[:email]
    if email.present?
      user = find_user_by_email email
      ArchiveUser.new(user).commence!
      puts "SUCCESS: User #{user} (#{email}) archived."
    else
      fail 'ERROR: please provide an email in order to archive user!'
    end
  end

  private

  def find_user_by_email(email)
    user = User.where(email: email).first
    if user.present?
      user
    else
      fail "ERROR: can't find user with email: '#{email}'!"
    end
  end
end
