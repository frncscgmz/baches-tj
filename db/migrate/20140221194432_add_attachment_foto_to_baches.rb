class AddAttachmentFotoToBaches < ActiveRecord::Migration
  def self.up
    change_table :baches do |t|
      t.attachment :foto
    end
  end

  def self.down
    drop_attached_file :baches, :foto
  end
end
