class CreateGroupMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :group_members do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :is_active

      t.timestamps
    end
  end
end
