class Message < ActiveRecord::Base
  belongs_to :user
  
  validates :text, :length => {:minimum => 3, :maximum => 142}
  validates_presence_of :user_id
end
