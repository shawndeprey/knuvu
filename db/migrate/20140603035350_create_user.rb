class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :password
      t.string :reset_hash
      t.boolean :verified, :default => false
      t.boolean :admin, :default => false
      t.attachment :avatar
      t.timestamps
    end
  end
end