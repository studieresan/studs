class AddIndexesToExternalPosts < ActiveRecord::Migration
  def change
    add_index :external_posts, :provider
    add_index :external_posts, :guid, unique: true
  end
end
