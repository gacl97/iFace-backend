class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities do |t|
      t.text :content
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
