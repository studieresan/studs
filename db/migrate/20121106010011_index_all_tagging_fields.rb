class IndexAllTaggingFields < ActiveRecord::Migration
  def up
    remove_index :taggings, [:taggable_id, :taggable_type, :context]
    add_index :taggings, [:taggable_id, :taggable_type, :tag_id, :context], name: "index_taggings_on_keys"
  end

  def down
    remove_index :taggings, name: "index_taggings_on_keys"
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end
end
