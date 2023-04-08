class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :user_name
      t.string :user_avatar
      t.string :user_email
      t.string :token

      t.timestamps
    end
  end
end
