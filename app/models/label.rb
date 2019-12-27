class Label < ActiveRecord::Base
  attr_accessible :id, :name, :user_id
  has_and_belongs_to_many :notes
end
