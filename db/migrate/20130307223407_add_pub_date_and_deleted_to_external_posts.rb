class AddPubDateAndDeletedToExternalPosts < ActiveRecord::Migration
  def change
    add_column :external_posts, :pubdate, :datetime
    add_column :external_posts, :deleted, :boolean, null: false, default: false
    add_index :external_posts, :pubdate, order: :desc
  end
end
