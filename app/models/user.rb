class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # DM機能のアソシエーション
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  
  # フォロー機能のアソシエーション
  has_many :relationship, class_name:"Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationship, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followings, through: :relationship, source: :followed
  has_many :followers, through: :reverse_relationship, source: :follower
  
  # グループ機能のアソシエーション
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50 }
  
  
  def follow(user_id)
    relationship.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationship.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followers.include?(user)
  end
    
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
