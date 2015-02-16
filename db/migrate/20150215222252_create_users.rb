class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :handle
      t.text :password
      t.text :email
      t.boolean :male
      t.integer :age
      t.integer :weight
      t.integer :journal_id

      t.timestamps null: false
    end
  end
end
