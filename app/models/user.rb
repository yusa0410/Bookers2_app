class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # ==============追加フォロー================

  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy, inverse_of: :follower
  has_many :followings, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy, inverse_of: :followed

  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followings, source: :follower

  def follow(other_user)
    unless self == other_user
      self.followings.find_or_create_by(follower_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.followeings.find_by(follower_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.follower_users.include?(other_user)
  end

  # ==============追加フォロー================

  validates :name, presence: true,length: {in: 2..20}, uniqueness: true
  validates :introduction,length: { maximum: 50}

  attachment :profile_image

end
