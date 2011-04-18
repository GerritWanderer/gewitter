class Ability
  include CanCan::Ability

  def initialize(user)
    can [:create, :destroy], [Message, Subscription], :user_id => user.id
  end
end
