class AddReceiverToSupport < ActiveRecord::Migration
  def change
    add_reference :supports, :receiver, index: true
  end
end
