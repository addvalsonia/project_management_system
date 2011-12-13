class CreateOrgUsers < ActiveRecord::Migration
  def self.up
    create_table :org_users do |t|
      t.integer :organization_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :org_users
  end
end
