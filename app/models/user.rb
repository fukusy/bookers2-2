class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 20}, uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォローの動き
  # フォローを取得。Relationshiopモデルのfollower_idにuser_idを格納
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id",dependent: :destroy
  # following_userという変数にfollowerを通じて、相手のfollowedを確認して取得
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # フォローワーの動き
  # フォローを取得。Relationshiopモデルのfollowed_idにuser_idを格納
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 【class_name: "Relationship"】は省略可能
  has_many :followings, through: :relationships, source: :followed


  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end


  attachment :profile_image

end
