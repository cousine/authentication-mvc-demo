class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :hashed_password, null: false

      t.string :password_seed, null: false

      t.timestamps
    end
  end
end
