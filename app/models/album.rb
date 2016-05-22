class Album
  include Mongoid::Document
  field :name, type: String
  field :artwork_url_100, type: String
  belongs_to :artist
end
