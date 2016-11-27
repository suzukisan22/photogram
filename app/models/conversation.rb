class Conversation < ActiveRecord::Base
    belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
    belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

    validates :recipient_id, :uniqueness => {:scope => :sender_id}
    
    has_many :messages, dependent: :destroy

    scope :between, -> (:sender_id, :recipient_id) do
      where("(conversations.sender_id = ? OR conversations.recipient_id = ?) AND (conversations.sender_id = ? OR conversations.recipient_id = ?)",
              sender_id, recipient_id, recipient_id, sender_id)
    end

    def target_user(current_user)
      if sender_id == current_user.id
        User.find(recipient_id)
      elsif recipient_id == current_user.id
        User.find(sender_id)
      end
end
