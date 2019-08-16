class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :login
      t.string :password
      t.integer :age
      t.string :phone
      t.string :status

      t.timestamps
    end
  end
end
