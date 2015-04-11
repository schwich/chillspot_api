class AddCategoryAndSubCategoryToEvents < ActiveRecord::Migration
  def change
    add_column :events, :category, :string
    add_column :events, :sub_category, :string
  end
end
