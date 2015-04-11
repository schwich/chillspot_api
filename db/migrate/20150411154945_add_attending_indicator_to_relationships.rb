class AddAttendingIndicatorToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :attending, :boolean
  end
end
