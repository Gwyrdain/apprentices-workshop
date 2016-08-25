class Rxdesc < ActiveRecord::Base
  belongs_to :room
  
  validates :keywords, length: { in: 2..80 }
  validates :description, length: { minimum: 4 }#, format: { with: /\A[\x0A\x0D -}]+\z/ }
  
  validate do |rxdesc|
    rxdesc.errors.add :base, "Keywords may only contain US-ASCII characters.  Invalid characters: " + rxdesc.keywords.remove(/[\x0A\x0D -}]/) if rxdesc.keywords.remove(/[\x0A\x0D -}]/).length > 0
    rxdesc.errors.add :base, "Description may only contain US-ASCII characters.  Invalid characters: " + rxdesc.description.remove(/[\x0A\x0D -}]/) if rxdesc.description.remove(/[\x0A\x0D -}]/).length > 0
  end

end
