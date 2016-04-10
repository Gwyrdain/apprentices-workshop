class Oxdesc < ActiveRecord::Base
  belongs_to :obj
  
  validates :keywords, length: { in: 2..75 }
  validates :description, length: { minimum: 4 }#, format: { with: /\A[\x0A\x0D -~]+\z/ }
  
  validate do |oxdesc|
    oxdesc.errors.add :base, "Keywords may only contain US-ASCII characters.  Invalid characters: " + oxdesc.keywords.remove(/[ -~]/) if oxdesc.keywords.remove(/[ -~]/).length > 0
    oxdesc.errors.add :base, "Description may only contain US-ASCII characters.  Invalid characters: " + oxdesc.description.remove(/[ -~]/) if oxdesc.description.remove(/[ -~]/).length > 0
  end

end
