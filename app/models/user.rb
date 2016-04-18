class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :areas
  
  include Bitfields
  
  bitfield :settings,
                    2**0 => :admin,
                    2**1 => :collapse_panels
                    

  def is_admin?
    if ( self.admin? || self.id == 1 )  
      return true
    else
      return false
    end
  end
  
end
