class User < ActiveRecord::Base
  attr_accessible :id, :name, :password
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
end
