class CreatePrivateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :private_conversations do |t|

      t.timestamps
    end
  end
end
