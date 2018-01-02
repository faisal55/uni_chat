class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :creator_id
      t.string :logo
      t.integer :group_type # enum, 0 => general, 1 => personal

      t.timestamps
    end
  end
end
