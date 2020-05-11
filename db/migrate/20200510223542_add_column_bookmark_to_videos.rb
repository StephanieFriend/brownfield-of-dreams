class AddColumnBookmarkToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :bookmark, :boolean, default: false
  end
end
