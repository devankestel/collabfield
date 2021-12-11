class CreatePrivateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :private_messages do |t|

      t.timestamps
    end
  end
end
