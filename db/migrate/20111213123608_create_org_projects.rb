class CreateOrgProjects < ActiveRecord::Migration
  def self.up
    create_table :org_projects do |t|
      t.integer :organization_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :org_projects
  end
end
