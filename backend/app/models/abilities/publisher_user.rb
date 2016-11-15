# frozen_string_literal: true
module Abilities
  class PublisherUser
    include CanCan::Ability

    def initialize(user)
      can :read,   ::User, id: user.id

      if user.activated?
        can :update, ::User, id: user.id
        can :manage, ::Partner
        can :manage, ::AboutSection
        can :manage, ::Event
        can :manage, ::NewsArticle
        can :manage, ::Activity
        can :manage, ::Publication
        can :manage, ::MediaContent
        can :manage, ::Vacancy
        can [:publish, :unpublish], ::MediaContent
        can [:publish, :unpublish, :make_featured, :remove_featured], ::Activity
        can [:publish, :unpublish, :make_featured, :remove_featured], ::Publication
        can [:publish, :unpublish], ::Vacancy
        can [:activate, :deactivate], ::Event
      end

      cannot :make_contributor,        ::User, id: user.id
      cannot :make_admin,              ::User, id: user.id
      cannot [:activate, :deactivate], ::User, id: user.id
    end
  end
end
