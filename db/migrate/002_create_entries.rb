class CreateEntries < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    create_table :entries do |t|
      t.references :user, :null => false
      t.string :content

      t.boolean :visible,    :null => false, :default => true
      t.boolean :deleted,    :null => false, :default => false
      t.timestamps
    end

    add_index   :entries, :user_id, :name => 'user_id'
    foreign_key :entries, :user_id, :users
  end

  def self.down
    drop_table :entries
  end
end

