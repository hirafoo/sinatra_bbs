class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :password

      t.boolean :visible,    :null => false, :default => true
      t.boolean :deleted,    :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

