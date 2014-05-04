class Event < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :details, length: {minimum: 1}
  validates :when, presence: true
end
