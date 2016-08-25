class Oxdesc < ActiveRecord::Base
  belongs_to :obj
  
  validates :keywords, length: { in: 2..80 }
  validates :description, length: { minimum: 4 }#, format: { with: /\A[\x0A\x0D -}]+\z/ }
  
  validate do |oxdesc|
    oxdesc.errors.add :base, "Keywords may only contain US-ASCII characters.  Invalid characters: " + oxdesc.keywords.remove(/[\x0A\x0D -}]/) if oxdesc.keywords.remove(/[\x0A\x0D -}]/).length > 0
    oxdesc.errors.add :base, "Description may only contain US-ASCII characters.  Invalid characters: " + oxdesc.description.remove(/[\x0A\x0D -}]/) if oxdesc.description.remove(/[\x0A\x0D -}]/).length > 0
  end

end
