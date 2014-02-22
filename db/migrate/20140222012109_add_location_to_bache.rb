class AddLocationToBache < ActiveRecord::Migration
  def change
    add_column :baches, :location, :string
  end
end
