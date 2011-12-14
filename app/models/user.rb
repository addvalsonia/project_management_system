class User < ActiveRecord::Base
    
  validates_uniqueness_of :username ,:message => "username already exists."
  validates_uniqueness_of :email ,:message => "email already exists in the database."
  validates_presence_of :username, :email

  acts_as_authentic
end
