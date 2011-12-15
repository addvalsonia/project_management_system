class Organization < ActiveRecord::Base
  has_many :projects
  validates_presence_of :org_name

end
