class Share < ActiveRecord::Base
  belongs_to :area
  
  validates :user_id, :uniqueness => { scope: :area,
                                       message: "Already shared with that user." }
  
  def user_email
    if User.exists?(:id => self.user_id)
      return User.find(self.user_id).email
    else
      return 'Invalid User ID'
    end
  end
  
end
