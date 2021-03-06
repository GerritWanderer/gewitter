class Message < ActiveRecord::Base
  belongs_to :user
  default_scope :order => 'created_at DESC', :limit => '10'
  after_save :create_mentions
  
  validates :text, :length => {:minimum => 3, :maximum => 142}
  validates_presence_of :user_id
  
  private
  def create_mentions
    # Split words of the message as array and compare it with a list of existing usernames
    # extract duplicates between both arrays into a seperate array and write Mention records
    mention_usernames = User.all(:select => :username).map(&:username) & self.text.split(/\W/)
    mention_usernames.each do |mention_username|
      Mention.create!(:user_id => User.find_by_username(mention_username).id, :message_id => self.id)
    end
  end
end
