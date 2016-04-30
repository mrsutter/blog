class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :post, index: true, null: false
      t.references :user
      t.timestamps null: false
    end

    add_foreign_key :comments, :posts, on_delete: :cascade
  end
end
