class ReplaceArchivedWithArchivedAtInUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end

  def up
    add_column :users, :archived_at, :datetime

    User.reset_column_information
    User.where(archived: true).update_all(archived_at: Time.zone.now)

    remove_column :users, :archived, :boolean
  end

  def down
    add_column :users, :archived, :boolean

    User.reset_column_information
    User.where.not(archived_at: nil).update_all(archived: true)

    remove_column :users, :archived_at
  end
end
