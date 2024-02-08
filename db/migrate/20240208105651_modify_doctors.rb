class ModifyDoctors < ActiveRecord::Migration[7.1]
  def change
    remove_column :doctors, :specialty, :string
  end
end
