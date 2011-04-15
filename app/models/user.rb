class User < ActiveRecord::Base
  
  validates :username, :length => {:minimum => 3, :maximum => 29}, :uniqueness => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :firstname, :lastname, :password, :password_confirmation, :remember_me
end
