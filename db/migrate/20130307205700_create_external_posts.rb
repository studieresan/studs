class CreateExternalPosts < ActiveRecord::Migration
  def change
    create_table :external_posts do |t|
      t.string :provider, null: false
      t.string :guid, null: false
      t.string :url, null: false
      t.text :title, null: false

      t.timestamps
    end
  end
end
