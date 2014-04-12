class User < ActiveRecord::Base
  validates :mail, presence: true,uniqueness: true
  validates :name,:last_name, length: { minimum: 1 }
  validates :birth,:gender, presence: true
  validates :password, length: { in: 6..20 }
  has_many :messages
  has_many :post
  has_many :friend
  has_one :job
  has_one :educations
  has_one :relationship
  has_one :contact
end
