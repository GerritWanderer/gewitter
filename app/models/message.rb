class Message < ActiveRecord::Base
  belongs_to :user
  default_scope :order => 'created_at DESC', :limit => '20'
  after_save :create_mentions
  
  validates :text, :length => {:minimum => 3, :maximum => 142}
  validates_presence_of :user_id
  
  private
  def create_mentions
    mention_usernames = User.all(:select => :username).map(&:username) & self.text.split(/\W/)
    mention_usernames.each do |mention_username|
      Mention.create!(:user_id => User.find_by_username(mention_username).id, :message_id => self.id)
    end
  end
end
