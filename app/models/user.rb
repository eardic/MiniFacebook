class User < ActiveRecord::Base
  validates :mail, presence: true, uniqueness: true
  validates :name, :last_name, length: {minimum: 1}
  validates :birth, :gender, presence: true
  validates :password, length: {in: 6..20}

  has_many :messages, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :events, dependent: :destroy

  has_one :job, dependent: :destroy
  has_one :education, dependent: :destroy
  has_one :relationship, dependent: :destroy
  has_one :contact, dependent: :destroy

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

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE :src or last_name LIKE :src or mail LIKE :src', {:src => "%#{search}%"}])
    else
      find(:all)
    end
  end

end
