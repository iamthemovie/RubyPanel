class CreateVirts < ActiveRecord::Migration
  def self.up
    create_table :virts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :virts
  end
end
