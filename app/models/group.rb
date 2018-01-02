class Group < ApplicationRecord

	has_many :group_members, :dependent => :destroy
  has_many :users, :through => :group_members
  has_many :messages

  enum group_type: {general: 0, personal: 1}


end
