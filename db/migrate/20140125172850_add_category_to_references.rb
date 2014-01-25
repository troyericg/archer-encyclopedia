class AddCategoryToReferences < ActiveRecord::Migration
  def change
    add_column :references, :category, :string
  end
end
