class Trash < ActiveRecord::Base
  attr_accessible :deleted_time, :note_id
end
