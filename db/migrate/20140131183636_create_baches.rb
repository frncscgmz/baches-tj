class CreateBaches < ActiveRecord::Migration
  def change
    create_table :baches do |t|
      t.string :desc
      t.float :latitude
      t.float :longitude
      t.integer :user_id

      t.timestamps
    end
  end
end
