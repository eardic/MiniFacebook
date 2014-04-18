class User < ActiveRecord::Base
  include Gravtastic
  gravtastic :mail,:size => 160

  validates :mail, presence: true, uniqueness: true
  validates :name, :last_name, length: {minimum: 1}
  validates :birth, :gender, presence: true
  validates :password, length: {in: 6..20}

  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :jobs, dependent: :destroy

  has_one :education, dependent: :destroy
  has_one :relationship, dependent: :destroy
  has_one :contact, dependent: :destroy

  accepts_nested_attributes_for :education, :relationship, :contact,
                                :messages, :posts, :friends, :jobs, allow_destroy: true

  # @param [Object] id
  def self.get_friends(id)
    @user = self.find(id)
    friends = Array.new
    if @user
      @user.friends.each do |f|
        friends << self.find(f.friend_id)
      end
    end
    return friends
  end

end
