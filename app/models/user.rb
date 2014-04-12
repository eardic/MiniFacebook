class User < ActiveRecord::Base
  validates :mail, presence: true,uniqueness: true
  validates :name,:last_name, length: { minimum: 1 }
  validates :birth,:gender, presence: true
  validates :password, length: { in: 6..20 }
  has_many :messages, dependent: :destroy
  has_many :post, dependent: :destroy
  has_many :friend, dependent: :destroy
  has_one :job, dependent: :destroy
  has_one :educations, dependent: :destroy
  has_one :relationship, dependent: :destroy
  has_one :contact, dependent: :destroy
end
