class AddStateToComments < ActiveRecord::Migration
  def change
    add_column :comments, :state, :string, default: 'new', null: false
  end
end
