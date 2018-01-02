class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :message
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :message_type #enum 0, public, 1 for group message
      t.integer :group_id
      t.timestamps
    end
  end
end
