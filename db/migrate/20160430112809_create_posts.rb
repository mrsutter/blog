class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name, null: false
      t.text :body, null: false
      t.references :category, index: true, null: false
      t.timestamps null: false
    end

    add_foreign_key :posts, :categories, on_delete: :cascade
  end
end
