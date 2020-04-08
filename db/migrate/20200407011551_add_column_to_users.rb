class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :string
    add_column :users, :gender_id, :integer, null: false
    add_column :users, :residence_id, :integer, null: false
  end
end
