class User < ApplicationRecord
    has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
    has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
    has_many :owned_communities, class_name: 'Community', foreign_key: 'owner_id'
    has_and_belongs_to_many :communities 
    has_many :friend_requests, dependent: :destroy
    has_many :pending_friends, through: :friend_requests, source: :friend
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships

    def remove_friend(friend)
        self.friends.destroy(friend)
    end
end
