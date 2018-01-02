class Message < ApplicationRecord

	scope :public_messages, -> {where("message_type =?", 0)}
	scope :group_messages, -> {where("message_type =?", 1)}
	belongs_to :sender, :class_name => "User"
	belongs_to :group, optional: true

	PUBLIC_MESSAGE = 0
	GROUP_MESSAGE = 1

	enum message_type: {public_message: PUBLIC_MESSAGE, group_message: GROUP_MESSAGE}

	def as_json(options={})
		data = super
		data[:sender_name] = User.find_by_id(self.sender_id).try(:name)
		data
	end

end
