#todo - stop persistence of user_id on update of the record
class Note < ActiveRecord::Base
  attr_accessible :content, :id, :title, :user_id

  validates :title, presence:true, length: 2..31
  validates :user_id, presence: true

  has_and_belongs_to_many :labels
  attr_accessible :labels_notes
end
