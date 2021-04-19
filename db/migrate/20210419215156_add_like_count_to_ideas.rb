class AddLikeCountToIdeas < ActiveRecord::Migration[6.1]
  def change
    add_column :ideas, :like_count, :integer
  end
end
