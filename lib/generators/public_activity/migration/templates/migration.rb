# Migration responsible for creating a table with activities
class CreateActivities < ActiveRecord::Migration
  # Create table
  def self.up
    create_table :activities do |t|
      t.belongs_to :trackable, :polymorphic => true
      t.belongs_to :actor, :polymorphic => true
      t.belongs_to :recipient, :polymorphic => true
      t.string  :key
      t.text    :parameters

      t.datetime :created_at
    end
    add_index :activities, :key
  end
  # Drop table
  def self.down
    drop_table :activities
  end
end
