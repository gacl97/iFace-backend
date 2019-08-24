class Friendship < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship
  validate :not_self
  validate :not_friends
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

    def not_friends
      errors.add(:friend, 'is already added') if user.friends.include?(friend)
    end

    def not_self
      errors.add(:friend, "can't be equal to user") if user == friend
    end
  
    def create_inverse_relationship
      friend.friendships.create(friend: user)
    end

    def destroy_inverse_relationship
      friendship = friend.friendships.find_by(friend: user)
      friendship.destroy if friendship
    end
end
