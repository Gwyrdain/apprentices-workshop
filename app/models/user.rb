class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :areas
  
  include Bitfields
  
  bitfield :roles,
                    2**0 => :admin

  def is_admin?
    if ( self.admin? || self.id == 1 )  
      return true
    else
      return false
    end
  end
  
end
