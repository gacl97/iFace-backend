class User < ApplicationRecord
    has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
    has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
    has_many :owned_communities, class_name: 'Community', foreign_key: 'owner_id'
    has_and_belongs_to_many :communities 
end
