class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :event_id
      t.string :nickname
      t.string :browser
      t.string :browser
      t.float :browser_version
      t.string :operating_system
      t.float :os_version
      t.integer :rating
      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
