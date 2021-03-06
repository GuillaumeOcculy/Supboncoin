class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password_digest
      t.boolean :is_admin, default: false
      t.string :phone

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username
  end
end
