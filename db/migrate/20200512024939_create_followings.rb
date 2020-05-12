class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|
      t.belongs_to :following_user
      t.belongs_to :followed_user
      t.index [:following_user_id, :followed_user_id], unique: true
      t.timestamps
    end
  end
end
