class Help < ActiveRecord::Base
  belongs_to :area

    validates :min_level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :keywords, length: { in: 4..80 }
    validates :body, length: { minimum: 4 }#, format: { with: /\A[\x0A\x0D -~]+\z/ }
    
  validate do |help|
    help.errors.add :base, "Help keywords may only contain US-ASCII characters.  Invalid characters: " + help.keywords.remove(/[\x0A\x0D -~]/) if help.keywords.remove(/[\x0A\x0D -~]/).length > 0
    help.errors.add :base, "Help body may only contain US-ASCII characters.  Invalid characters: " + help.body.remove(/[\x0A\x0D -~]/) if help.body.remove(/[\x0A\x0D -~]/).length > 0
  end

end
