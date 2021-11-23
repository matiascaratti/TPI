class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "admin"
      can :manage, :all
    elsif user.role == "assistant"
      can :read, Professional
      can :manage, Appointment
      can :cancel_all, :all 
    elsif user.role == "consultant"
      can :read, Professional
      can :read, Appointment
      can :filter_index, Appointment
    end
  end
end
