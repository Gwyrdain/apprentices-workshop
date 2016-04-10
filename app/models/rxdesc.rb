class Rxdesc < ActiveRecord::Base
  belongs_to :room
  
  validates :keywords, length: { in: 2..75 }
  validates :description, length: { minimum: 4 }#, format: { with: /\A[\x0A\x0D -~]+\z/ }
  
  validate do |rxdesc|
    rxdesc.errors.add :base, "Keywords may only contain US-ASCII characters.  Invalid characters: " + rxdesc.keywords.remove(/[ -~]/) if rxdesc.keywords.remove(/[ -~]/).length > 0
    rxdesc.errors.add :base, "Description may only contain US-ASCII characters.  Invalid characters: " + rxdesc.description.remove(/[ -~]/) if rxdesc.description.remove(/[ -~]/).length > 0
  end

end
