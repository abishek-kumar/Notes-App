class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  has_many :labels, embed: :ids, include:true, key: :labels
end
