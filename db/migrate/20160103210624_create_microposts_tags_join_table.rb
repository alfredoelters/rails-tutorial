class CreateMicropostsTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :microposts_tags, :id => false do |t|
      t.references :tag, index: true, foreign_key: true, null: false
      t.references :micropost, index: true, foreign_key: true, null: false
    end
    add_index :microposts_tags, [:micropost_id, :tag_id], unique: true
  end
end
