class Project < ActiveRecord::Base
  belongs_to :organization
  validates_presence_of :project_name
  validates_presence_of :desc

end
