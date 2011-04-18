class Message < ActiveRecord::Base
  belongs_to :user
  
  validates :text, :length => {:minimum => 3, :maximum => 142}
  validates_presence_of :user_id
  
  default_scope :order => 'created_at DESC', :limit => '20'
end
