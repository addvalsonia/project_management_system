class AddAssignToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :assign, :boolean, :default => 0
  end

  def self.down
    remove_column :organizations, :assign
  end
end
