class CreateJoinTableCommunityUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :communities, :users do |t|
      t.index [:community_id, :user_id]
      t.index [:user_id, :community_id]
    end
  end
end
